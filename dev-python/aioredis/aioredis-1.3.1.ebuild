# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 pypi

DESCRIPTION="asyncio (PEP 3156) Redis support"
HOMEPAGE="https://github.com/aio-libs/aioredis-py"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-python/async-timeout[${PYTHON_USEDEP}]
	dev-python/hiredis[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-db/redis
		net-misc/socat
	)
"

DOCS=( README.rst )

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Failing tests
	tests/connection_commands_test.py::test_auth
	tests/connection_test.py::test_connect_tcp_timeout
	tests/connection_test.py::test_connect_unixsocket_timeout
	tests/pool_test.py::test_create_connection_timeout
	tests/pool_test.py::test_pool_idle_close
	tests/sentinel_commands_test.py::test_master__auth
	tests/sentinel_failover_test.py::test_auto_failover
	tests/sentinel_failover_test.py::test_failover_command
	tests/server_commands_test.py::test_client_list
	tests/server_commands_test.py::test_client_list__unixsocket
	tests/server_commands_test.py::test_command_info
	tests/server_commands_test.py::test_config_set
	tests/server_commands_test.py::test_debug_object
	tests/server_commands_test.py::test_debug_sleep
	tests/stream_commands_test.py::test_xgroup_create
	tests/stream_commands_test.py::test_xgroup_create_mkstream
)

python_prepare_all() {
	sed -e '/^addopts/d' -i setup.cfg
	# Certificate needed
	rm tests/ssl_test.py

	distutils-r1_python_prepare_all
}
