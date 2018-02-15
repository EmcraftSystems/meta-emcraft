# Copyright (C) 2018 Emcraft Systems
#
# Qt5 Emcraft Demo project

LICENSE = "BSD & MIT"
LIC_FILES_CHKSUM = "file://content/cube_3d.js;beginline=8;endline=47;md5=bfead8a4f8000c6205fa2b3c54b75a22"
LIC_FILES_CHKSUM = "file://content/gl-matrix.js;beginline=8;endline=49;md5=bfead8a4f8000c6205fa2b3c54b75a22"

DEPENDS = "qtdeclarative qtgraphicaleffects qtcanvas3d qtmultimedia"

inherit qmake5 systemd

SYSTEMD_PACKAGES = "${PN}"

do_install_append () {
	install -d ${D}${systemd_system_unitdir}
	install ${WORKDIR}/qt5-emcraft-demo.service ${D}${systemd_system_unitdir}
}

FILES_${PN} = "${systemd_system_unitdir}"
FILES_${PN} += "${bindir}"
FILES_${PN} += "${datadir}"
