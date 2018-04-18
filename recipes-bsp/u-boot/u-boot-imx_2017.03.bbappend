# Copyright (C) 2018 Emcraft Systems

# This appends to meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/u-boot/u-boot-imx_2017.03.bb

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DESCRIPTION = "i.MX U-Boot suppporting Emcraft IMX8M-SOM board."
SRC_URI = "${CONFIG_SRC_URI_UBOOT}"

S = "${CONFIG_UBOOT_S}"
SRCREV = "${CONFIG_UBOOT_GIT_REV}"

SCMVERSION = "n"
