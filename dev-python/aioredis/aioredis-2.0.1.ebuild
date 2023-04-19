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
		dev-python/pytest-asyncio
	)
"

DOCS=( README.md CHANGELOG.md )

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Failing tests
	tests/test_commands.py::TestRedisCommands::test_acl_getuser_setuser
	tests/test_commands.py::TestRedisCommands::test_acl_list
	tests/test_commands.py::TestRedisCommands::test_config_set
	tests/test_commands.py::TestRedisCommands::test_readwrite
	tests/test_commands.py::TestRedisCommands::test_xclaim_trimmed
	tests/test_commands.py::TestRedisCommands::test_xgroup_create
	tests/test_commands.py::TestRedisCommands::test_xgroup_create_mkstream
	tests/test_commands.py::TestRedisCommands::test_xgroup_setid
	tests/test_connection_pool.py::TestConnection::test_busy_loading_disconnects_socket
	tests/test_connection_pool.py::TestConnection::test_busy_loading_from_pipeline
	tests/test_connection_pool.py::TestConnection::test_busy_loading_from_pipeline_immediate_command
	tests/test_connection_pool.py::TestConnection::test_connect_invalid_password_supplied
	tests/test_connection_pool.py::TestConnection::test_connect_no_auth_supplied_when_required
	tests/test_connection_pool.py::TestConnection::test_read_only_error
)

python_prepare_all() {
	echo -e '[tool:pytest]\nasyncio_mode = auto' >> setup.cfg

	distutils-r1_python_prepare_all
}

src_test() {
	local redis_pid="${T}"/redis.pid
	local redis_port=6379

	einfo "Spawning Redis"
	einfo "NOTE: Port ${redis_port} must be free"
	"${EPREFIX}"/usr/sbin/redis-server - <<-EOF || die
		daemonize yes
		pidfile ${redis_pid}
		port ${redis_port}
		bind 127.0.0.1
	EOF

	# Run the tests
	distutils-r1_src_test

	# Clean up afterwards
	kill "$(<"${redis_pid}")" || die
}
