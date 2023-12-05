# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1

DESCRIPTION="Audit log app for Django"
HOMEPAGE="https://github.com/jazzband/django-auditlog"
SRC_URI="https://github.com/jazzband/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		dev-python/psycopg:2[${PYTHON_USEDEP}]
	)
	test? (
		dev-db/postgresql[server]
		dev-python/freezegun[${PYTHON_USEDEP}]
	)
"

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

distutils_enable_sphinx docs/source \
	dev-python/sphinx-rtd-theme

python_test() {
	local db="${T}/pgsql"

	initdb --username=postgres -D "${db}" || die
	pg_ctl -w -D "${db}" start \
		-o "-h '127.0.0.1' -p 5432 -k '${T}'" || die
	psql -h "${T}" -U postgres -d postgres \
		-c "ALTER ROLE postgres WITH PASSWORD '';" || die
	createdb -h "${T}" -U postgres auditlog || die

	"${EPYTHON}" -m django test -v2 --settings=auditlog_tests.test_settings || die "Tests fail with ${EPYTHON}"

	pg_ctl -w -D "${db}" stop || die
}
