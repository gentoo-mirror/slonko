# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="Unicode::CaseFold - Unicode case-folding for case-insensitive lookups."
HOMEPAGE="http://metacpan.org/release/Unicode-CaseFold"
SRC_URI="mirror://cpan/authors/id/A/AR/ARODLAND/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-1+ Artistic )"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"
SRC_TEST="do"

RDEPEND="
	>=virtual/perl-Scalar-List-Utils-1.11
	virtual/perl-Exporter
"
BDEPEND="${RDEPEND}
	dev-perl/Module-Build
	test? (
		virtual/perl-Test-Simple
	)
"
