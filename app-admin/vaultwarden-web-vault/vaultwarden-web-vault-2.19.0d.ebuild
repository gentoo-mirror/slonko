# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Unofficial patched bitwarden web-vault builds for vaultwarden"
HOMEPAGE="https://github.com/dani-garcia/bw_web_builds"
SRC_URI="https://github.com/dani-garcia/bw_web_builds/releases/download/v${PV}/bw_web_v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${P}.tar.gz" || die
	S="${WORKDIR}"
}

src_install() {
	insinto /usr/share/vaultwarden-web-vault/htdocs
	doins -r web-vault/*
}
