# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs desktop unpacker wrapper

DESCRIPTION="Military simulations by the U.S. Army to provide insights on soldiering"
HOMEPAGE="https://www.americasarmy.com/"
SRC_URI="https://downloads.sourceforge.net/project/distrobuild/sources/${PN}${PV}-linux.run"
S=${WORKDIR}

LICENSE="Army-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="bindist mirror strip"

RDEPEND="
	amd64? ( sys-libs/glibc[multilib] )
	app-crypt/libmd[abi_x86_32(-)]
	dev-libs/libbsd[abi_x86_32(-)]
	sys-libs/glibc
	sys-libs/libstdc++-v3:5
	virtual/opengl[abi_x86_32(-)]
	x11-libs/libX11[abi_x86_32(-)]
	x11-libs/libXdmcp[abi_x86_32(-)]
	x11-libs/libXext[abi_x86_32(-)]
	x11-libs/libxcb[abi_x86_32(-)]
"

dir=opt/${PN}

QA_PREBUILT="${dir}/System/*-bin ${dir}/System/*.so ${dir}/System/libSDL-1.2.so.0 ${dir}/System/pb/*.so"

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

	make_wrapper armyops ./armyops "${dir}" "${dir}"
	make_desktop_entry armyops "America's Army" armyops.xpm
}
