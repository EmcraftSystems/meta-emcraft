# Copyright 2018 Emcraft Systems

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = "${CONFIG_SRC_URI_IMXMKIM}"
SRCREV = "${CONFIG_IMXMKIM_GIT_REV}"

# Released under the MIT license (see COPYING.MIT for the terms)

S = "${CONFIG_IMXMKIM_S}"
