# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils prefix

DESCRIPTION="rpm workalike for Gentoo Linux"
HOMEPAGE="https://github.com/fuzzyray/epm"
S="${WORKDIR}/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

PATCHES=(
	"${FILESDIR}/${P}-prefix.patch"
)
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

src_unpack() {
	:
}

src_prepare() {
	cp "${FILESDIR}"/epm "${S}"/epm
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
