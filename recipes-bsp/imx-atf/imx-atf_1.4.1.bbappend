# Copyright (C) 2018 Emcraft Systems

# This appends to meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/imx-atf/imx-atf_1.4.1.bb
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
	file://0001-ATF-support-to-different-LPDDR4-configurations.patch \
	file://imx-atf-dont-wait-forever-industrial.patch \
	"
