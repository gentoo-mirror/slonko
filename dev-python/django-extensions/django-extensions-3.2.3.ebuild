# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="A collection of custom extensions for the Django Framework"
HOMEPAGE="https://github.com/django-extensions/django-extensions"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/django-3.2[${PYTHON_USEDEP}]
	dev-python/pyasyncore[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/shortuuid[${PYTHON_USEDEP}]
"
#BDEPEND="
#	test? (
#		dev-python/pytest-django[${PYTHON_USEDEP}]
#	)
#"
DOCS=( README.rst CHANGELOG.md )

#distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc

#src_prepare() {
#	sed -i -e 's/--nomigrations .*//' setup.cfg || die
#	# Requires pip
#	rm -f tests/management/commands/test_pipchecker.py
#	# Requires factory
#	rm -f tests/test_admin_filter.py
#	# Requires smtpd (dead battery)
#	rm -f tests/management/commands/test_export_emails.py
#
#	default
#}
