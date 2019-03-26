# Copyright (C) 2018 Emcraft Systems
#
# Qt5 Emcraft Demo project
#
# Git version

require qt5-emcraft-demo.inc
CONFIG_QTDEMO_BRANCH ?= "master"
#SRC_URI = "git://ocean.emcraft.com/SR/git/A2F/qmldemo.git;protocol=ssh;branch=${CONFIG_QTDEMO_BRANCH}"
SRC_URI = "git://git@github.com/EmcraftSystems/qt5-emcraft-demo.git;protocol=ssh;branch=${CONFIG_QTDEMO_BRANCH}"
SRC_URI += "file://qt5-emcraft-demo.service"
SRCREV = "${AUTOREV}"
S="${WORKDIR}/git"

PROVIDES="${PN}-git"
