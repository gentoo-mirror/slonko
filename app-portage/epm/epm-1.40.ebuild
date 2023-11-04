# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 prefix

DESCRIPTION="rpm workalike for Gentoo Linux"
HOMEPAGE="https://github.com/fuzzyray/epm"

EGIT_REPO_URI="https://github.com/ganto/epm.git"
EGIT_COMMIT="df329631d9be14305a5cc5484a03c06012a9cc0f"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eprefixify epm
	eapply_user
}

src_compile() {
	pod2man epm > epm.1 || die "pod2man failed"
}

src_install() {
	dobin epm || die
	doman epm.1
}
