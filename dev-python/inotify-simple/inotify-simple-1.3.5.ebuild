# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

MY_P="${PN//-/_}-${PV}"
DESCRIPTION="Python wrapper around inotify"
HOMEPAGE="https://github.com/chrisjbillington/inotify_simple"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_sphinx doc \
	dev-python/sphinx-rtd-theme
