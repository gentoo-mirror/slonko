# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 optfeature

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
	>=dev-python/asgiref-3.2.10[${PYTHON_USEDEP}]
	dev-python/channels[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	>=dev-python/redis-4.5.3[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-db/redis
		dev-python/async-timeout[${PYTHON_USEDEP}]
		>=dev-python/cryptography-1.3.0[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)
"

DOCS=( README.rst )

distutils_enable_tests pytest

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

pkg_postinst() {
	optfeature "Backend encrytion support" dev-python/cryptography
}
