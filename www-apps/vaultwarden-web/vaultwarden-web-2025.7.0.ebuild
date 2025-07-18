# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Unofficial patched bitwarden web-vault builds for vaultwarden"
HOMEPAGE="https://github.com/dani-garcia/bw_web_builds"
SRC_URI="https://github.com/dani-garcia/bw_web_builds/releases/download/v${PV}/bw_web_v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/web-vault"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
PDEPEND="app-admin/vaultwarden[web]"

src_install() {
	insinto /usr/share/webapps/"${PN}"
	doins -r *
}
