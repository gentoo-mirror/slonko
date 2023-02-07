# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="236"

inherit kernel-2
detect_version
detect_arch
SUBREL="hardened1"
HARDENED_URI="https://github.com/anthraxx/linux-hardened/releases/download/${PV}-${SUBREL}/linux-hardened-${PV}-${SUBREL}.patch"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches https://github.com/anthraxx/linux-hardened"
IUSE="experimental"
UNIPATCH_LIST="${DISTDIR}/linux-hardened-${PV}-${SUBREL}.patch"
UNIPATCH_EXCLUDE="1510_fs-enable-link-security-restrictions-by-default.patch"

DESCRIPTION="Minimal supplement to upstream Kernel Self Protection Project"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${HARDENED_URI} ${ARCH_URI}"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
