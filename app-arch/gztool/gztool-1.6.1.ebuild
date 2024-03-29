# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="GZIP files indexer, compressor and data retriever."
HOMEPAGE="https://github.com/circulosmeos/gztool"
SRC_URI="https://github.com/circulosmeos/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}
