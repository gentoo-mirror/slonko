# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit perl-module

DESCRIPTION="XSS filter using HTML::Parser"
HOMEPAGE=""
SRC_URI="mirror://cpan/authors/id/D/DR/DRTECH/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL )"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
