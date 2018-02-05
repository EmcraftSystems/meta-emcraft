# Copyright 2018 Emcraft Systems

DESCRIPTION = "Generate Boot Loader for i.MX8 IMX8M-SOM (LPDDR3) device"

# This appends to meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/imx-mkimage/imx-boot_0.2.bb

# Use Emcraft sources
require imx-mkimage-emcraft.inc

# That's how Emcraft builds U-Boot in imx-mkimge/:
# CFLAGS= make SOC=iMX8M clean
# cp ../u-boot/u-boot-nodtb.bin iMX8M
# cp ../u-boot/arch/arm/dts/emcraft-imx8m-som.dtb iMX8M/fsl-imx8mq-ddr3l-arm2.dtb
# cp ../u-boot/u-boot.bin iMX8M
# cp ../u-boot/spl/u-boot-spl.bin iMX8M
# CFLAGS= make SOC=iMX8M flash_ddr3l_arm2

# Redefine the build target
IMXBOOT_TARGETS_mx8mq := "flash_ddr3l_arm2"

do_compile () {
    if [ "${SOC_TARGET}" = "iMX8M" ]; then
        echo "8MQ LPDDR3 IMX8M-SOM boot binary build"

        cp ${DEPLOY_DIR_IMAGE}/signed_hdmi_imx8m.bin             ${S}/${SOC_TARGET}/
        cp ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} ${S}/${SOC_TARGET}/u-boot-spl.bin
	# A trick for odd U-Boot SDcard image build
	cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/emcraft-imx8m-som.dtb  ${S}/${SOC_TARGET}/fsl-imx8mq-ddr3l-arm2.dtb
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/u-boot-nodtb.bin    ${S}/${SOC_TARGET}/
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/mkimage_uboot       ${S}/${SOC_TARGET}/

        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${S}/${SOC_TARGET}/bl31.bin
        cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${S}/${SOC_TARGET}/u-boot.bin

    elif [ "${SOC_TARGET}" = "iMX8QM" ]; then
        echo 8QM boot binary build
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${SC_MACHINE_NAME}  ${S}/${SOC_TARGET}/scfw_tcm.bin
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${S}/${SOC_TARGET}/bl31.bin
        cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${S}/${SOC_TARGET}/u-boot.bin

        cp ${DEPLOY_DIR_IMAGE}/imx8qm_m4_0_TCM_rpmsg_lite_pingpong_rtos_linux_remote.bin ${S}/${SOC_TARGET}/m40_tcm.bin
        cp ${DEPLOY_DIR_IMAGE}/imx8qm_m4_1_TCM_rpmsg_lite_pingpong_rtos_linux_remote.bin ${S}/${SOC_TARGET}/m41_tcm.bin

    else
        echo 8QX boot binary build
        cp ${DEPLOY_DIR_IMAGE}/imx8qx_m4_hello_world.bin         ${S}/${SOC_TARGET}/m40_tcm.bin
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${SC_MACHINE_NAME}  ${S}/${SOC_TARGET}/scfw_tcm.bin
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${S}/${SOC_TARGET}/bl31.bin
        cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${S}/${SOC_TARGET}/u-boot.bin
    fi

    # mkimage for i.MX8
    for target in ${IMXBOOT_TARGETS}; do
        echo "building ${SOC_TARGET} - ${target}"
        make SOC=${SOC_TARGET} ${target}
        if [ -e "${S}/${SOC_TARGET}/flash.bin" ]; then
            cp ${S}/${SOC_TARGET}/flash.bin ${S}/${BOOT_CONFIG_MACHINE}-${target}
        fi
    done
}
