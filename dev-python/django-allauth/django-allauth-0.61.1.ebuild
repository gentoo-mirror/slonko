# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 optfeature pypi

DESCRIPTION="Django 3rd party (social) account authentication"
HOMEPAGE="
	https://www.intenct.nl/projects/django-allauth/
	https://github.com/pennersr/django-allauth/
	https://pypi.org/project/django-allauth/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/django-3.2[${PYTHON_USEDEP}]
	>=dev-python/python3-openid-3.0.8[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-1.7[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
"
# cryptography via pyjwt[crypto]
RDEPEND+="
	dev-python/cryptography[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/pillow-9.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-django-4.5.2[${PYTHON_USEDEP}]
		>=dev-python/qrcode-7.0.0[${PYTHON_USEDEP}]
		>=dev-python/python3-saml-1.15.0[${PYTHON_USEDEP}]
		<dev-python/python3-saml-2.0.0[${PYTHON_USEDEP}]
	)
"

DOCS=( README.rst AUTHORS ChangeLog.rst )

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

src_test() {
	# Require internet access
	rm allauth/socialaccount/providers/openid/tests.py || die
	distutils-r1_src_test
}

python_test() {
	local -x DJANGO_SETTINGS_MODULE=test_settings
	local -x PYTHONPATH=.
	django-admin test -v 2 || die "Tests failed with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "SAML authentication" dev-python/python3-saml
	optfeature "MFA (Multi-factor authentication)" dev-python/qrcode
}
