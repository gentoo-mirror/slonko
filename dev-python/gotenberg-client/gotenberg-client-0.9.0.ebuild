# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DOCS_BUILDER="mkdocs"

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="A Python client for interfacing with the Gotenberg API"
HOMEPAGE="
	https://github.com/stumpylog/gotenberg-client
	https://pypi.org/project/gotenberg-client/
"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/httpx-0.27[${PYTHON_USEDEP}]
	dev-python/h2[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
#BDEPEND="
#	doc? (
#		dev-python/mkdocs-material[social,${PYTHON_USEDEP}]
#		dev-python/mkdocs-minify-plugin[${PYTHON_USEDEP}]
#	)
#	test? (
#		>=dev-python/pytest-httpx-0.35[${PYTHON_USEDEP}]
#		dev-python/pikepdf[${PYTHON_USEDEP}]
#	)
#"

#distutils_enable_tests pytest

DOCS=( README.md )
