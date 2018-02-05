# Copyright (C) 2018 Emcraft Systems

DESCRIPTION = "i.MX Linux suppporting Emcraft IMX8M-SOM board."

# This appends to meta-fsl-bsp-release/imx/meta-bsp/recipes-kernel/linux/linux-imx_4.9.51.bb

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# IMX8M-SOM kernel configuration and Device Tree
SRC_URI = "${MX8_DOWNLOADS}/linux-emcraft-${PV}-mx8.tar.gz \
	file://imx8m-som.kernel \
	file://imx8m-som.dts \
	"

# Released under the MIT license (see COPYING.MIT for the terms)
SRC_URI[md5sum] = "327801724f9bea0de475fc3d97aa56cd"
SRC_URI[sha256sum] = "32592ea680015968711afd09691ee60d7b71bd3ccc4b2d316a90421b6334211c"

S = "${WORKDIR}/linux"

# For linux-imx build, kernel configuration installs as defconfig
do_subst_cfg() {
	cp -a ${WORKDIR}/imx8m-som.dts ${S}/arch/arm64/boot/dts/
	cp -a ${WORKDIR}/imx8m-som.kernel ${S}/arch/arm64/configs/defconfig
}

addtask subst_cfg after do_unpack before do_patch

# Remove videodev2.h from the installed kernel headers, it is provided by other package.
# Otherwise, bitbake complains.
IMX_UAPI_HEADERS_remove = "videodev2.h"
