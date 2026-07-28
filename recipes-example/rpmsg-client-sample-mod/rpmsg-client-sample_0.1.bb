# See also: https://github.com/openembedded/openembedded-core/blob/master/meta-skeleton/recipes-kernel/hello-mod/hello-mod_0.1.bb

SUMMARY = "Build the rpmsg_client_sample kernel module"
DESCRIPTION = "Builds the RPMsg client sample kernel module so it can be loaded with modprobe rpmsg_client_sample"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://rpmsg_client_sample.c;md5=2dd80ce6c34a4b8ccf46a47eafa9d91f"

inherit module

SRC_URI = " \
    file://Makefile \
    file://rpmsg_client_sample.c \
"

S = "${WORKDIR}"