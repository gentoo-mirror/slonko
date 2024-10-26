# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DOCS_BUILDER="mkdocs"
#DOCS_DEPEND="
#	dev-python/griffe-inherited-docstrings
#	dev-python/mkdocs-material
#	dev-python/mkdocstrings-python
#"

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{9..13} )

inherit distutils-r1

DESCRIPTION="Async OAuth client using HTTPX"
HOMEPAGE="https://github.com/frankie567/httpx-oauth"
SRC_URI="https://github.com/frankie567/httpx-oauth/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT-0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/httpx-0.18[${PYTHON_USEDEP}]
	<dev-python/httpx-1.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/fastapi[${PYTHON_USEDEP}]
		dev-python/respx[${PYTHON_USEDEP}]
	)
"

DOCS=( README.md )

distutils_enable_tests pytest

python_prepare_all() {
	# No need for regex-commit plugin
	sed -e '/^source.*regex_commit/d' -i pyproject.toml || die
	sed -e '/^commit_extra_args/d' -i pyproject.toml || die
	sed -e 's/,\s*"hatch-regex-commit"//g' || pyproject.toml || die
	# Disable coverage
	sed -e '/^addopts/d' -i pyproject.toml || die

	distutils-r1_python_prepare_all
}
