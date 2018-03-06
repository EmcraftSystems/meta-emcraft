DESCRIPTION = "Custom scripts for start the AVS daemons and application and other utilities for imx7d-pico board"
HOMEPAGE = "http://developer.amazon.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"
S = "${WORKDIR}"
BB_NUMBER_THREADS = "1"

DEST_ETC_DIR ?= "/etc/alexa_sdk"
DEST_SDK_DIR ?= "/home/root/Alexa_SDK" 
DEST_SCRIPTS_DIR ?= "/home/root/Alexa_SDK/Scripts"

SRC_URI = "file://alexa_sdk \
		file://cleanAVSEnv.sh \
		file://getAVSToken.sh \
		file://renewSensoryLicense.sh \
		file://setCredentials.sh \
		file://setupAVS.sh \
		file://setUTCTime.sh \
"

do_install() {
    install -d -m 0755 ${D}${DEST_ETC_DIR}
    install -d -m 0755 ${D}${DEST_SCRIPTS_DIR}
    install ${S}/*.sh ${D}${DEST_SCRIPTS_DIR}
    install ${S}/alexa_sdk/* ${D}${DEST_ETC_DIR}

	cd ${D}/${DEST_SDK_DIR}
    ln -s ${DEST_SCRIPTS_DIR}/setupAVS.sh setupAVS.sh
}

FILES_${PN} = "${DEST_ETC_DIR} ${DEST_SCRIPTS_DIR} ${DEST_SDK_DIR}"
BBCLASSEXTEND = "native"

RDEPENDS_${PN} += "bash"
