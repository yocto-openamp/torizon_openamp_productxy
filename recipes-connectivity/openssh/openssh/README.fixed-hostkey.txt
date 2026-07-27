To use a fixed ED25519 SSH host key across reflashes:

1. Generate a dedicated host key pair once:
   ssh-keygen -t ed25519 -N '' -f ssh_host_ed25519_key

2. Copy both files into this directory:
   ssh_host_ed25519_key
   ssh_host_ed25519_key.pub

3. Enable fixed host-key installation in your build config:
   PRODUCTXY_FIXED_SSH_HOSTKEY = "1"

You can set PRODUCTXY_FIXED_SSH_HOSTKEY in local.conf or in an image bbappend.

Security note:
- Anyone with the private key can impersonate your device.
- Keep ssh_host_ed25519_key private and do not publish it in public repositories.
