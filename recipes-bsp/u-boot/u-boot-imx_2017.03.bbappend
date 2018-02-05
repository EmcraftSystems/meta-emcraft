# Copyright (C) 2018 Emcraft Systems

# This appends to meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/u-boot/u-boot-imx_2017.03.bb

DESCRIPTION = "i.MX U-Boot suppporting Emcraft IMX8M-SOM board."
SRC_URI = "${MX8_DOWNLOADS}/u-boot-emcraft-${PV}-mx8.tar.gz"

SRC_URI[md5sum] = "5f1a02dfe1646763acc9f0f83fc64323"
SRC_URI[sha256sum] = "d3f81ec40f5131c32c08d73eb8eb25a9c7fc58387fc2006934a527ce46ddd50a"

S = "${WORKDIR}/u-boot"
SCMVERSION = "n"

do_deploy_append_mx8mq () {
    # Deploy the mkimage, u-boot-nodtb.bin and emcraft-imx8m-som.dtb for mkimage to generate boot binary
    if [ -n "${UBOOT_CONFIG}" ]
    then
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]
                then
                    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
                    install -m 0777 ${B}/${config}/arch/arm/dts/emcraft-imx8m-som.dtb  ${DEPLOYDIR}/${BOOT_TOOLS}/
                    install -m 0777 ${B}/${config}/tools/mkimage  ${DEPLOYDIR}/${BOOT_TOOLS}/mkimage_uboot
                    install -m 0777 ${B}/${config}/u-boot-nodtb.bin  ${DEPLOYDIR}/${BOOT_TOOLS}
                fi
            done
            unset  j
        done
        unset  i
    fi

}
