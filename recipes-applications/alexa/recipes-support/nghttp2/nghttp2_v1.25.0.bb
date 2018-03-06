SUMMARY = "HTTP/2 C library and tools"
HOMEPAGE = "https://nghttp2.org/"

SECTION = "console/network"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=764abdf30b2eadd37ce47dcbce0ea1ec"

SRC_URI = "git://github.com/nghttp2/nghttp2.git;branch=master;protocol=https"
SRCREV="${PV}"

S="${WORKDIR}/git"

EXTRA_OECONF = " \
	--without-cython \ 
	--enable-python-bindings=no \
"

do_install_append() {
	rmdir ${D}/usr/bin
}

inherit autotools pkgconfig
