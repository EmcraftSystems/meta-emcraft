# Copyright (C) 2018 Emcraft Systems

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_imx8mmsom3gb = " file://0001-imx8mmsom3gb.patch "
SRC_URI_append_imx8mmsom1gb = " file://0001-imx8mmsom1gb.patch "

do_compile_prepend () {
	cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}   ${S}/${SOC_DIR}/fsl-imx8mm-evk.dtb
	cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}   ${S}/${SOC_DIR}/fsl-imx8mq-evk.dtb
}


