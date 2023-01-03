# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 optfeature

DESCRIPTION="Portalocker is a library to provide an easy API to file locking."
HOMEPAGE="https://github.com/evansd/whitenoise"
SRC_URI="https://github.com/evansd/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

DEPEND="
	dev-python/django[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		app-arch/brotli[python,${PYTHON_USEDEP}]
	)
"

pkg_postinst() {
	optfeature "brotli compression" "app-arch/brotli[python]"
}
