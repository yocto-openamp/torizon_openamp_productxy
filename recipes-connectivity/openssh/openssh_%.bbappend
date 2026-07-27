FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

# Set this to "1" to embed fixed ED25519 host keys from this layer.
# Required files when enabled:
#   recipes-connectivity/openssh/openssh/ssh_host_ed25519_key
#   recipes-connectivity/openssh/openssh/ssh_host_ed25519_key.pub
PRODUCTXY_FIXED_SSH_HOSTKEY ?= "0"

SRC_URI:append = "${@' file://ssh_host_ed25519_key file://ssh_host_ed25519_key.pub' if d.getVar('PRODUCTXY_FIXED_SSH_HOSTKEY') == '1' else ''}"

do_install:append() {
    if [ "${PRODUCTXY_FIXED_SSH_HOSTKEY}" = "1" ]; then
        install -d ${D}${sysconfdir}/ssh
        install -m 0600 ${WORKDIR}/ssh_host_ed25519_key ${D}${sysconfdir}/ssh/ssh_host_ed25519_key
        install -m 0644 ${WORKDIR}/ssh_host_ed25519_key.pub ${D}${sysconfdir}/ssh/ssh_host_ed25519_key.pub
        install -m 0600 ${WORKDIR}/ssh_host_ecdsa_key ${D}${sysconfdir}/ssh/ssh_host_ecdsa_key
        install -m 0644 ${WORKDIR}/ssh_host_ecdsa_key.pub ${D}${sysconfdir}/ssh/ssh_host_ecdsa_key.pub
        install -m 0600 ${WORKDIR}/ssh_host_rsa_key ${D}${sysconfdir}/ssh/ssh_host_rsa_key
        install -m 0644 ${WORKDIR}/ssh_host_rsa_key.pub ${D}${sysconfdir}/ssh/ssh_host_rsa_key.pub
    fi
}
