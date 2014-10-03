# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $$

EAPI="5"

MODULE_AUTHOR=ALIAN
inherit perl-module

DESCRIPTION="Provide routine to transform a HTML page in a MIME-Lite mail"

LICENSE="|| ( Artistic )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST=do

DEPEND="dev-lang/perl
	>=dev-perl/MIME-Lite-1.0
	dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/URI
	virtual/perl-Test-Simple"
