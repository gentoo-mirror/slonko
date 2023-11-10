# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod-r1

DESCRIPTION="IT8705F/IT871xF/IT872xF hardware monitoring driver"
HOMEPAGE="https://github.com/frankcrawford/it87"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-2+"
SLOT="0"

CONFIG_CHECK="HWMON ~!CONFIG_SENSORS_IT87"
DOCS=(
	"${S}/README"
	"${S}/ISSUES"
)

src_compile() {
	local modlist=( it87=misc:"${S}" )
	local modargs=( TARGET="${KV_FULL}" )

	linux-mod-r1_src_compile
}
