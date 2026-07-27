SUMMARY = "Simple example executable"
DESCRIPTION = "Installs a minimal example command"
LICENSE = "MIT"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    cat > ${D}${bindir}/example << 'EOF'
#!/bin/sh
echo "example from meta-productxy"
EOF
    chmod 0755 ${D}${bindir}/example
}

FILES:${PN} = "${bindir}/example"
