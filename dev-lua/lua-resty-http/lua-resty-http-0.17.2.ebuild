# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Openresty only ever supports luajit.
LUA_COMPAT=( luajit )
inherit lua-single

DESCRIPTION="Lua HTTP client cosocket driver for OpenResty / ngx_lua"
HOMEPAGE="https://github.com/ledgetech/lua-resty-http"
if [[ "${PV}" =~ 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ledgetech/lua-resty-http"
else
	SRC_URI="https://github.com/ledgetech/lua-resty-http/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="BSD-2"
SLOT="0"
# Tests require replicating much of nginx-module_src_test() in each
# dev-lua/lua-resty-* ebuild.
RESTRICT="test"

REQUIRED_USE="${LUA_REQUIRED_USE}"

BDEPEND="virtual/pkgconfig"
DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"

src_configure() {
	# The directory where to Lua files are to be installed, used by the build
	# system.
	export LUA_LIB_DIR="$(lua_get_lmod_dir)"
	default
}
