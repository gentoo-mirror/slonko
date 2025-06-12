# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm

DESCRIPTION="Plugins for Epson Scan 2"

HOMEPAGE="https://support.epson.net/linux/en/epsonscan2.php"
# This is distributed as part of the "bundle driver"; since we already have the
# opensource part separately we just install the nonfree part here.

EPSONSCAN2_VERSION="6.7.80.0"
REL="1"

SRC_URI="https://download3.ebz.epson.net/dsc/f/03/00/17/08/14/9948b3e633af0e12031e46c3408f9730f4734da0/epsonscan2-bundle-${EPSONSCAN2_VERSION}.x86_64.rpm.tar.gz"
S=${WORKDIR}

LICENSE="EPSON"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-gfx/epsonscan2"
RESTRICT="bindist mirror strip"

src_unpack() {
	default
	rpm_unpack "./epsonscan2-bundle-${EPSONSCAN2_VERSION}.x86_64.rpm/plugins/${P}-${REL}.x86_64.rpm"
}

src_install() {
	mv usr/share/doc/${P}-${REL} usr/share/doc/${P}
	insinto /
	doins -r usr
	# Fix permissions
	find "${ED}/usr/lib"* -type f -exec chmod 0755 {} +
}
