# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
PYTHON_COMPAT=( python3_{10..13} )

inherit cmake distutils-r1

DESCRIPTION="Library for fast text representation and classification"
HOMEPAGE="https://github.com/facebookresearch/fastText"
SRC_URI="https://github.com/facebookresearch/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

CDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="python? ( ${PYTHON_DEPS}
		${CDEPEND} )"
DEPEND="python? ( ${CDEPEND} )"
BDEPEND="
	${DISTUTILS_DEPS}
	python? ( dev-python/pybind11[${PYTHON_USEDEP}] )
"
PATCHES=( "${FILESDIR}/gcc-13.patch" )

src_prepare() {
	cmake_src_prepare
	use python && distutils-r1_src_prepare

	sed -i  -e "/CMAKE_CXX_FLAGS/d" \
		-e "s/\(DESTINATION\) lib/\1 $(get_libdir)/g" \
		CMakeLists.txt || die "sed failed for CMakeLists.txt"
	sed -i "/extra_compile_args=/,+1d" setup.py \
		|| die "sed failed for setup.py"
	sed -r -e 's|np.array\(([^,]*),\s*copy=False\)|np.asarray(\1)|g' -i python/fasttext_module/fasttext/FastText.py \
		|| die "sed failed for FastText.py"
}

python_prepare_all() {
	# fix QA
	sed -i '/description/s/-/_/' setup.cfg || die "sed failed for setup.cfg"
	distutils-r1_python_prepare_all
}

src_configure() {
	cmake_src_configure
	use python && distutils-r1_src_configure
}

src_compile() {
	cmake_src_compile
	use python && distutils-r1_src_compile
}

src_test() {
	use python && distutils-r1_src_test
}

python_test() {
	"${EPYTHON}" runtests.py -u || die "test fails"
}

src_install() {
	cmake_src_install
	use python && distutils-r1_src_install

	find "${ED}" -name '*.a' -delete || die "find failed"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + \
		|| die "test removing failed"
}
