/*
 * This is a user-space application that draws a test picture on a 32bpp
 * framebuffer device.
 */

#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>

#include <sys/mman.h>
#include <sys/ioctl.h>

#include <linux/fb.h>
#include <linux/types.h>

#ifndef min
#define min(a,b) ((a) < (b) ? (a) : (b))
#endif

#ifndef max
#define max(a,b) ((a) > (b) ? (a) : (b))
#endif

static __u32 *fbp;
static long int screensize;
static struct fb_var_screeninfo vinfo;
static struct fb_fix_screeninfo finfo;

static void fb_putpixel(void *buf, int x, int y, __u32 color);

/*
 * Measure the maximum FPS
 */
static void test_performance()
{
	int i;
	clock_t start;

	start = clock();

	/*
	 * Fill the framebuffer 256 times
	 */
	for (i = 0; i < 256; i++)
		memset(fbp, i, screensize);

	start = clock() - start;

	printf("%s: Filled the framebuffer 256 times in %d.%02d seconds\n",
		__func__,
		start / CLOCKS_PER_SEC,
		(start / (CLOCKS_PER_SEC / 100)) % 100);
}

#define FB_32BIT_B_BITS		0
#define FB_32BIT_B_BITWIDTH	8
#define FB_32BIT_G_BITS		(FB_32BIT_B_BITS + FB_32BIT_B_BITWIDTH)
#define FB_32BIT_G_BITWIDTH	8
#define FB_32BIT_R_BITS		(FB_32BIT_G_BITS + FB_32BIT_G_BITWIDTH)
#define FB_32BIT_R_BITWIDTH	8

#define FB_16BIT_B_BITS		0
#define FB_16BIT_B_BITWIDTH	5
#define FB_16BIT_G_BITS		(FB_16BIT_B_BITS + FB_16BIT_B_BITWIDTH)
#define FB_16BIT_G_BITWIDTH	6
#define FB_16BIT_R_BITS		(FB_16BIT_G_BITS + FB_16BIT_G_BITWIDTH)
#define FB_16BIT_R_BITWIDTH	5

#define CONVERT_COLOR_COMPONENT(color,bpp,comp) \
	(((color >> (FB_32BIT_## comp ##_BITS + \
	FB_32BIT_## comp ##_BITWIDTH - FB_## bpp ##BIT_## comp ##_BITWIDTH)) & \
	((1 << FB_## bpp ##BIT_## comp ##_BITWIDTH) - 1)) << \
	FB_## bpp ##BIT_## comp ##_BITS)

static void fb_putpixel(void *buf, int x, int y, __u32 color)
{
	if (x < 0 || y < 0 && x >= vinfo.xres && y >= vinfo.yres)
		return;

	if (vinfo.bits_per_pixel == 32) {
		/*
		 * We set the bits 24..31 to 0xFF which represents opacity in
		 * ARGB8888 to make the image 100% opaque. This does not break
		 * compatibility with platforms that do not support alpha
		 * component (e.g. Kinetis K61/K70) because their LCD
		 * controllers do not look in this fourth byte.
		 */
		((__u32 *)buf)[y * vinfo.xres + x] = 0xFF000000 | color;
	} else if (vinfo.bits_per_pixel == 24) {
		((__u8 *)buf)[3 * (y * vinfo.xres + x) + 0] = color >>  0;
		((__u8 *)buf)[3 * (y * vinfo.xres + x) + 1] = color >>  8;
		((__u8 *)buf)[3 * (y * vinfo.xres + x) + 2] = color >> 16;
	} else if (vinfo.bits_per_pixel == 16) {
		((__u16 *)buf)[y * vinfo.xres + x] =
			CONVERT_COLOR_COMPONENT(color, 16, R) |
			CONVERT_COLOR_COMPONENT(color, 16, G) |
			CONVERT_COLOR_COMPONENT(color, 16, B);
	} else {
		fprintf(stderr,
			"This program supports only 16bpp and 32bpp "
			"framebuffers.\n");
		exit(4);
	}
}

/*
 * Draw color stripes, solid and dashed lines and a grayscale
 */
static void test_picture()
{
	void *buf;
	int x, y;
	int scale;
	/* Brightness */
	__u8 br;

	/*
	 * Colors of vertical stripes
	 */
	const __u32 colors[] = {
		0xFF0000,
		0xFF8000,
		0xFFFF00,
		0x0000FF,
		0x008000,
		0x800080,
		0xFFFFFF,
		0x000000};
	const int num_colors = sizeof(colors) / sizeof(colors[0]);

	/*
	 * Allocate a pixmap buffer to speed up drawing
	 */
	buf = malloc(screensize);

	/*
	 * Draw color stripes
	 */
	for (y = 0; y < vinfo.yres; y++)
		for (x = 0; x < vinfo.xres; x++)
			fb_putpixel(buf, x, y,
				colors[(x * num_colors) / vinfo.xres]);

	/*
	 * Diagonal line
	 */
	for (x = 0; x < min(vinfo.xres, vinfo.yres); x++)
		fb_putpixel(buf, x, x, 0xFFFFFF);	/* White */

	/*
	 * Left and right borders
	 */
	for (y = 0; y < vinfo.yres; y++) {
		fb_putpixel(buf, 0, y, 0xFFFFFF);
		fb_putpixel(buf, vinfo.xres - 1, y, 0xFFFFFF);
	}

	/*
	 * Horizontal lines
	 */
	for (x = 0; x < vinfo.xres; x++) {
		/* Top border (white with green dots) */
		fb_putpixel(buf, x, 0, (x & 3) ? 0xFFFFFF : 0x00B000);
		/* Horizontal line in the middle (white with green dots) */
		fb_putpixel(buf, x, vinfo.yres / 2,
			(x & 7) ? 0xFFFFFF : 0x00B000);
		/* Bottom border */
		fb_putpixel(buf, x, vinfo.yres - 1, 0xFFFFFF);
	}

	/*
	 * Grayscale
	 */
	scale = 256 / max(vinfo.xres - 50, 0) + 1;
	br = 0;
	for (x = vinfo.xres - 5 - 256 / scale; x < vinfo.xres - 5; x++, br++)
		for (y = vinfo.yres / 6; y < vinfo.yres / 3; y++)
			fb_putpixel(buf, x, y, br | (br << 8) | (br << 16));

	/*
	 * Copy the prepared pixmap to the framebuffer
	 */
	memcpy(fbp, buf, screensize);

	free(buf);
}

int main(int argc, char *argv[])
{
	int fd;

	static const char *option_string = "pc";
	int opt;
	int run_perf_test = 0, cyclic_on_exit = 0;

	/*
	 * Parse the command-line options
	 */
	opt = getopt( argc, argv, option_string);
	while (opt != -1) {
		switch (opt) {
		case 'p':
			run_perf_test = 1;
			break;
		case 'c':
			cyclic_on_exit = 1;
			break;
		default:
			break;
		}

		opt = getopt(argc, argv, option_string);
	}

	/*
	 * Open the framebuffer device file
	 */
	fd = open("/dev/fb0", O_RDWR);
	if (fd == -1) {
		perror("Error: cannot open framebuffer device");
		exit(1);
	}

	/*
	 * Get fixed screen information
	 */
	if (ioctl(fd, FBIOGET_FSCREENINFO, &finfo) == -1) {
		perror("Error reading fixed information");
		exit(2);
	}

	/*
	 * Get variable screen information
	 */
	if (ioctl(fd, FBIOGET_VSCREENINFO, &vinfo) == -1) {
		perror("Error reading variable information");
		exit(3);
	}

	printf("%dx%d, %dbpp\n", vinfo.xres, vinfo.yres, vinfo.bits_per_pixel);
	if (vinfo.bits_per_pixel != 32 && vinfo.bits_per_pixel != 24 &&
	    vinfo.bits_per_pixel != 16) {
		fprintf(stderr,
			"This program supports only 16/24/32bpp"
			"framebuffers.\n");
		exit(4);
	}

	/*
	 * Figure out the size of the screen in bytes
	 */
	screensize = vinfo.xres * vinfo.yres * vinfo.bits_per_pixel / 8;

	/*
	 * Map the device to memory
	 */
	fbp = (__u32 *)mmap(
		0, screensize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if ((int)fbp == -1) {
		perror("Error: failed to map framebuffer device to memory");
		exit(5);
	}

	printf("The framebuffer can be accessed at the address %p\n", fbp);

	/*
	 * Measure the memory write speed
	 */
	if (run_perf_test)
		test_performance();

	/*
	 * Draw the test picture
	 */
	test_picture();

	if (cyclic_on_exit) {
		printf("Press Ctrl-C to exit\n");
		while (1);
	}

	munmap(fbp, screensize);
	close(fd);
	return 0;
}
