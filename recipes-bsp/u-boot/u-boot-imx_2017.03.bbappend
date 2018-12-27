# Copyright (C) 2018 Emcraft Systems

# This appends to meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/u-boot/u-boot-imx_2017.03.bb

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DESCRIPTION = "Emcraft version of U-Boot for IMX8MMINI SOM"
SRC_URI = "${CONFIG_SRC_URI_UBOOT}"

S = "${CONFIG_UBOOT_S}"
SRCREV = "${CONFIG_UBOOT_GIT_REV}"

SCMVERSION = "n"
