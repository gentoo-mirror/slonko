# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit games java-utils-2

DESCRIPTION="An open-world game whose gameplay revolves around breaking and placing blocks"
HOMEPAGE="http://www.minecraft.net"
SRC_URI="
  https://github.com/Tabinol/gentoo-minecraft/archive/${PV}.tar.gz -> ${P}.tar.gz
  https://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar -> ${PN}.jar"
	
LICENSE="Minecraft"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

S="${WORKDIR}/gentoo-minecraft-${PV}"

RDEPEND=">=virtual/jre-1.8.0
  >=x11-apps/xrandr-1.4.3
  virtual/ttf-fonts"

DEPEND=""

pkg_setup() {
	games_pkg_setup
}

src_unpack() {
	unpack ${P}.tar.gz
}

src_prepare() {
	sed --in-place "s:@GENTOO_PORTAGE_EPREFIX@:${EPREFIX}:g" "${PN}" || die
}

src_install() {
	java-pkg_dojar "${DISTDIR}/${PN}.jar"
  dogamesbin "${PN}"
	doicon "${PN}.png"
	make_desktop_entry "${PN}" "Minecraft"

	prepgamesdirs
}

pkg_postinst() {
	ewarn "if you are doing an update, consider to remove minecraft-gentoo call"
	ewarn "in Minecraft launcher configuration which is no longer installed."
	ewarn "Every Minecraft versions should work."
	echo

	games_pkg_postinst
}

