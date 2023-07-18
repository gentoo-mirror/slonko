# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit bash-completion-r1 distutils-r1 optfeature

MY_PV="${PV/_/}"
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
	>=dev-python/billiard-4.1.0[${PYTHON_USEDEP}]
	<dev-python/billiard-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.2[${PYTHON_USEDEP}]
	<dev-python/click-9.0.0[${PYTHON_USEDEP}]
	>=dev-python/click-didyoumean-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/click-plugins-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/click-repl-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]
	>=dev-python/kombu-5.3.1[${PYTHON_USEDEP}]
	<dev-python/kombu-6.0[${PYTHON_USEDEP}]
	>=dev-python/pytz-2022.7[${PYTHON_USEDEP}]
	>=dev-python/vine-5.0.0[${PYTHON_USEDEP}]
	<dev-python/vine-6.0.0[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		$(python_gen_impl_dep 'ncurses(+)')
		>=dev-python/boto3-1.26.143[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/elasticsearch-py[${PYTHON_USEDEP}]
		>=dev-python/moto-4.1.11[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/pylibmc[${PYTHON_USEDEP}]
		>=dev-python/pymongo-4.0.2[${PYTHON_USEDEP}]
		dev-python/pytest-celery[${PYTHON_USEDEP}]
		dev-python/pytest-click[${PYTHON_USEDEP}]
		>=dev-python/pytest-subtests-0.11.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-timeout-1.4.2[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/sphinx-testing[${PYTHON_USEDEP}]
		dev-python/tblib[${PYTHON_USEDEP}]
		sci-astronomy/pyephem[${PYTHON_USEDEP}]
	)
"
	#doc? (
	#	dev-python/docutils[${PYTHON_USEDEP}]
	#	>=dev-python/sphinx-celery-2.0.0[${PYTHON_USEDEP}]
	#	>=dev-python/sphinx-click-4.4.0[${PYTHON_USEDEP}]
	#	dev-python/jinja[${PYTHON_USEDEP}]
	#	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	#)

distutils_enable_tests pytest
#distutils_enable_sphinx docs --no-autodoc

EPYTEST_DESELECT=(
	# Failing tests
	t/unit/backends/test_elasticsearch.py::test_ElasticsearchBackend::test_backend_concurrent_update
	t/unit/backends/test_elasticsearch.py::test_ElasticsearchBackend::test_exception_safe_to_retry
	t/unit/utils/test_platforms.py::test_fd_by_path
	t/unit/utils/test_platforms.py::test_DaemonContext::test_open
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
	optfeature "redis support" dev-python/redis
	optfeature "auth support" dev-python/pyopenssl
	optfeature "pyro support" dev-python/Pyro4
	optfeature "yaml support" dev-python/pyyaml
	optfeature "memcache support" dev-python/pylibmc
	optfeature "mongodb support" dev-python/pymongo
	optfeature "sqlalchemy support" dev-python/sqlalchemy
	optfeature "sqs support" dev-python/boto
	#optfeature "cassandra support" dev-python/cassandra-driver
}
