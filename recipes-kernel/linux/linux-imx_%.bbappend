FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-RM7276-Port-NAVQ-board-support-to-NXP-BSP-6.6.52_2.2.patch \
            file://devtool-fragment.cfg \
            file://0002-RM-7316-Add-M4-support-for-NAVQ-board-in-the-NXP-BSP.patch \
            file://0003-RM7377-Enabled-support-for-BCM43455-WiFi-BT-chip-Typ.patch \
            "
KERNEL_MODULE_AUTOLOAD += "imx_rpmsg_tty"
