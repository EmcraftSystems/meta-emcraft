DESCRIPTION = "Putty tools"
LICENSE = "MIT"
#LIC_FILES_CHKSUM = "file://LICENSE;md5=2f01b20bdd10071169353497037988ac"
LIC_FILES_CHKSUM ="file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI[md5sum] = "79ea4d468c5e43740d5c8d94f12af19c"
SRC_URI[sha256sum] = "bb8aa49d6e96c5a8e18a057f3150a1695ed99a24eef699e783651d1f24e7b0be"
SRC_URI = "https://the.earth.li/~sgtatham/putty/latest/putty-0.70.tar.gz"

S = "${WORKDIR}/${PN}-${PV}"

do_configure() {
	cd ${S}/unix
	# Comment out the CC definition to take the Yocto wise
	sed -i -- 's/CC = $(TOOLPATH)cc/#CC = $(TOOLPATH)cc/' Makefile.ux
	./configure --host=${TARGET_SYS}
}

do_compile() {
	cd ${S}/unix
	make -f Makefile.ux LDFLAGS="-Wl,--no-as-needed,-ldl"
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${S}/unix/testbn ${D}${bindir}
	install -m 0755 ${S}/unix/puttygen ${D}${bindir}
	install -m 0755 ${S}/unix/plink ${D}${bindir}
	install -m 0755 ${S}/unix/osxlaunch ${D}${bindir}
	install -m 0755 ${S}/unix/fuzzterm ${D}${bindir}
	install -m 0755 ${S}/unix/pscp ${D}${bindir}
	install -m 0755 ${S}/unix/psftp ${D}${bindir}
}
