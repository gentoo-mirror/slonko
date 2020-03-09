# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="Perl extension for assessing password quality."
HOMEPAGE="https://metacpan.org/release/Data-Password"
SRC_URI="mirror://cpan/authors/id/R/RA/RAZINF/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
