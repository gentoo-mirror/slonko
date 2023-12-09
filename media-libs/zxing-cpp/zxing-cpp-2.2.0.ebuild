# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit cmake python-single-r1

DESCRIPTION="C++ Multi-format 1D/2D barcode image processing library"
HOMEPAGE="https://github.com/zxing-cpp/zxing-cpp"
SRC_URI="https://github.com/zxing-cpp/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/3"
KEYWORDS="amd64 ~arm arm64 ~loong ~ppc64 ~riscv x86"
IUSE="python test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

RDEPEND="
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep 'dev-python/pybind11[${PYTHON_USEDEP}]')
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-cpp/gtest
		>=dev-libs/stb-20231115
	)
"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	sed -i \
		-e "s#\${CMAKE_INSTALL_LIBDIR}#$(python_get_sitedir)#g" \
		wrappers/python/CMakeLists.txt || die "sed failed"
	sed -i \
		-e 's#zxing_add_package_stb.*#include_directories(/usr/include/stb)#' \
		-e 's#stb::stb##g' \
		example/CMakeLists.txt || die "sed failed"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex test ON OFF)
		-DBUILD_BLACKBOX_TESTS=OFF # Require test/samples
		-DBUILD_UNIT_TESTS=$(usex test ON OFF)
		-DBUILD_PYTHON_MODULE=$(usex python ON OFF)
	)
	cmake_src_configure
}
