# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools bash-completion-r1

DESCRIPTION="Universal Game Trainer"
HOMEPAGE="https://github.com/ugtrain/ugtrain"
if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	S="${WORKDIR}/${P}"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"
LICENSE="GPL-3"
RESTRICT="!test? ( test )"
IUSE="bash-completion examples glib multilib test"

RDEPEND="
	dev-util/scanmem
	sys-devel/binutils
"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--with-bash-completion-dir=$(usex bash-completion $(get_bashcompdir))
		$(use_enable glib)
		$(use_enable multilib)
		$(use_enable test testing)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
