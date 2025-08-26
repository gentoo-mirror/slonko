# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

MY_PN="${PN//-/_}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Python wrapper around inotify"
HOMEPAGE="https://github.com/chrisjbillington/inotify_simple"
SRC_URI="https://github.com/chrisjbillington/${MY_PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme
