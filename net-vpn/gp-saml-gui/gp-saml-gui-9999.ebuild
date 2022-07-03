# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8,9,10} )
inherit distutils-r1 git-r3

DESCRIPTION="Interactively authenticate to GlobalProtect VPNs that require SAML"
HOMEPAGE="https://github.com/dlenski/gp-saml-gui"

EGIT_REPO_URI="https://github.com/dlenski/gp-saml-gui.git"
KEYWORDS="~amd64"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	net-libs/webkit-gtk
	net-vpn/openconnect
"
