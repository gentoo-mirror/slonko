# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

MY_JAR="${PN}-launcher-${PV}.jar"

DESCRIPTION="Official Java launcher for Minecraft"
HOMEPAGE="https://minecraft.net"
SRC_URI="https://launcher.mojang.com/v1/objects/eabbff5ff8e21250e33670924a0c5e38f47c840b/launcher.jar -> ${MY_JAR}
	https://launcher.mojang.com/download/minecraft-launcher.svg -> ${PN}.svg"

LICENSE="Minecraft-clickwrap-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/openal
	virtual/opengl
	>=virtual/jre-1.8"

S="${WORKDIR}"

src_unpack() {
	:
}

src_install() {
	insinto /usr/share/games/"${PN}"
	newins "${DISTDIR}/${MY_JAR}" launcher.jar

	dobin "${FILESDIR}"/minecraft

	doicon -s scalable "${DISTDIR}/${PN}.svg"
	make_desktop_entry "${PN}" "${PN^}" "${PN}"
}

pkg_postinst() {
	einfo "This package has installed the Java Minecraft launcher."
	einfo "To actually play the game, you need to purchase an account at:"
	einfo "    ${HOMEPAGE}"
}
