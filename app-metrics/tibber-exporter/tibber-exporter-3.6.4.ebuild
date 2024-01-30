# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module systemd

DESCRIPTION="Monitor your power usage and costs with Prometheus and Grafana"
HOMEPAGE="https://github.com/terjesannum/tibber-exporter"
SRC_URI="https://github.com/terjesannum/tibber-exporter/archive/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	acct-group/tibber-exporter
	acct-user/tibber-exporter
"
RDEPEND="${DEPEND}"

EGO_SUM=(
	"github.com/beorn7/perks v1.0.1"
	"github.com/beorn7/perks v1.0.1/go.mod"
	"github.com/cespare/xxhash/v2 v2.2.0"
	"github.com/cespare/xxhash/v2 v2.2.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/golang/protobuf v1.5.0/go.mod"
	"github.com/google/go-cmp v0.5.5/go.mod"
	"github.com/google/go-cmp v0.5.9"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/google/uuid v1.4.0"
	"github.com/google/uuid v1.4.0/go.mod"
	"github.com/gorilla/websocket v1.5.0"
	"github.com/gorilla/websocket v1.5.0/go.mod"
	"github.com/graph-gophers/graphql-go v1.5.0"
	"github.com/graph-gophers/graphql-go v1.5.0/go.mod"
	"github.com/graph-gophers/graphql-transport-ws v0.0.2"
	"github.com/graph-gophers/graphql-transport-ws v0.0.2/go.mod"
	"github.com/hasura/go-graphql-client v0.10.1"
	"github.com/hasura/go-graphql-client v0.10.1/go.mod"
	"github.com/matttproud/golang_protobuf_extensions/v2 v2.0.0"
	"github.com/matttproud/golang_protobuf_extensions/v2 v2.0.0/go.mod"
	"github.com/prometheus/client_golang v1.17.0"
	"github.com/prometheus/client_golang v1.17.0/go.mod"
	"github.com/prometheus/client_model v0.5.0"
	"github.com/prometheus/client_model v0.5.0/go.mod"
	"github.com/prometheus/common v0.45.0"
	"github.com/prometheus/common v0.45.0/go.mod"
	"github.com/prometheus/procfs v0.12.0"
	"github.com/prometheus/procfs v0.12.0/go.mod"
	"golang.org/x/exp v0.0.0-20231206192017-f3f8817b8deb"
	"golang.org/x/exp v0.0.0-20231206192017-f3f8817b8deb/go.mod"
	"golang.org/x/sys v0.15.0"
	"golang.org/x/sys v0.15.0/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"google.golang.org/protobuf v1.26.0-rc.1/go.mod"
	"google.golang.org/protobuf v1.31.0"
	"google.golang.org/protobuf v1.31.0/go.mod"
	"nhooyr.io/websocket v1.8.10"
	"nhooyr.io/websocket v1.8.10/go.mod"
	)
go-module_set_globals
SRC_URI+="${EGO_SUM_SRC_URI}"

S="${WORKDIR}/${PN}-${P}"

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
