# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

MY_P=${P/-/_}
DESCRIPTION="Provides Django Channels channel layers that use Redis as a backing store."
HOMEPAGE="https://github.com/django/channels_redis"
SRC_URI="https://github.com/django/${PN/-/_}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-python/aioredis-1.0[${PYTHON_USEDEP}]
	<dev-python/aioredis-2.0[${PYTHON_USEDEP}]
	>=dev-python/asgiref-3.2.10[${PYTHON_USEDEP}]
	<dev-python/asgiref-4.0[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	<dev-python/channels-4.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-db/redis
		dev-python/async_generator[${PYTHON_USEDEP}]
		dev-python/async-timeout[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	)
"
#	>=dev-python/cryptography-1.3.0[${PYTHON_USEDEP}]

DOCS=( README.rst )

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	tests/test_core.py::test_send_receive
	tests/test_core.py::test_send_capacity
	tests/test_core.py::test_process_local_send_receive
	tests/test_core.py::test_reject_bad_channel
	tests/test_core.py::test_reject_bad_client_prefix
	tests/test_core.py::test_group_send_capacity
	tests/test_core.py::test_group_send_capacity_multiple_channels
	tests/test_pubsub.py::test_send_receive
	tests/test_pubsub.py::test_send_receive_sync
	tests/test_pubsub.py::test_multi_send_receive
	tests/test_pubsub.py::test_multi_send_receive_sync
	tests/test_pubsub.py::test_groups_basic
	tests/test_pubsub.py::test_groups_same_prefix
	tests/test_pubsub.py::test_receive_on_non_owned_general_channel
	tests/test_pubsub.py::test_random_reset__channel_name
	tests/test_pubsub.py::test_loop_instance_channel_layer_reference
	tests/test_pubsub.py::test_serialize
	tests/test_pubsub.py::test_deserialize
	tests/test_pubsub.py::test_multi_event_loop_garbage_collection
	tests/test_pubsub.py::test_proxied_methods_coroutine_check
)

python_prepare_all() {
	# Remove sentinel tests
	rm tests/test{_pubsub,}_sentinel.py

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
