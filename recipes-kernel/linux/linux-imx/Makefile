# Copyright (C) Emcraft Systems 2018
#
# Makefile for standalone Linux development:
# $ export INSTALL_ROOT=/tmp/develdir
# $ export SAMPLE=imx8m-som
# $ make		# Build Image and DTB using $SAMPLE.kernel and $SAMPLE.dts.
#			  Also,	builds and installs kernel modules to build-tmpdir/
# $ make myboard.Image	# Build Image using myboard.kernel
# $ make myboard.dtb	# Build DTB using myboard.dts

INSTALL_ROOT	:= /work/psl/IMX8M/linux-imx6sx-2.3.4
SAMPLE		:= imx8m-som

KERNEL_IMAGE	:= Image
MAKE		:= make -j10
RFS_BUILD_DIR	:= build-tmpdir


KERNEL_CONFIG	:= kernel$(if $(MCU),.$(MCU))
KERNEL_DTS	:= dts$(if $(MCU),.$(MCU))$(if $(BRD),.$(BRD))
KERNEL_LD	:= lds$(if $(MCU),.$(MCU))
KERNEL_BOOT	:= $(INSTALL_ROOT)/linux/arch/$(ARCH)/boot


# Path to the kernel modules directory in context of which
# these loadable modules are built
KERNELDIR	:=  $(INSTALL_ROOT)/linux


all:		$(SAMPLE).$(KERNEL_IMAGE) $(SAMPLE).dtb modules


modules:
	LDFLAGS="" $(MAKE) -C $(INSTALL_ROOT)/linux modules
	LDFLAGS="" $(MAKE) INSTALL_MOD_PATH=`pwd`/$(RFS_BUILD_DIR) \
		-C $(KERNELDIR) modules_install
	tar -C /$(RFS_BUILD_DIR) -c -z -f kernel_modules.tgz lib

%.dtb:		$(wildcard *.dts)
	cp *.$(KERNEL_DTS) $(KERNEL_BOOT)/dts/
	$(MAKE) -C $(KERNELDIR) $@
	mv $(KERNEL_BOOT)/dts/$@ ./$@

%.$(KERNEL_IMAGE):	%.kernel $(INSTALL_ROOT)/linux/Makefile
	cp -f $*.kernel $(INSTALL_ROOT)/linux/.config
	$(MAKE) -C $(KERNELDIR) oldconfig
	LDFLAGS="" $(MAKE) -C $(KERNELDIR) $(KERNEL_IMAGE) LOADADDR=0x80008000 ${RELEASE_BUILD_FLAGS}
	cp -f $(KERNEL_BOOT)/$(KERNEL_IMAGE) $*.$(KERNEL_IMAGE)

clean:		kclean
	rm -rf *.$(KERNEL_IMAGE) *.dtb \
		$(RFS_BUILD_DIR) kernel_modules.tgz

kclean:
	$(MAKE) -C $(INSTALL_ROOT)/linux clean
	rm -rf $(KERNEL_BOOT)/dts/emcraft.dts

kmenuconfig:
	cp -f $(SAMPLE).$(KERNEL_CONFIG) \
			$(INSTALL_ROOT)/linux/.config
	$(MAKE) -C $(INSTALL_ROOT)/linux menuconfig
	cp -f $(INSTALL_ROOT)/linux/.config \
			./$(SAMPLE).$(KERNEL_CONFIG)
