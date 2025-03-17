SUMMARY = "Qt example which run after system booting"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-or-later;md5=fed54355545ffd980b814dab4a3b312c"
#FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
inherit systemd
SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} = "run-qtdemo.service"

SRC_URI = "file://run-qtdemo.service \
           file://run-qtdemo.sh \
	   "
SYSTEMD_SERVICE:${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'run-qtdemo.service', '', d)}"
S = "${WORKDIR}"

IMXSOC = "IMX8MM"

do_install:append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then    
	install -d ${D}${sbindir}
	install -m 0755 ${S}/run-qtdemo.sh ${D}${sbindir}/run-qtdemo.sh

	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${S}/run-qtdemo.service ${D}${systemd_unitdir}/system
    fi
}
