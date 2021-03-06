# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils user

DESCRIPTION="A andy cache/storage server"
HOMEPAGE="http://fallabs.com/kyototycoon/"
SRC_URI="${HOMEPAGE}pkg/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples lua"

DEPEND=">=dev-db/kyotocabinet-1.2.65
	sys-libs/zlib
	app-arch/bzip2
	lua? ( dev-lang/lua )"
RDEPEND="${DEPEND}"
PATCHES=(
	"${FILESDIR}/remove_docinst.patch"
	"${FILESDIR}/fix_compile.patch"
)

pkg_setup() {
	if use !prefix ; then
		enewgroup tycoon
		enewuser tycoon -1 -1 /var/lib/${PN} tycoon
	fi
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable lua)
}

src_test() {
	emake -j1 check
}

src_install() {
	emake DESTDIR="${D}" install

	for x in /var/{lib,log}/${PN}; do
		dodir "${x}"
		use prefix || fowners tycoon:tycoon "${x}"
	done

	if use examples; then
		insinto /usr/share/${PF}/example
		doins example/*
	fi

	if use doc; then
		dohtml -r doc/*
	fi

	dodoc ChangeLog README

	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
}
