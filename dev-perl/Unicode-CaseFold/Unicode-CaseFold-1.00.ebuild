# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="Unicode::CaseFold - Unicode case-folding for case-insensitive lookups."
HOMEPAGE="http://metacpan.org/release/Unicode-CaseFold"
SRC_URI="mirror://cpan/authors/id/A/AR/ARODLAND/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-1+ Artistic )"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=virtual/perl-Scalar-List-Utils-1.11
		>=dev-perl/Module-Build-0.360.1
		virtual/perl-Exporter
		virtual/perl-Test-Simple
		dev-lang/perl"
