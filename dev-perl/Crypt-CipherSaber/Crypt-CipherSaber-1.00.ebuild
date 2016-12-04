# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit perl-module

DESCRIPTION="Perl module implementing CipherSaber encryption."
HOMEPAGE="http://ciphersaber.gurus.com/"
SRC_URI="mirror://cpan/authors/id/C/CH/CHROMATIC/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64"
IUSE=""
SRC_TEST="do"

DEPEND="virtual/perl-Scalar-List-Utils
		>=dev-perl/Module-Build-0.28
		>=virtual/perl-Test-Simple-0.60
		dev-perl/Test-Warn
		dev-lang/perl"
