# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..13} )

inherit distutils-r1

DESCRIPTION="Sane and flexible OpenAPI schema generation for Django REST framework."
HOMEPAGE="https://github.com/tfranzel/drf-spectacular"
SRC_URI="https://github.com/tfranzel/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/django-2.2[${PYTHON_USEDEP}]
	>=dev-python/djangorestframework-3.10.3[${PYTHON_USEDEP}]
	>=dev-python/inflection-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
	>=dev-python/uritemplate-2.0.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		dev-python/django-filter[${PYTHON_USEDEP}]
		dev-python/drf-spectacular-sidecar[${PYTHON_USEDEP}]
		dev-python/psycopg[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/furo

EPYTEST_IGNORE=(
	# Requires dj-rest-auth
	tests/contrib/test_rest_auth.py
	# Requires django-oauth-toolkit
	tests/contrib/test_oauth_toolkit.py
	# Requires django-rest-knox
	tests/contrib/test_knox_auth_token.py
	# Requires django-rest-polymorphic
	tests/contrib/test_rest_polymorphic.py
	# Requires djangorestframework-simplejwt
	tests/contrib/test_simplejwt.py
	# Requires djangorestframework-camel-case
	tests/contrib/test_djangorestframework_camel_case.py
	# Requires djangorestframework-dataclasses
	tests/contrib/test_rest_framework_dataclasses.py
	# Requires djangorestframework-gis
	tests/contrib/test_rest_framework_gis.py
	# Requires djangorestframework-recursive
	tests/contrib/test_rest_framework_recursive.py
	# Requires drf-jwt
	tests/contrib/test_drf_jwt.py
	# Requires drf-nested-routers
	tests/contrib/test_drf_nested_routers.py
)

EPYTEST_DESELECT=(
	# Requires django-oauth-toolkit
	tests/test_specification_extensions.py::test_security_spec_extensions
)
