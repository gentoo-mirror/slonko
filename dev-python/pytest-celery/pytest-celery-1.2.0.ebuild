# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )
inherit distutils-r1

DESCRIPTION="a shim pytest plugin to enable celery.contrib.pytest"
HOMEPAGE="
	https://github.com/celery/pytest-celery
	https://pypi.org/project/pytest-celery
"
SRC_URI="https://github.com/celery/pytest-celery/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/celery[${PYTHON_USEDEP}]
	>=dev-python/pytest-docker-tools-3.1.3[${PYTHON_USEDEP}]
	>=dev-python/psutil-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/tenacity-9.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/python-memcached[${PYTHON_USEDEP}]
	)
"
# Requires sphinx-mermaid
#	doc? (
#		>=dev-python/sphinx-celery-2.1.3[${PYTHON_USEDEP}]
#		>=dev-python/sphinx-click-6.0.0[${PYTHON_USEDEP}]
#	)
EPYTEST_DESELECT=(
	# Require docker
	"tests/integration"
	"tests/smoke"
)

distutils_enable_tests pytest
#distutils_enable_sphinx docs --no-autodoc

python_prepare_all() {
	# Remove coverage
	sed -i \
		-e '/--cov/d' \
		-e '/term/d' \
		pyproject.toml || die "sed failed"

	distutils-r1_python_prepare_all
}
