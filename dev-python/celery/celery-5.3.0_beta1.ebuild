# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit bash-completion-r1 distutils-r1 optfeature

MY_PV="${PV/_beta/b}"
DESCRIPTION="Asynchronous task queue/job queue based on distributed message passing"
HOMEPAGE="
	https://celeryproject.org/
	https://pypi.org/project/celery/
	https://github.com/celery/celery
"
SRC_URI="https://github.com/celery/celery/archive/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="
	>=dev-python/billiard-3.6.4.0[${PYTHON_USEDEP}]
	<dev-python/billiard-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.2[${PYTHON_USEDEP}]
	<dev-python/click-9.0.0[${PYTHON_USEDEP}]
	>=dev-python/click-didyoumean-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/click-plugins-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/click-repl-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/kombu-5.3.0_beta1[${PYTHON_USEDEP}]
	<dev-python/kombu-6.0[${PYTHON_USEDEP}]
	>=dev-python/pytz-2021.3[${PYTHON_USEDEP}]
	>=dev-python/vine-5.0.0[${PYTHON_USEDEP}]
	<dev-python/vine-6.0.0[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		$(python_gen_impl_dep 'ncurses(+)')
		>=dev-python/boto3-1.9.178[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/elasticsearch-py[${PYTHON_USEDEP}]
		>=dev-python/moto-2.2.6[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/pylibmc[${PYTHON_USEDEP}]
		>=dev-python/pymongo-4.0.2[${PYTHON_USEDEP}]
		dev-python/pytest-celery[${PYTHON_USEDEP}]
		dev-python/pytest-click[${PYTHON_USEDEP}]
		dev-python/pytest-subtests[${PYTHON_USEDEP}]
		>=dev-python/pytest-timeout-1.4.2[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
		dev-python/redis-py[${PYTHON_USEDEP}]
		dev-python/sphinx-testing[${PYTHON_USEDEP}]
		dev-python/tblib[${PYTHON_USEDEP}]
		sci-astronomy/pyephem[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/docutils[${PYTHON_USEDEP}]
		>=dev-python/sphinx_celery-2.0.0[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc

EPYTEST_DESELECT=(
	# Failing tests
	t/unit/contrib/test_sphinx.py::test_sphinx
)

python_install_all() {
	# Main celeryd init.d and conf.d
	newinitd "${FILESDIR}/celery.initd-r2" celery
	newconfd "${FILESDIR}/celery.confd-r2" celery

	if use examples; then
		docinto examples
		dodoc -r examples/.
		docompress -x "/usr/share/doc/${PF}/examples"
	fi

	newbashcomp extra/bash-completion/celery.bash "${PN}"

	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "msgpack support" dev-python/msgpack
	#optfeature "rabbitmq support" dev-python/librabbitmq
	#optfeature "slmq support" dev-python/softlayer_messaging
	#optfeature "couchbase support" dev-python/couchbase
	optfeature "redis support" dev-python/redis-py
	optfeature "auth support" dev-python/pyopenssl
	optfeature "pyro support" dev-python/Pyro4
	optfeature "yaml support" dev-python/pyyaml
	optfeature "memcache support" dev-python/pylibmc
	optfeature "mongodb support" dev-python/pymongo
	optfeature "sqlalchemy support" dev-python/sqlalchemy
	optfeature "sqs support" dev-python/boto
	#optfeature "cassandra support" dev-python/cassandra-driver
}
