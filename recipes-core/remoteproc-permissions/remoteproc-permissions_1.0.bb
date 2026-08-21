SUMMARY = "Grant torizon access to remoteproc firmware controls"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://99-productxy-remoteproc-permissions.rules \
    file://productxy-remoteproc-permissions \
"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/99-productxy-remoteproc-permissions.rules ${D}${sysconfdir}/udev/rules.d/

    install -d ${D}${libexecdir}
    install -m 0755 ${WORKDIR}/productxy-remoteproc-permissions ${D}${libexecdir}/
}

FILES:${PN} = " \
    ${sysconfdir}/udev/rules.d/99-productxy-remoteproc-permissions.rules \
    ${libexecdir}/productxy-remoteproc-permissions \
"