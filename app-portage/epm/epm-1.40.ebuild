# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="7"

inherit eutils prefix

DESCRIPTION="rpm workalike for Gentoo Linux"
HOMEPAGE="https://github.com/fuzzyray/epm"
S="${WORKDIR}/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

src_unpack() {
	:
}

src_prepare() {
	cp "${FILESDIR}"/epm ${S}/epm
	epatch "${FILESDIR}"/${P}-prefix.patch
	eprefixify epm
}

src_compile() {
	pod2man epm > epm.1 || die "pod2man failed"
}

src_install() {
	dobin epm || die
	doman epm.1
}
