# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="vpnc-script replacement for easy and secure split-tunnel VPN setup "
HOMEPAGE="https://github.com/dlenski/vpn-slice"
SRC_URI="https://github.com/dlenski/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/setproctitle[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
"
