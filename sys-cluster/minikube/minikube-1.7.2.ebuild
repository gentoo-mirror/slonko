# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-any-r1 go-module

EGIT_COMMIT="50d543b5fcb0e1c0d7c27b1398a9a9790df09dfb"

EGO_VENDOR=(
	"cloud.google.com/go v0.49.0 github.com/googleapis/google-cloud-go"
	"github.com/aws/aws-sdk-go v1.16.26"
	"github.com/bgentry/go-netrc 9fd32a8b3d3d3f9d43c341bfe098430e07609480"
	"github.com/blang/semver v3.5.0"
	"github.com/cenkalti/backoff v2.2.1"
	"github.com/cheggaaa/pb v3.0.1"
	"github.com/cloudfoundry-attic/jibber_jabber bcc4c8345a21301bf47c032ff42dd1aae2fe3027"
	"github.com/cpuguy83/go-md2man v1.0.10"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/docker/distribution v2.7.1"
	"github.com/docker/docker v1.13.1"
	"github.com/docker/go-connections v0.3.0"
	"github.com/docker/go-units v0.4.0"
	"github.com/docker/machine a555e4f7a8f518a8b1b174824c377e46cbfc4fe2"
	"github.com/docker/spdystream 449fdfce4d962303d702fec724ef0ad181c92528"
	"github.com/fatih/color v1.7.0"
	"github.com/fsnotify/fsnotify v1.4.7"
	"github.com/gogo/protobuf 65acae22fc9d1fe290b33faa2bd64cdc20a463a0"
	"github.com/golang/glog 23def4e6c14b4da8ac2ed8007337bc5eb5007998"
	"github.com/golang/groupcache 02826c3e79038b59d737d3b1c0a1d937f71a4433"
	"github.com/golang/protobuf v1.3.2"
	"github.com/googleapis/gax-go v2.0.5"
	"github.com/googleapis/gnostic v0.3.0"
	"github.com/google/go-cmp v0.3.0"
	"github.com/google/go-containerregistry 697ee0b3d46eff19ed2b30f86230377061203f79"
	"github.com/google/gofuzz v1.0.0"
	"github.com/hashicorp/errwrap 7554cd9344cec97297fa6649b055a8c98c2a1e55"
	"github.com/hashicorp/go-cleanhttp v0.5.0"
	"github.com/hashicorp/go-getter v1.4.0"
	"github.com/hashicorp/golang-lru v0.5.1"
	"github.com/hashicorp/go-multierror 8c5f0ad9360406a3807ce7de6bc73269a91a6e51"
	"github.com/hashicorp/go-safetemp v1.0.0"
	"github.com/hashicorp/go-version v1.1.0"
	"github.com/hashicorp/hcl v1.0.0"
	"github.com/imdario/mergo v0.3.8"
	"github.com/intel-go/cpuid 1a4a6f06a1c643c8fbd339bd61d980960627d09e"
	"github.com/jimmidyson/go-download 7f9a90c8c95bee1bb7de9e72c682c67c8bf5546d"
	"github.com/jmespath/go-jmespath c2b33e8439af944379acbdd9c3a5fe0bc44bd8a5"
	"github.com/json-iterator/go v1.1.8"
	"github.com/juju/clock 9c5c9712527c7986f012361e7d13756b4d99543d"
	"github.com/juju/errors 0232dcc7464d0c0037b619d6e10190301d01362f"
	"github.com/juju/mutex d21b13acf4bfd8a8b0482a3a78e44d98880b40d3"
	"github.com/kballard/go-shellquote 95032a82bc518f77982ea72343cc1ade730072f0"
	"github.com/libvirt/libvirt-go v3.4.0"
	"github.com/machine-drivers/docker-machine-driver-vmware v0.1.1"
	"github.com/magiconair/properties v1.8.1"
	"github.com/MakeNowJust/heredoc bb23615498cded5e105af4ce27de75b089cbe851"
	"github.com/mattn/go-colorable v0.1.2"
	"github.com/mattn/go-isatty v0.0.9"
	"github.com/mattn/go-runewidth v0.0.4"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-ps 4fdf99ab29366514c69ccccddab5dc58b8d84062"
	"github.com/mitchellh/go-testing-interface v1.0.0"
	"github.com/mitchellh/go-wordwrap v1.0.0"
	"github.com/mitchellh/mapstructure v1.1.2"
	"github.com/modern-go/concurrent bacd9c7ef1dd9b15be4a9909b8ac7a4e313eec94"
	"github.com/modern-go/reflect2 v1.0.1"
	"github.com/olekukonko/tablewriter a0225b3f23b5ce0cbec6d7a66a968f8a59eca9c4"
	"github.com/opencontainers/go-digest v1.0.0-rc1"
	"github.com/pelletier/go-toml v1.2.0"
	"github.com/pkg/browser 9302be274faad99162b9d48ec97b24306872ebb0"
	"github.com/pkg/errors v0.8.1"
	"github.com/pkg/profile 3a8809bd8a80f8ecfe4ee1b34b3f37194968617c"
	"github.com/russross/blackfriday v1.5.2"
	"github.com/samalba/dockerclient 91d7393ff85980ba3a8966405871a3d446ca28f2"
	"github.com/shirou/gopsutil v2.18.12"
	"github.com/spf13/afero v1.2.2"
	"github.com/spf13/cast v1.3.0"
	"github.com/spf13/cobra v0.0.5"
	"github.com/spf13/jwalterweatherman v1.0.0"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/viper v1.3.2"
	"github.com/ulikunitz/xz v0.5.5"
	"github.com/VividCortex/ewma v1.1.1"
	"golang.org/x/crypto 60c769a6c58655dab1b9adac0d58967dd517cfba github.com/golang/crypto"
	"golang.org/x/net 13f9640d40b9cc418fb53703dfbd177679788ceb github.com/golang/net"
	"golang.org/x/oauth2 0f29369cfe4552d0e4bcddc57cc75f4d7e672a33 github.com/golang/oauth2"
	"golang.org/x/sync cd5d95a43a6e21273425c7ae415d3df9ea832eeb github.com/golang/sync"
	"golang.org/x/sys c7b8b68b14567162c6602a7c5659ee0f26417c18 github.com/golang/sys"
	"golang.org/x/text v0.3.2 github.com/golang/text"
	"golang.org/x/time 9d24e82272b4f38b78bc8cff74fa936d31ccd8ef github.com/golang/time"
	"google.golang.org/api v0.9.0 github.com/googleapis/google-api-go-client"
	"google.golang.org/genproto c23dd37a84c939f63021464bd5aa07409dbe6cd6 github.com/googleapis/go-genproto"
	"google.golang.org/grpc v1.23.1 github.com/grpc/grpc-go"
	"go.opencensus.io v0.22.2 github.com/census-instrumentation/opencensus-go"
	"gopkg.in/cheggaaa/pb.v1 v1.0.27 github.com/cheggaaa/pb"
	"gopkg.in/inf.v0 v0.9.1 github.com/go-inf/inf"
	"gopkg.in/yaml.v2 v2.2.4 github.com/go-yaml/yaml"
	"k8s.io/api v0.17.2 github.com/kubernetes/api"
	"k8s.io/apimachinery v0.17.2 github.com/kubernetes/apimachinery"
	"k8s.io/client-go v0.17.2 github.com/kubernetes/client-go"
	"k8s.io/cluster-bootstrap v0.17.2 github.com/kubernetes/cluster-bootstrap"
	"k8s.io/component-base v0.17.2 github.com/kubernetes/component-base"
	"k8s.io/klog v0.3.1 github.com/kubernetes/klog"
	"k8s.io/kubectl v0.17.2 github.com/kubernetes/kubectl"
	"k8s.io/kubelet v0.17.2 github.com/kubernetes/kubelet"
	"k8s.io/kube-proxy v0.17.2 github.com/kubernetes/kube-proxy"
	"k8s.io/kubernetes v1.17.2 github.com/kubernetes/kubernetes"
	"k8s.io/utils 1e243dd1a5840a70026a2dc96fdfe7c706286206 github.com/kubernetes/utils"
	"sigs.k8s.io/yaml v1.1.0 github.com/kubernetes-sigs/yaml"
)

KEYWORDS="~amd64"

DESCRIPTION="Single Node Kubernetes Cluster"
HOMEPAGE="https://github.com/kubernetes/minikube https://kubernetes.io"
SRC_URI="https://github.com/kubernetes/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(go-module_vendor_uris)"

LICENSE="Apache-2.0 BSD BSD-2 CC-BY-4.0 CC-BY-SA-4.0 CC0-1.0 GPL-2 ISC LGPL-3 MIT MPL-2.0 WTFPL-2 ZLIB || ( LGPL-3+ GPL-2 ) || ( Apache-2.0 LGPL-3+ ) || ( Apache-2.0 CC-BY-4.0 )"
SLOT="0"
IUSE="hardened libvirt"

RDEPEND=">=sys-cluster/kubectl-1.14.0
	libvirt? ( app-emulation/libvirt:=[qemu] )"
DEPEND="${RDEPEND}
	dev-go/go-bindata
	${PYTHON_DEPS}"

RESTRICT="test"

src_prepare() {
	default
	sed -i -e "s/get_commit(), get_tree_state(), get_version()/get_commit(), 'gitTreeState=clean', get_version()/"  hack/get_k8s_version.py || die
	sed -i -e "s|^COMMIT ?=.*|COMMIT = ${EGIT_COMMIT}|" -e "s|^COMMIT_NO :=.*|COMMIT_NO = ${EGIT_COMMIT}|" -i Makefile || die
}

src_compile() {
	export -n GOCACHE GOPATH XDG_CACHE_HOME
	export CGO_LDFLAGS="$(usex hardened '-fno-PIC ' '')"
	LDFLAGS="" emake  $(usex libvirt "out/docker-machine-driver-kvm2" "") out/minikube-linux-amd64
}

src_install() {
	newbin out/minikube-linux-amd64 minikube
	use libvirt && dobin out/docker-machine-driver-kvm2
	dodoc -r docs CHANGELOG.md README.md
}

pkg_postinst() {
	elog "You may want to install the following optional dependency:"
	elog "  app-emulation/virtualbox or app-emulation/virtualbox-bin"
}
