# Copyright (C) 2018 Emcraft Systems

DESCRIPTION = "i.MX Linux suppporting Emcraft i.MX8M SOM boards."

# This appends to meta-fsl-bsp-release/imx/meta-bsp/recipes-kernel/linux/linux-imx_4.9.51.bb

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# IMX8M-SOM kernel configuration and Device Tree
SRC_URI = "${CONFIG_SRC_URI_KERNEL} \
	file://imx8m-som.kernel \
	file://imx8m-som.dts \
	"

# Released under the MIT license (see COPYING.MIT for the terms)

S = "${CONFIG_LINUX_S}"
SRCREV = "${CONFIG_LINUX_GIT_REV}"

# For linux-imx build, kernel configuration installs as defconfig
do_subst_cfg() {
	cp -a ${WORKDIR}/imx8m-som.dts ${S}/arch/arm64/boot/dts/
	cp -a ${WORKDIR}/imx8m-som.kernel ${S}/arch/arm64/configs/defconfig
}

addtask subst_cfg after do_unpack before do_copy_defconfig

# Remove videodev2.h from the installed kernel headers, it is provided by other package.
# Otherwise, bitbake complains.
IMX_UAPI_HEADERS_remove = "videodev2.h"
LOCALVERSION = "${CONFIG_LINUX_LOCALVERSION}"
