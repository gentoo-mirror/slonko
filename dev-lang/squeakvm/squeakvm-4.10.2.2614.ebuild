# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit fixheadtails
DESCRIPTION="Highly-portable Smalltalk-80 implementation"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="http://squeakvm.org/unix/release/Squeak-${PV}-src.tar.gz"
LICENSE="Apple"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+X +mmx +threads +iconv +opengl image64 alsa oss pulseaudio nas +v4l fbcon dbus +scratch examples"

DEPEND="X? ( x11-libs/libX11 x11-libs/libXext x11-libs/libXt )
	dev-util/cmake
	media-libs/freetype
	>=x11-libs/cairo-1.8.6
	>=x11-libs/pango-1.20.5
	>=dev-libs/glib-2.20.1:2
	dev-libs/libffi
	sys-apps/util-linux
	iconv? ( virtual/libiconv )
	opengl? ( virtual/opengl )
	v4l? ( >=media-libs/libv4l-0.5.8 )
	alsa? ( media-libs/alsa-lib )
	oss? ( media-libs/alsa-oss )
	pulseaudio? ( media-sound/pulseaudio )
	nas? ( media-libs/nas )
	dbus? ( sys-apps/dbus )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Squeak-${PV}-src"

src_prepare() {
	ht_fix_all
	eapply_user
	if ! use examples; then
	    rm -rf unix/vm-display-custom
		rm -rf unix/vm-sound-custom
	fi
}

src_configure() {
	local myconf=""
	if use X; then
		myconf="${myconf} --with-x"
	else
	    myconf="${myconf} --without-x"
	fi
	if use threads; then
		myconf="${myconf} --enable-mpg-pthread"
	else
	    myconf="${myconf} --disable-mpg-pthread"
	fi
	if use iconv; then
		myconf="${myconf} --enable-iconv"
	else
	    myconf="${myconf} --disable-iconv"
	fi

	if use opengl; then
		myconf="${myconf} --with-gl"
	else
	    myconf="${myconf} --without-gl"
	fi

	if use alsa; then
		myconf="${myconf} --with-alsa"
	else
	    myconf="${myconf} --without-alsa"
	fi

	if use oss; then
		myconf="${myconf} --with-oss"
	else
	    myconf="${myconf} --without-oss"
	fi

	if use pulseaudio; then
		myconf="${myconf} --with-pulse"
	else
	    myconf="${myconf} --without-pulse"
	fi

	if use nas; then
		myconf="${myconf} --with-NAS"
	else
	    myconf="${myconf} --without-NAS"
	fi

	if use v4l; then
		myconf="${myconf} --with-CameraPlugin"
	else
	    myconf="${myconf} --without-CameraPlugin"
	fi

	if use fbcon; then
		myconf="${myconf} --with-fbdev"
	else
	    myconf="${myconf} --without-fbdev"
	fi

	if use dbus; then
		myconf="${myconf} --with-DBusPlugin"
	else
	    myconf="${myconf} --without-DBusPlugin"
	fi

	if use scratch; then
		myconf="${myconf} --with-ScratchPlugin"
	else
	    myconf="${myconf} --without-ScratchPlugin"
	fi

	if use X; then
		myconf="${myconf} --with-x"
	else
	    myconf="${myconf} --without-x"
	fi

	if use X; then
		myconf="${myconf} --with-x"
	else
	    myconf="${myconf} --without-x"
	fi

	#use mmx 		&& myconf="${myconf} --enable-mpg-mmx"
	#use threads 	&& myconf="${myconf} --enable-mpg-pthread"
	#use iconv 		|| myconf="${myconf} --disable-iconv"
	#use opengl 		|| myconf="${myconf} --without-gl"
	use image64 && myconf="${myconf} --image64"
	#use alsa		|| myconf="${myconf} --without-alsa"
	#use oss			|| myconf="${myconf} --without-OSS"
	#use pulseaudio	|| myconf="${myconf} --without-pulse"
	#use nas			|| myconf="${myconf} --without-NAS"
	#use v4l			|| myconf="${myconf} --without-CameraPlugin"
	#use fbcon		|| myconf="${myconf} --without-fbdev"
	#use dbus		|| myconf="${myconf} --without-DBusPlugin"
	#use scratch		|| myconf="${myconf} --without-ScratchPlugin"

	cd "${S}"
	touch unix/npsqueak/CMakeLists.txt
	mkdir build
	cd build
	../unix/cmake/configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-ffi=x86-sysv \
		--without-npsqueak \
		--without-quartz \
		--without-Sun \
		--without-MaxOSX \
		--without-WeDoPlugin \
		--with-FT2Plugin \
		--with-SqueakFFIPrims \
		${myconf} || die "configure failed"
}

src_install() {
	dodoc README unix/ChangeLog
	cd "${S}"/build
	emake DESTDIR="${D}" ROOT="${D}" docdir=/usr/share/doc/"${PF}" install || die
	exeinto /usr/lib/squeak
	exeinto /usr/lib/ckformat
}
