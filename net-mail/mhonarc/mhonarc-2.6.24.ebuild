# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-module

DESCRIPTION="Perl Mail-to-HTML Converter"
HOMEPAGE="https://www.mhonarc.org/"
SRC_URI="https://github.com/sympa-community/MHonArc/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P/mhonarc/MHonArc}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 mips ppc x86"
# Warrants IUSE examples, and here it is + ? IUSE doc; see also extras folder with html docs
IUSE="examples"

src_install() {
	sed -e "s|-prefix |-docpath '${D}/usr/share/doc/${PF}/html' -prefix '${D}'|g" -i Makefile ||
		die 'sed on Makefile failed'
	sed -e "s|installsitelib|installvendorlib|g" -i install.me ||
		die 'sed on install.me failed'
	perl-module_src_install
	if use examples; then
		docompress -x usr/share/doc/${PF}/examples
		insinto usr/share/doc/${PF}/
		doins -r examples/
	fi
}
