SUMMARY = "Build the rpmsg_client_sample kernel module"
DESCRIPTION = "Builds the RPMsg client sample kernel module so it can be loaded with modprobe rpmsg_client_sample"
LICENSE = "CLOSED"
PN = "kernel-module-rpmsg-client-sample"

SRC_URI = "file://Makefile file://rpmsg_client_sample.c"

S = "${WORKDIR}"

inherit module