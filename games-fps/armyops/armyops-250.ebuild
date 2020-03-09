# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/americas-army/americas-army-250.ebuild,v 1.17 2007/08/20 22:34:00 mr_bones_ Exp $

inherit eutils unpacker games

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

pkg_setup() {
	games_pkg_setup
	einfo "The installed game takes about 1.6GB of space when installed and"
	einfo "2.4GB of space in ${PORTAGE_TMPDIR} to build!"
	echo
}

src_unpack() {
	unpack_makeself ${PN}${PV}-linux.run || die "unpacking game"
	unpack ./setupstuff.tar.gz
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
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
		games_make_wrapper armyops ./armyops "${dir}" "${dir}"
		make_desktop_entry armyops "America's Army" armyops.xpm
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if use opengl ; then
		elog "To play the game, run:  armyops"
		echo
	fi
}
