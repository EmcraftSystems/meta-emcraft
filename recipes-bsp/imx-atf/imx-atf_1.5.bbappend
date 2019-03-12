# Copyright (C) 2019 Emcraft Systems

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_imx8mmsom3gb = " file://0001-imx8mmsom3gb.patch "
SRC_URI_append_imx8mmsom1gb += " file://0001-imx8mmsom1gb.patch "
