# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit check-reqs desktop unpacker wrapper

DESCRIPTION="Military simulations by the U.S. Army to provide insights on soldiering"
HOMEPAGE="http://www.americasarmy.com/"
SRC_URI="mirror://sourceforge/distrobuild/${PN}${PV}-linux.run"

LICENSE="Army-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="mirror strip"
IUSE="opengl"

RDEPEND="sys-libs/glibc"

S=${WORKDIR}

pre_build_checks() {
	CHECKREQS_DISK_BUILD="3G"
	check-reqs_pkg_setup
}

pkg_pretend() {
	pre_build_checks
}

pkg_setup() {
	pre_build_checks
}

src_unpack() {
	unpack_makeself ${PN}${PV}-linux.run || die "unpacking game"
	unpack ./setupstuff.tar.gz
}

src_install() {
	local dir=/opt/${PN}
	local Ddir=${D}/${dir}

	einfo "This will take a while... go get a pizza or something."

	dodir "${dir}"
	tar -jxf armyops${PV}.tar.bz2 -C "${Ddir}"/ || die "armyops untar failed"
	tar -jxf binaries.tar.bz2 -C "${Ddir}"/ || die "binaries untar failed"

	dodoc README.linux
	insinto "${dir}"
	doins ArmyOps.xpm README.linux ArmyOps${PV}_EULA.txt || die "doins failed"
	newicon ArmyOps.xpm armyops.xpm || die "newicon failed"
	exeinto "${dir}"
	doexe bin/armyops || die "doexe failed"
	fperms ug+x "${dir}"/System/pb/pbweb.x86

	if use opengl ; then
		make_wrapper armyops ./armyops "${dir}" "${dir}"
		make_desktop_entry armyops "America's Army" armyops.xpm
	fi
}
