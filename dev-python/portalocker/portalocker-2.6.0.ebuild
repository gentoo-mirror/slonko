# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Portalocker is a library to provide an easy API to file locking."
HOMEPAGE="https://github.com/WoLpH/portalocker"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-db/redis
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx doc
distutils_enable_tests pytest

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
	optfeature "redis support" dev-python/redis
}
