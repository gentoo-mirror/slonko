# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="33"

inherit check-reqs kernel-2
detect_version
detect_arch
SUBREL="hardened1"
HARDENED_URI="https://github.com/anthraxx/linux-hardened/releases/download/v${PV%.0}-${SUBREL}/linux-hardened-v${PV%.0}-${SUBREL}.patch"

DESCRIPTION="Minimal supplement to upstream Kernel Self Protection Project"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches https://github.com/anthraxx/linux-hardened"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${HARDENED_URI} ${ARCH_URI}"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
IUSE="experimental"
UNIPATCH_LIST="${FILESDIR}/9999_revert-conflicts-v2.patch ${DISTDIR}/linux-hardened-v${PV%.0}-${SUBREL}.patch"
UNIPATCH_EXCLUDE="1510_fs-enable-link-security-restrictions-by-default.patch"

pkg_pretend() {
	CHECKREQS_DISK_BUILD="4G"
	check-reqs_pkg_pretend
}

src_prepare() {
	kernel-2_src_prepare
	rm "${S}/tools/testing/selftests/tc-testing/action-ebpf"
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
