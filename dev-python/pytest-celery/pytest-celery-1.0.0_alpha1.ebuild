# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV=${PV/_alpha/a}
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1

DESCRIPTION="a shim pytest plugin to enable celery.contrib.pytest"
HOMEPAGE="
	https://github.com/celery/pytest-celery
	https://pypi.org/project/pytest-celery
"
SRC_URI="https://github.com/celery/pytest-celery/archive/${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/celery-5.3.0_beta[${PYTHON_USEDEP}]"
