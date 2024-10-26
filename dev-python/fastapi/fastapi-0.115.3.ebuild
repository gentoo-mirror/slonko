# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="FastAPI framework, high performance, easy to learn, ready for production"
HOMEPAGE="
	https://fastapi.tiangolo.com/
	https://pypi.org/project/fastapi/
	https://github.com/fastapi/fastapi
"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"

RESTRICT="test"

RDEPEND="
	>=dev-python/pydantic-1.7.4[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.40.0[${PYTHON_USEDEP}]
	<dev-python/starlette-0.42.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.8.0[${PYTHON_USEDEP}]
"

pkg_postinst() {
	optfeature "commandline interface" dev-python/fastapi-cli
	optfeature "test client" dev-python/httpx
	optfeature "templates" dev-python/jinja
	optfeature "forms and file uploads" dev-python/python-multipart
	optfeature "validate emails" dev-python/email-validator
	optfeature "uvicorn with uvloop" dev-python/uvicorn
	optfeature_header "Alternative JSON responses"
	optfeature "ORJSONResponse" dev-python/orjson
	optfeature "UJSONResponse" dev-python/ujson
}
