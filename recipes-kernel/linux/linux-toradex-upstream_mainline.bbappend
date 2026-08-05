# The upstream mainline recipe uses AUTOREV and resolves refs during parsing.
# git.kernel.org intermittently fails TLS negotiation in the crops container,
# so use the GitHub mirror for the same torvalds/linux repository instead.
LINUX_REPO = "git://github.com/torvalds/linux.git"