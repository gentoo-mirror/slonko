# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils xdg-utils

DESCRIPTION="A programming environment for creating stories, animations, games, and music."
HOMEPAGE="http://scratch.mit.edu/"
SRC_URI="http://download.scratch.mit.edu/${P}.src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa oss pulseaudio nas +v4l"

DEPEND="dev-lang/squeakvm[scratch]
	alsa? ( dev-lang/squeakvm[alsa] )
	oss? ( dev-lang/squeakvm[oss] )
	pulseaudio? ( dev-lang/squeakvm[pulseaudio] )
	nas? ( dev-lang/squeakvm[nas] )
	v4l? ( dev-lang/squeakvm[v4l] )"
RDEPEND="${DEPEND}"

REQUIRED_USE="?? ( alsa oss pulseaudio nas )"

S="${WORKDIR}/${P}.src"

src_prepare() {
	rm -rf src/plugins/*
	rm -f Makefile
	eapply_user
}

src_configure(){

if   use alsa;       then squeak_sound_plugin="ALSA"
elif use oss;        then squeak_sound_plugin="OSS"
elif use pulseaudio; then squeak_sound_plugin="pulse"
elif use nas;		 then squeak_sound_plugin="nas"
else                      squeak_sound_plugin="null"
fi

}

src_install() {
	local datadir="/usr/share/${PN}"
	local icondir="/usr/share/icons/hicolor"
	dodir "${datadir}"
	cp -r Help locale Media Projects "${D}${datadir}"
	doman src/man/*
	dodoc ACKNOWLEDGEMENTS KNOWN-BUGS README NOTICE TRADEMARK_POLICY
	insinto /usr/share/mime/packages
	doins src/scratch.xml
	dolib Scratch.image
	dolib Scratch.ini
	(
		cd src/icons
		for res in *; do
			insinto "${icondir}/${res}/apps"
			doins "${res}"/scratch*.png
			insinto "${icondir}/${res}/mimetypes"
			if [[ ${res} != "32x32" ]]; then
				newins "${res}/gnome-mime-application-x-scratch-project.png" mime-application-x-scratch-project.png
			fi
		done
	)
	install_runner
	make_desktop_entry scratch Scratch scratch "Education;Development" "MimeType=application/x-scratch-project"
}

install_runner() {
	local tmpexe=$(emktemp)
	cat << EOF > "${tmpexe}"
#!/bin/sh
cd
exec \
	"/usr/bin/squeak"                 \\
-vm-sound-${squeak_sound_plugin}      \\
"/usr/$(get_libdir)/Scratch.image"    \\
"${@}"
EOF
	chmod go+rx "${tmpexe}"
	newbin "${tmpexe}" "${PN}" || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	gnome2_icon_cache_update

}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
