# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# There are no official releases
CHECKSUM="03f50e343d796e492e6579a11143a085429d7f5d"

DESCRIPTION="single-file public domain (or MIT licensed) libraries for C/C++"
HOMEPAGE="https://github.com/nothings/stb"
SRC_URI="https://github.com/nothings/stb/archive/${CHECKSUM}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( MIT Unlicense )"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

S="${WORKDIR}/${PN}-${CHECKSUM}"

src_prepare() {
	default

	# Move the header files in a folder so they don't pollute the include dir
	mkdir stb || die
	mv *.h stb/ || die
}

src_install() {
	doheader -r stb
}
