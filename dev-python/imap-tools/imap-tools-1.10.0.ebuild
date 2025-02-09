# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1

MY_PN="${PN/-/_}"
DESCRIPTION="High level lib for work with email by IMAP"
HOMEPAGE="https://github.com/ikvk/imap_tools"
SRC_URI="https://github.com/ikvk/imap_tools/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.rst )

distutils_enable_tests unittest

python_prepare_all() {
	# Remove tests requiring credentials for public IMAP servers
	rm tests/test_{connection,folders,idle,mailbox,message}.py || die

	distutils-r1_python_prepare_all
}
