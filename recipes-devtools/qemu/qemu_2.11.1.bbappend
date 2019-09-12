# Copyright (C) 2019 Emcraft Systems

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://kernel-headers-5.2.patch \
	       "