#!/bin/sh

# This triplet is defined in
#   https://salsa.debian.org/kernel-team/linux/tree/master/debian/config/<ARCH>/
# and its sub-directories.
# Here is just an example
ARCH=arm64
FEATURESET=none
FLAVOUR=arm64

export $(dpkg-architecture -a$ARCH)
export PATH=/usr/lib/ccache:$PATH
# Build profiles is from: https://salsa.debian.org/kernel-team/linux/blob/master/debian/README.source
export DEB_BUILD_PROFILES="cross nopython nodoc pkg.linux.notools"
# Enable build in parallel
export MAKEFLAGS="-j$(($(nproc)*2))"
# Disable -dbg (debug) package is only possible when distribution="UNRELEASED" in debian/changelog
export DEBIAN_KERNEL_DISABLE_DEBUG=
[ "$(dpkg-parsechangelog --show-field Distribution)" = "UNRELEASED" ] &&
  export DEBIAN_KERNEL_DISABLE_DEBUG=yes

make -f debian/rules clean && \
make -f debian/rules orig && \
make -f debian/rules source && \
make -f debian/rules.gen setup_${ARCH}_${FEATURESET}_${FLAVOUR} && \
make -f debian/rules.gen binary-arch_${ARCH}_${FEATURESET}_${FLAVOUR}
