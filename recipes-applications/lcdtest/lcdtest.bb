# Copyright (C) 2018 Emcraft Systems

# A simplest LCD patterns test

SRC_URI = "file://lcdtest.c \
           file://Makefile"

LICENSE = "CLOSED"

S = "${WORKDIR}/"

do_compile() {
    make
}

do_install() {
    install -d ${D}/${bindir}
    install ${WORKDIR}/lcdtest ${D}/${bindir}/
}

FILES_${PN} += "${bindir}/lcdtest"

