SUMMARY = "A tool for exploring each layer in a Docker image"
HOMEPAGE = "https://github.com/wagoodman/dive"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=04f58d1f6e2a5f553ba23f759bd991e3"

COMPATIBLE_HOST = "aarch64.*-linux"

SRC_URI = "https://github.com/wagoodman/dive/releases/download/v${PV}/dive_${PV}_linux_arm64.tar.gz;sha256sum=2fcd2cf20f634ccdb41efac44048b204bfc867c115641f37a7420693ed480a18"
S = "${WORKDIR}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/dive ${D}${bindir}/dive
    install -D -m 0644 ${S}/LICENSE ${D}${datadir}/licenses/${PN}/LICENSE
}

FILES:${PN} += "${datadir}/licenses/${PN}"

INSANE_SKIP:${PN} += "already-stripped ldflags"
