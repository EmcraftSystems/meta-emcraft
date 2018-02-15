# Copyright (C) 2018 Emcraft Systems
#
# Qt5 Emcraft Demo project
#
# Git version

require qt5-emcraft-demo.inc

SRC_URI = "git://ocean.emcraft.com/SR/git/A2F/qmldemo.git;protocol=ssh;branch=master"
SRC_URI += "file://qt5-emcraft-demo.service"
SRCREV = "${AUTOREV}"
S="${WORKDIR}/git"

PROVIDES="${PN}-git"
