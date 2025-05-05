# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit cmake python-single-r1

DESCRIPTION="C++ Multi-format 1D/2D barcode image processing library"
HOMEPAGE="https://github.com/zxing-cpp/zxing-cpp"
SRC_URI="
	https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	test? (
		https://github.com/zxing-cpp/zxing-cpp/releases/download/v${PV}/test_samples.tar.gz
			-> ${P}-test-samples.tar.gz
		)
"

LICENSE="Apache-2.0"
SLOT="0/3"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv ~x86"
IUSE="experimental python test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

RDEPEND="
	experimental? (
		media-libs/zint:=
	)
	python? ( ${PYTHON_DEPS} )
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	${RDEPEND}
	python? ( $(python_gen_cond_dep 'dev-python/pybind11[${PYTHON_USEDEP}]') )
	test? (
		dev-cpp/gtest
		dev-libs/libfmt
		dev-libs/stb
	)
"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	if use test ; then
		ln -s "${WORKDIR}"/test/samples "${S}"/test/samples || die
	fi
	if use python; then
		sed -i \
			-e "s#\${CMAKE_INSTALL_LIBDIR}#$(python_get_sitedir)#g" \
			wrappers/python/CMakeLists.txt || die "sed failed"
	fi
	sed -i \
		-e 's#zxing_add_package_stb.*#include_directories(/usr/include/stb)#' \
		-e 's#stb::stb##g' \
		example/CMakeLists.txt || die "sed failed"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DZXING_USE_BUNDLED_ZINT=OFF
		-DZXING_EXAMPLES=$(usex test ON OFF)
		-DZXING_BLACKBOX_TESTS=$(usex test)
		-DZXING_UNIT_TESTS=$(usex test)
		-DZXING_DEPENDENCIES=LOCAL # force find_package as REQUIRED
		-DZXING_PYTHON_MODULE=$(usex python)
		# https://github.com/zxing-cpp/zxing-cpp/blob/v2.3.0/README.md#supported-formats
		-DZXING_WRITERS=$(usex experimental BOTH OLD)
		-DZXING_EXPERIMENTAL_API=$(usex experimental)
	)
	cmake_src_configure
}
