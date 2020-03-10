# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} = 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/qca/open-plc-utils.git"
	S=${WORKDIR}/open-plc-utils-${PV}
else
	SRC_URI="https://github.com/qca/open-plc-utils/archive/v${PV}.tar.gz -> python-diamond-${PV}.tar.gz"
	S=${WORKDIR}/open-plc-utils-${PV}
fi

DESCRIPTION="Qualcomm Atheros Open Powerline Toolkit. "
HOMEPAGE="https://github.com/qca/open-plc-utils"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD"
SLOT="0"
IUSE="doc"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	emake ROOTFS="${D}" install || die "emake install failed"
	emake ROOTFS="${D}" manuals || die "emake manuals failed"
	use doc && dohtml -r docbook
}
