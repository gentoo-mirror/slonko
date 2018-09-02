# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Greylisting policy daemon for Postfix"
HOMEPAGE="http://www.kim-minh.com/pub/greyfix"
SRC_URI="http://www.kim-minh.com/pub/greyfix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="doc"

RDEPEND="sys-libs/db"
DEPEND="${RDEPEND}"
