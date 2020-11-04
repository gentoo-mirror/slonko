# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Greylisting policy daemon for Postfix"
HOMEPAGE="http://www.kim-minh.com/pub/greyfix"
SRC_URI="http://www.kim-minh.com/pub/greyfix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="sys-libs/db:="
DEPEND="${RDEPEND}"
