FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Initial-port-of-i.MX8MM-NAVQ-board-support.patch \
            file://0001-RM7482-Enabled-pullups-on-UART2-console-pins.patch \
            "

