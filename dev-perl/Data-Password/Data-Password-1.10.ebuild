# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-module

DESCRIPTION="Perl extension for assessing password quality."
HOMEPAGE="https://metacpan.org/release/Data-Password"
SRC_URI="mirror://cpan/authors/id/R/RA/RAZINF/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~am~x86 ~amd64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
