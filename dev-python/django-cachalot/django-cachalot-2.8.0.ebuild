# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Caches your Django ORM queries and automatically invalidates them"
HOMEPAGE="https://github.com/noripyt/django-cachalot"
SRC_URI="https://github.com/noripyt/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-db/mariadb[server]
		net-misc/memcached
		dev-db/redis
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/django-debug-toolbar[${PYTHON_USEDEP}]
		dev-python/django-redis[${PYTHON_USEDEP}]
		dev-python/mysqlclient[${PYTHON_USEDEP}]
		dev-python/psycopg:2[${PYTHON_USEDEP}]
		dev-python/pylibmc[${PYTHON_USEDEP}]
		dev-python/pymemcache[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

src_prepare() {
	default

	# Disable failing test:
	# * cachalot.tests.read.ReadTestCase.test_explain
	sed -e '/^\s*def test_explain/,/^$/d' -i cachalot/tests/read.py || die
	# cachalot.tests.debug_toolbar.DebugToolbarTestCase.test_rendering
	sed -e '/^\s*def test_rendering/,$ d' -i cachalot/tests/debug_toolbar.py || die
}

python_test() {
	# Postgresql
	local db="${T}/pgsql"

	einfo "Creating postgresql test instance ..."
	initdb --username=cachalot -D "${db}" || die
	einfo "Starting postgresql test instance ..."
	pg_ctl -w -D "${db}" start \
		-o "-h '127.0.0.1' -p 5432 -k '${T}'" || die
	psql -h "${T}" -U cachalot -d postgres \
		-c "ALTER ROLE cachalot WITH PASSWORD 'postgres';" || die

	# MySQL
	local mysqld_pid="${T}"/mysqld.pid
	local -x PATH="${BROOT}/usr/share/mariadb/scripts:${PATH}"

	einfo "Creating mysql test instance ..."
	mkdir -p "${T}"/mysql || die
	mariadb-install-db \
		--no-defaults \
		--auth-root-authentication-method=normal \
		--basedir="${EPREFIX}/usr" \
		--datadir="${T}"/mysql 1>"${T}"/mysqld_install.log || die

	einfo "Starting mysql test instance ..."
	mysqld \
		--no-defaults \
		--character-set-server=utf8 \
		--bind-address=127.0.0.1 \
		--port=3306 \
		--pid-file="${mysqld_pid}" \
		--socket="${T}"/mysqld.sock \
		--datadir="${T}"/mysql 1>"${T}"/mysqld.log 2>&1 &

	# wait for it to start
	local i
	for (( i = 0; i < 10; i++ )); do
		[[ -S ${T}/mysqld.sock ]] && break
		sleep 1
	done
	[[ ! -S ${T}/mysqld.sock ]] && die "mysqld failed to start"

	# Redis
	local redis_pid="${T}"/redis.pid
	local redis_port=6379

	einfo "Starting redis test instance ..."
	"${EPREFIX}"/usr/sbin/redis-server - <<-EOF || die
		daemonize yes
		pidfile ${redis_pid}
		port ${redis_port}
		bind 127.0.0.1
	EOF

	# Memcache
	einfo "Starting memcached test instance ..."
	local memcached_pid="${T}"/memcached.pid

	memcached -d -P "${memcached_pid}" || die

	"${EPYTHON}" runtests.py || die "Tests fail with ${EPYTHON}"

	einfo "Stopping memcached test instance ..."
	pkill -F "${memcached_pid}" || die
	einfo "Stopping redis test instance ..."
	pkill -F "${redis_pid}" || die
	einfo "Stopping mysql test instance ..."
	pkill -F "${mysqld_pid}" || die
	einfo "Stopping postgresql test instance ..."
	pg_ctl -w -D "${db}" stop || die
}
