# This appends to poky/meta/recipes-core/base-files/base-files_3.0.14.bb

# Use Emcraft version of /etc/profile and /etc/hostname
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Create /etc/issue
EMCRAFT_DISTRO_NAME ?= "Emcraft IMX8M-SOM Release Distro"
EMCRAFT_DISTRO_VERSION ?= "(NXP ${DISTRO_VERSION})"

do_install_append () {
	if [ "${hostname}" ]; then
		echo ${hostname} > ${D}${sysconfdir}/hostname
	fi

	install -m 644 ${WORKDIR}/issue*  ${D}${sysconfdir}
        if [ -n "${EMCRAFT_DISTRO_NAME}" ]; then
		printf "${EMCRAFT_DISTRO_NAME} " >> ${D}${sysconfdir}/issue
		printf "${EMCRAFT_DISTRO_NAME} " >> ${D}${sysconfdir}/issue.net
		if [ -n "${EMCRAFT_DISTRO_VERSION}" ]; then
			printf "${EMCRAFT_DISTRO_VERSION} " >> ${D}${sysconfdir}/issue
			printf "${EMCRAFT_DISTRO_VERSION} " >> ${D}${sysconfdir}/issue.net
		fi
		printf "\\\n \\\l\n" >> ${D}${sysconfdir}/issue
		echo >> ${D}${sysconfdir}/issue
		echo "%h"    >> ${D}${sysconfdir}/issue.net
		echo >> ${D}${sysconfdir}/issue.net
	fi
}
