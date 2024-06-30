# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module systemd

DESCRIPTION="Monitor your power usage and costs with Prometheus and Grafana"
HOMEPAGE="https://github.com/terjesannum/tibber-exporter"
SRC_URI="https://github.com/terjesannum/tibber-exporter/archive/${P}.tar.gz"

EGO_SUM=(
        "github.com/beorn7/perks v1.0.1"
        "github.com/beorn7/perks v1.0.1/go.mod"
        "github.com/cespare/xxhash/v2 v2.3.0"
        "github.com/cespare/xxhash/v2 v2.3.0/go.mod"
        "github.com/davecgh/go-spew v1.1.1"
        "github.com/davecgh/go-spew v1.1.1/go.mod"
        "github.com/google/go-cmp v0.6.0"
        "github.com/google/go-cmp v0.6.0/go.mod"
        "github.com/google/uuid v1.6.0"
        "github.com/google/uuid v1.6.0/go.mod"
        "github.com/hasura/go-graphql-client v0.12.2"
        "github.com/hasura/go-graphql-client v0.12.2/go.mod"
        "github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822"
        "github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822/go.mod"
        "github.com/prometheus/client_golang v1.19.1"
        "github.com/prometheus/client_golang v1.19.1/go.mod"
        "github.com/prometheus/client_model v0.6.1"
        "github.com/prometheus/client_model v0.6.1/go.mod"
        "github.com/prometheus/common v0.55.0"
        "github.com/prometheus/common v0.55.0/go.mod"
        "github.com/prometheus/procfs v0.15.1"
        "github.com/prometheus/procfs v0.15.1/go.mod"
        "golang.org/x/exp v0.0.0-20240613232115-7f521ea00fb8"
        "golang.org/x/exp v0.0.0-20240613232115-7f521ea00fb8/go.mod"
        "golang.org/x/sys v0.21.0"
        "golang.org/x/sys v0.21.0/go.mod"
        "google.golang.org/protobuf v1.34.2"
        "google.golang.org/protobuf v1.34.2/go.mod"
        "nhooyr.io/websocket v1.8.11"
        "nhooyr.io/websocket v1.8.11/go.mod"
        )
go-module_set_globals
SRC_URI+="${EGO_SUM_SRC_URI}"

S="${WORKDIR}/${PN}-${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	acct-group/tibber-exporter
	acct-user/tibber-exporter
"
RDEPEND="${DEPEND}"

src_compile() {
	ego build
}

src_install() {
	dobin ${PN}
	dodoc *.md
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	systemd_dounit "${FILESDIR}/${PN}.service"
}

pkg_postinst() {
	elog "To complete the installation get your Tibber token at"
	elog "https://developer.tibber.com"
	elog "and put it as TIBBER_TOKEN in /etc/conf.d/tibber-exporter file"
}
