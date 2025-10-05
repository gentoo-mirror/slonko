# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( luajit )

inherit lua

DESCRIPTION="FFI-based OpenSSL binding for OpenResty"
HOMEPAGE="https://github.com/fffonion/lua-resty-openssl"
if [[ "${PV}" =~ 9999 ]]; then
        inherit git-r3
		EGIT_REPO_URI="https://github.com/fffonion/lua-resty-openssl"
else
        SRC_URI="https://github.com/fffonion/lua-resty-openssl/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"
fi

LICENSE="BSD"
SLOT="0"
REQUIRED_USE="${LUA_REQUIRED_USE}"
IUSE="+lua_targets_luajit"

RDEPEND="
	${LUA_DEPS}
	dev-libs/openssl:0
	dev-lua/basexx[${LUA_USEDEP}]
	dev-lua/lua-cjson[${LUA_USEDEP}]
	www-nginx/ngx-lua-module[lua_single_target_luajit]
	>=www-servers/nginx-1.28.0-r2[nginx_modules_http_ssl]
"
DEPEND="
	${RDEPEND}
"

src_compile() { :; }

each_lua_install() {
	insinto "$(lua_get_lmod_dir)"
	doins -r lib/resty
}

src_install() {
	lua_foreach_impl each_lua_install
	einstalldocs
}
