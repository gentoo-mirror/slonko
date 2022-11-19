# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line-0.17.0
	adler-1.0.2
	aead-0.5.1
	aes-0.8.1
	aes-gcm-0.10.1
	aho-corasick-0.7.19
	alloc-no-stdlib-2.0.4
	alloc-stdlib-0.2.2
	android_system_properties-0.1.5
	async-compression-0.3.15
	async-stream-0.3.3
	async-stream-impl-0.3.3
	async-trait-0.1.57
	async_once-0.2.6
	atomic-0.5.1
	atty-0.2.14
	autocfg-1.1.0
	backtrace-0.3.66
	base64-0.13.0
	binascii-0.1.4
	bitflags-1.3.2
	block-buffer-0.10.3
	brotli-3.3.4
	brotli-decompressor-2.3.2
	bumpalo-3.11.0
	byteorder-1.4.3
	bytes-1.2.1
	cached-0.39.0
	cached_proc_macro-0.15.0
	cached_proc_macro_types-0.1.0
	cc-1.0.73
	cfg-if-1.0.0
	chrono-0.4.22
	chrono-tz-0.6.3
	chrono-tz-build-0.0.3
	cipher-0.4.3
	codespan-reporting-0.11.1
	cookie-0.16.1
	cookie_store-0.16.1
	cookie_store-0.17.0
	core-foundation-0.9.3
	core-foundation-sys-0.8.3
	cpufeatures-0.2.5
	crc32fast-1.3.2
	cron-0.12.0
	crossbeam-utils-0.8.12
	crypto-common-0.1.6
	ctr-0.9.2
	ctrlc-3.2.3
	cxx-1.0.78
	cxx-build-1.0.78
	cxxbridge-flags-1.0.78
	cxxbridge-macro-1.0.78
	darling-0.13.4
	darling_core-0.13.4
	darling_macro-0.13.4
	dashmap-5.4.0
	data-encoding-2.3.2
	data-url-0.2.0
	devise-0.3.1
	devise_codegen-0.3.1
	devise_core-0.3.1
	diesel-1.4.8
	diesel_derives-1.4.1
	diesel_migrations-1.4.0
	digest-0.10.5
	dirs-4.0.0
	dirs-sys-0.3.7
	dotenvy-0.15.5
	either-1.8.0
	email-encoding-0.1.3
	email_address-0.2.3
	encoding_rs-0.8.31
	enum-as-inner-0.4.0
	error-chain-0.12.4
	fastrand-1.8.0
	fern-0.6.1
	figment-0.10.8
	flate2-1.0.24
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.1.0
	futures-0.3.24
	futures-channel-0.3.24
	futures-core-0.3.24
	futures-executor-0.3.24
	futures-io-0.3.24
	futures-macro-0.3.24
	futures-sink-0.3.24
	futures-task-0.3.24
	futures-timer-3.0.2
	futures-util-0.3.24
	generator-0.7.1
	generic-array-0.14.6
	getrandom-0.2.7
	ghash-0.5.0
	gimli-0.26.2
	glob-0.3.0
	governor-0.5.0
	h2-0.3.14
	half-1.8.2
	handlebars-4.3.5
	hashbrown-0.12.3
	heck-0.4.0
	hermit-abi-0.1.19
	hkdf-0.12.3
	hmac-0.12.1
	hostname-0.3.1
	html5gum-0.5.2
	http-0.2.8
	http-body-0.4.5
	httparse-1.8.0
	httpdate-1.0.2
	hyper-0.14.20
	hyper-tls-0.5.0
	iana-time-zone-0.1.51
	iana-time-zone-haiku-0.1.0
	ident_case-1.0.1
	idna-0.1.5
	idna-0.2.3
	idna-0.3.0
	indexmap-1.9.1
	inlinable_string-0.1.15
	inout-0.1.3
	instant-0.1.12
	ipconfig-0.3.0
	ipnet-2.5.0
	itoa-1.0.4
	jetscii-0.5.3
	job_scheduler_ng-2.0.2
	js-sys-0.3.60
	jsonwebtoken-8.1.1
	lazy_static-1.4.0
	lettre-0.10.1
	libc-0.2.135
	libmimalloc-sys-0.1.26
	libsqlite3-sys-0.22.2
	link-cplusplus-1.0.7
	linked-hash-map-0.5.6
	lock_api-0.4.9
	log-0.4.17
	loom-0.5.6
	lru-cache-0.1.2
	mach-0.3.2
	match_cfg-0.1.0
	matchers-0.1.0
	matches-0.1.9
	memchr-2.5.0
	migrations_internals-1.4.1
	migrations_macros-1.4.2
	mimalloc-0.1.30
	mime-0.3.16
	minimal-lexical-0.2.1
	miniz_oxide-0.5.4
	mio-0.8.4
	mysqlclient-sys-0.2.5
	native-tls-0.2.10
	nix-0.25.0
	no-std-compat-0.4.1
	nom-7.1.1
	nonzero_ext-0.3.0
	nu-ansi-term-0.46.0
	num-bigint-0.4.3
	num-derive-0.3.3
	num-integer-0.1.45
	num-traits-0.2.15
	num_cpus-1.13.1
	num_threads-0.1.6
	object-0.29.0
	once_cell-1.15.0
	opaque-debug-0.3.0
	openssl-0.10.42
	openssl-macros-0.1.0
	openssl-probe-0.1.5
	openssl-src-111.22.0+1.1.1q
	openssl-sys-0.9.76
	overload-0.1.1
	parking_lot-0.12.1
	parking_lot_core-0.9.3
	parse-zoneinfo-0.3.0
	paste-1.0.9
	pear-0.2.3
	pear_codegen-0.2.3
	pem-1.1.0
	percent-encoding-1.0.1
	percent-encoding-2.2.0
	pest-2.4.0
	pest_derive-2.4.0
	pest_generator-2.4.0
	pest_meta-2.4.0
	phf-0.11.1
	phf_codegen-0.11.1
	phf_generator-0.11.1
	phf_shared-0.11.1
	pico-args-0.5.0
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkg-config-0.3.25
	polyval-0.6.0
	ppv-lite86-0.2.16
	pq-sys-0.4.7
	proc-macro-hack-0.5.19
	proc-macro2-1.0.46
	proc-macro2-diagnostics-0.9.1
	psl-types-2.0.11
	publicsuffix-2.2.3
	quanta-0.9.3
	quick-error-1.2.3
	quote-1.0.21
	quoted_printable-0.4.5
	r2d2-0.8.10
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	raw-cpuid-10.6.0
	redox_syscall-0.2.16
	redox_users-0.4.3
	ref-cast-1.0.12
	ref-cast-impl-1.0.12
	regex-1.6.0
	regex-automata-0.1.10
	regex-syntax-0.6.27
	remove_dir_all-0.5.3
	reqwest-0.11.12
	resolv-conf-0.7.0
	ring-0.16.20
	rmp-0.8.11
	rmpv-1.0.0
	rocket-0.5.0-rc.2
	rocket_codegen-0.5.0-rc.2
	rocket_http-0.5.0-rc.2
	rustc-demangle-0.1.21
	rustls-0.20.6
	rustls-pemfile-1.0.1
	rustversion-1.0.9
	ryu-1.0.11
	same-file-1.0.6
	schannel-0.1.20
	scheduled-thread-pool-0.2.6
	scoped-tls-1.0.0
	scopeguard-1.1.0
	scratch-1.0.2
	sct-0.7.0
	security-framework-2.7.0
	security-framework-sys-2.6.1
	serde-1.0.145
	serde_cbor-0.11.2
	serde_derive-1.0.145
	serde_json-1.0.86
	serde_urlencoded-0.7.1
	sha-1-0.10.0
	sha1-0.10.5
	sha2-0.10.6
	sharded-slab-0.1.4
	signal-hook-registry-1.4.0
	simple_asn1-0.6.2
	siphasher-0.3.10
	slab-0.4.7
	smallvec-1.10.0
	socket2-0.4.7
	spin-0.5.2
	spin-0.9.4
	stable-pattern-0.1.0
	state-0.5.3
	strsim-0.10.0
	subtle-2.4.1
	syn-1.0.102
	syslog-6.0.1
	tempfile-3.3.0
	termcolor-1.1.3
	thiserror-1.0.37
	thiserror-impl-1.0.37
	thread_local-1.1.4
	threadpool-1.8.1
	time-0.1.43
	time-0.3.15
	time-macros-0.2.4
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	tokio-1.21.2
	tokio-macros-1.8.0
	tokio-native-tls-0.3.0
	tokio-rustls-0.23.4
	tokio-socks-0.5.1
	tokio-stream-0.1.11
	tokio-tungstenite-0.17.2
	tokio-util-0.7.4
	toml-0.5.9
	totp-lite-2.0.0
	tower-service-0.3.2
	tracing-0.1.37
	tracing-attributes-0.1.23
	tracing-core-0.1.30
	tracing-log-0.1.3
	tracing-subscriber-0.3.16
	trust-dns-proto-0.21.2
	trust-dns-resolver-0.21.2
	try-lock-0.2.3
	tungstenite-0.17.3
	typenum-1.15.0
	ubyte-0.10.3
	ucd-trie-0.1.5
	uncased-0.9.7
	unicode-bidi-0.3.8
	unicode-ident-1.0.5
	unicode-normalization-0.1.22
	unicode-width-0.1.10
	unicode-xid-0.2.4
	universal-hash-0.5.0
	untrusted-0.7.1
	url-1.7.2
	url-2.3.1
	utf-8-0.7.6
	uuid-1.2.1
	valuable-0.1.0
	vcpkg-0.2.15
	version_check-0.9.4
	walkdir-2.3.2
	want-0.3.0
	wasi-0.10.2+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-futures-0.4.33
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	web-sys-0.3.60
	webauthn-rs-0.3.2
	webpki-0.22.0
	widestring-0.5.1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.32.0
	windows-sys-0.36.1
	windows_aarch64_msvc-0.32.0
	windows_aarch64_msvc-0.36.1
	windows_i686_gnu-0.32.0
	windows_i686_gnu-0.36.1
	windows_i686_msvc-0.32.0
	windows_i686_msvc-0.36.1
	windows_x86_64_gnu-0.32.0
	windows_x86_64_gnu-0.36.1
	windows_x86_64_msvc-0.32.0
	windows_x86_64_msvc-0.36.1
	winreg-0.7.0
	winreg-0.10.1
	yansi-0.5.1
	yubico-0.11.0
"

inherit cargo systemd

MULTER_COMMIT="477d16b7fa0f361b5c2a5ba18a5b28bec6d26a8a"

DESCRIPTION="Unofficial Bitwarden compatible server written in Rust"
HOMEPAGE="https://github.com/dani-garcia/vaultwarden"
SRC_URI="
	https://github.com/dani-garcia/vaultwarden/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/BlackDex/multer-rs/archive/${MULTER_COMMIT}.tar.gz -> multer-rs-${MULTER_COMMIT}.crate
	$(cargo_crate_uris)"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mysql postgres sqlite"

REQUIRED_USE="|| ( mysql postgres sqlite )"

ACCT_DEPEND="
	acct-group/vaultwarden
	acct-user/vaultwarden
"
DEPEND="
	${ACCT_DEPEND}
	>=app-admin/vaultwarden-web-vault-2022.10.0
	>=dev-lang/rust-1.60
	dev-libs/openssl:0=
	sqlite? ( dev-db/sqlite )
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i "/^multer/d" "${S}/Cargo.toml" || die

	default
}

src_configure() {
	myfeatures=(
		$(usev mysql)
		$(usex postgres postgresql '')
		$(usev sqlite)
	)
}

src_compile() {
	cargo_src_compile ${myfeatures:+--features "${myfeatures[*]}"} --no-default-features
}

src_install() {
	cargo_src_install ${myfeatures:+--features "${myfeatures[*]}"} --no-default-features

	einstalldocs

	# Install init.d and conf.d scripts
	newinitd "${FILESDIR}"/init vaultwarden
	newconfd "${FILESDIR}"/conf vaultwarden
	systemd_newunit "${FILESDIR}"/vaultwarden.service vaultwarden.service

	# Install /etc/vaultwarden.env
	insinto /etc
	newins .env.template vaultwarden.env
	fowners root:vaultwarden /etc/vaultwarden.env
	fperms 640 /etc/vaultwarden.env

	# Install launch wrapper
	exeinto /var/lib/vaultwarden
	doexe "${FILESDIR}"/vaultwarden

	# Keep data dir
	keepdir /var/lib/vaultwarden/data
	fowners vaultwarden:vaultwarden /var/lib/vaultwarden/data
	fperms 700 /var/lib/vaultwarden/data
}

src_test() {
	cargo_src_test ${myfeatures:+--features "${myfeatures[*]}"} --no-default-features
}
