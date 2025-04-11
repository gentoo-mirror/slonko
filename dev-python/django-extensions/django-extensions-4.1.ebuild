# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="A collection of custom extensions for the Django Framework"
HOMEPAGE="https://github.com/django-extensions/django-extensions"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/django-4.2[${PYTHON_USEDEP}]
	dev-python/pyasyncore[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/shortuuid[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/aiosmtpd[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
	)
"
DOCS=( README.rst CHANGELOG.md )

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

EPYTEST_IGNORE=(
	# No fixture named 'group' found.
	tests/management/commands/test_set_fake_emails.py
	tests/management/commands/test_set_fake_passwords.py
	# Requires factory
	tests/management/commands/shell_plus_tests/test_import_subclasses.py
	tests/test_admin_filter.py
	# Requires smtpd (dead battery)
	tests/management/commands/test_export_emails.py
	# no such table: django_extensions_permmodel
	tests/test_dumpscript.py
	tests/management/commands/test_syncdata.py
	tests/management/commands/test_validate_templates.py
)

EPYTEST_DESELECT=(
	tests/management/commands/test_runserver_plus.py::test_initialize_runserver_plus
)

src_prepare() {
	sed -i \
		-e 's/--cov=django_extensions//' \
		-e 's/--cov-report html//' \
		-e 's/--cov-report term//' \
		pyproject.toml || die

	default
}
