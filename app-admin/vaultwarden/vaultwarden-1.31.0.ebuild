# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.22.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	allocator-api2@0.2.18
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	argon2@0.5.3
	async-channel@1.9.0
	async-channel@2.3.1
	async-compression@0.4.11
	async-executor@1.12.0
	async-global-executor@2.4.1
	async-io@1.13.0
	async-io@2.3.3
	async-lock@2.8.0
	async-lock@3.4.0
	async-process@1.8.1
	async-signal@0.2.8
	async-std@1.12.0
	async-stream@0.3.5
	async-stream-impl@0.3.5
	async-task@4.7.1
	async-trait@0.1.81
	atomic@0.5.3
	atomic@0.6.0
	atomic-waker@1.1.2
	autocfg@1.3.0
	backtrace@0.3.73
	base64@0.13.1
	base64@0.21.7
	base64@0.22.1
	base64ct@1.6.0
	bigdecimal@0.4.5
	binascii@0.1.4
	bitflags@1.3.2
	bitflags@2.6.0
	blake2@0.10.6
	block-buffer@0.10.4
	blocking@1.6.1
	brotli@6.0.0
	brotli-decompressor@4.0.1
	bumpalo@3.16.0
	bytemuck@1.16.1
	byteorder@1.5.0
	bytes@1.6.0
	cached@0.52.0
	cached_proc_macro@0.22.0
	cached_proc_macro_types@0.1.1
	cc@1.0.106
	cfg-if@1.0.0
	chrono@0.4.38
	chrono-tz@0.9.0
	chrono-tz-build@0.3.0
	chumsky@0.9.3
	concurrent-queue@2.5.0
	cookie@0.18.1
	cookie_store@0.21.0
	core-foundation@0.9.4
	core-foundation-sys@0.8.6
	cpufeatures@0.2.12
	crc32fast@1.4.2
	cron@0.12.1
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	darling@0.20.9
	darling_core@0.20.9
	darling_macro@0.20.9
	dashmap@5.5.3
	dashmap@6.0.1
	data-encoding@2.6.0
	data-url@0.3.1
	deranged@0.3.11
	devise@0.4.1
	devise_codegen@0.4.1
	devise_core@0.4.1
	diesel@2.2.1
	diesel_derives@2.2.1
	diesel_logger@0.3.0
	diesel_migrations@2.2.0
	diesel_table_macro_syntax@0.2.0
	digest@0.10.7
	dotenvy@0.15.7
	dsl_auto_type@0.1.1
	either@1.13.0
	email-encoding@0.3.0
	email_address@0.2.5
	encoding_rs@0.8.34
	enum-as-inner@0.6.0
	equivalent@1.0.1
	errno@0.3.9
	error-chain@0.12.4
	event-listener@2.5.3
	event-listener@3.1.0
	event-listener@5.3.1
	event-listener-strategy@0.5.2
	fastrand@1.9.0
	fastrand@2.1.0
	fern@0.6.2
	figment@0.10.19
	flate2@1.0.30
	fnv@1.0.7
	foreign-types@0.3.2
	foreign-types-shared@0.1.1
	form_urlencoded@1.2.1
	futures@0.3.30
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-lite@1.13.0
	futures-lite@2.3.0
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-timer@3.0.3
	futures-util@0.3.30
	generator@0.7.5
	generic-array@0.14.7
	getrandom@0.2.15
	gimli@0.29.0
	glob@0.3.1
	gloo-timers@0.2.6
	governor@0.6.3
	h2@0.3.26
	h2@0.4.5
	half@1.8.3
	handlebars@5.1.2
	hashbrown@0.14.5
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.4.0
	hickory-proto@0.24.1
	hickory-resolver@0.24.1
	hmac@0.12.1
	home@0.5.9
	hostname@0.3.1
	hostname@0.4.0
	html5gum@0.5.7
	http@0.2.12
	http@1.1.0
	http-body@0.4.6
	http-body@1.0.0
	http-body-util@0.1.2
	httparse@1.9.4
	httpdate@1.0.3
	hyper@0.14.29
	hyper@1.4.0
	hyper-rustls@0.27.2
	hyper-tls@0.5.0
	hyper-tls@0.6.0
	hyper-util@0.1.6
	iana-time-zone@0.1.60
	iana-time-zone-haiku@0.1.2
	ident_case@1.0.1
	idna@0.3.0
	idna@0.4.0
	idna@0.5.0
	indexmap@2.2.6
	inlinable_string@0.1.15
	instant@0.1.13
	io-lifetimes@1.0.11
	ipconfig@0.3.2
	ipnet@2.9.0
	is-terminal@0.4.12
	itoa@1.0.11
	jetscii@0.5.3
	job_scheduler_ng@2.0.5
	js-sys@0.3.69
	jsonwebtoken@9.3.0
	kv-log-macro@1.0.7
	lazy_static@1.5.0
	lettre@0.11.7
	libc@0.2.155
	libm@0.2.8
	libmimalloc-sys@0.1.39
	libsqlite3-sys@0.28.0
	linked-hash-map@0.5.6
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	loom@0.5.6
	lru-cache@0.1.2
	match_cfg@0.1.0
	matchers@0.1.0
	memchr@2.7.4
	migrations_internals@2.2.0
	migrations_macros@2.2.0
	mimalloc@0.1.43
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.4
	mio@0.8.11
	multer@3.1.0
	mysqlclient-sys@0.4.0
	native-tls@0.2.12
	no-std-compat@0.4.1
	nom@7.1.3
	nonzero_ext@0.3.0
	nu-ansi-term@0.46.0
	num-bigint@0.4.6
	num-conv@0.1.0
	num-derive@0.4.2
	num-integer@0.1.46
	num-traits@0.2.19
	num_cpus@1.16.0
	num_threads@0.1.7
	object@0.36.1
	once_cell@1.19.0
	openssl@0.10.64
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.3.1+3.3.1
	openssl-sys@0.9.102
	overload@0.1.1
	parking@2.2.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	parse-zoneinfo@0.3.1
	password-hash@0.5.0
	paste@1.0.15
	pear@0.2.9
	pear_codegen@0.2.9
	pem@3.0.4
	percent-encoding@2.3.1
	pest@2.7.11
	pest_derive@2.7.11
	pest_generator@2.7.11
	pest_meta@2.7.11
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_shared@0.11.2
	pico-args@0.5.0
	pin-project@1.1.5
	pin-project-internal@1.1.5
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	piper@0.2.3
	pkg-config@0.3.30
	polling@2.8.0
	polling@3.7.2
	portable-atomic@1.6.0
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	pq-sys@0.6.1
	proc-macro2@1.0.86
	proc-macro2-diagnostics@0.10.1
	psl-types@2.0.11
	psm@0.1.21
	publicsuffix@2.2.3
	quanta@0.12.3
	quick-error@1.2.3
	quote@1.0.36
	quoted_printable@0.5.0
	r2d2@0.8.10
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	raw-cpuid@11.0.2
	redox_syscall@0.5.2
	ref-cast@1.0.23
	ref-cast-impl@1.0.23
	regex@1.10.5
	regex-automata@0.1.10
	regex-automata@0.4.7
	regex-syntax@0.6.29
	regex-syntax@0.8.4
	reopen@1.0.3
	reqwest@0.11.27
	reqwest@0.12.5
	resolv-conf@0.7.0
	ring@0.17.8
	rmp@0.8.14
	rmpv@1.3.0
	rocket@0.5.1
	rocket_codegen@0.5.1
	rocket_http@0.5.1
	rocket_ws@0.1.1
	rpassword@7.3.1
	rtoolbox@0.0.2
	rustc-demangle@0.1.24
	rustix@0.37.27
	rustix@0.38.34
	rustls@0.21.12
	rustls@0.23.11
	rustls-pemfile@1.0.4
	rustls-pemfile@2.1.2
	rustls-pki-types@1.7.0
	rustls-webpki@0.101.7
	rustls-webpki@0.102.5
	rustversion@1.0.17
	ryu@1.0.18
	same-file@1.0.6
	schannel@0.1.23
	scheduled-thread-pool@0.2.7
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sct@0.7.1
	security-framework@2.11.0
	security-framework-sys@2.11.0
	semver@1.0.23
	serde@1.0.204
	serde_cbor@0.11.2
	serde_derive@1.0.204
	serde_json@1.0.120
	serde_spanned@0.6.6
	serde_urlencoded@0.7.1
	sha1@0.10.6
	sha2@0.10.8
	sharded-slab@0.1.7
	signal-hook@0.3.17
	signal-hook-registry@1.4.2
	simple_asn1@0.6.2
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.4.10
	socket2@0.5.7
	spin@0.9.8
	spinning_top@0.3.0
	stable-pattern@0.1.0
	stacker@0.1.15
	state@0.6.0
	strsim@0.11.1
	subtle@2.6.1
	syn@2.0.70
	sync_wrapper@0.1.2
	sync_wrapper@1.0.1
	syslog@6.1.1
	system-configuration@0.5.1
	system-configuration-sys@0.5.0
	tempfile@3.10.1
	thiserror@1.0.61
	thiserror-impl@1.0.61
	thread_local@1.1.8
	threadpool@1.8.1
	time@0.3.36
	time-core@0.1.2
	time-macros@0.2.18
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	tokio@1.38.0
	tokio-macros@2.3.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.24.1
	tokio-rustls@0.26.0
	tokio-socks@0.5.1
	tokio-stream@0.1.15
	tokio-tungstenite@0.21.0
	tokio-util@0.7.11
	toml@0.8.14
	toml_datetime@0.6.6
	toml_edit@0.22.15
	totp-lite@2.0.1
	tower@0.4.13
	tower-layer@0.3.2
	tower-service@0.3.2
	tracing@0.1.40
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-log@0.2.0
	tracing-subscriber@0.3.18
	try-lock@0.2.5
	tungstenite@0.21.0
	typenum@1.17.0
	ubyte@0.10.4
	ucd-trie@0.1.6
	uncased@0.9.10
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	unicode-xid@0.2.4
	untrusted@0.9.0
	url@2.5.2
	utf-8@0.7.6
	uuid@1.9.1
	valuable@0.1.0
	value-bag@1.9.0
	vcpkg@0.2.15
	version_check@0.9.4
	waker-fn@1.2.0
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.92
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-futures@0.4.42
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-streams@0.4.0
	web-sys@0.3.69
	webauthn-rs@0.3.2
	which@6.0.1
	widestring@1.1.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.48.0
	windows@0.52.0
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.6.13
	winreg@0.50.0
	winreg@0.52.0
	winsafe@0.0.19
	yansi@1.0.1
	yubico@0.11.0
	zerocopy@0.7.35
	zerocopy-derive@0.7.35
	zeroize@1.8.1
"

inherit cargo systemd

DESCRIPTION="Unofficial Bitwarden compatible server written in Rust"
HOMEPAGE="https://github.com/dani-garcia/vaultwarden"
SRC_URI="
	https://github.com/dani-garcia/vaultwarden/archive/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mysql postgres +sqlite system-sqlite +web"

REQUIRED_USE="|| ( mysql postgres sqlite )"

ACCT_DEPEND="
	acct-group/vaultwarden
	acct-user/vaultwarden
"
DEPEND="
	${ACCT_DEPEND}
	dev-libs/openssl:0=
	>=virtual/rust-1.78.0
	sqlite? ( system-sqlite? ( >=dev-db/sqlite-3.45.0:3 ) )
	web? ( >=app-admin/vaultwarden-web-vault-2024.5.1b )
"
RDEPEND="${DEPEND}"

# rust does not use *FLAGS from make.conf, silence portage warning
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_prepare() {
	if use system-sqlite; then
		sed -i \
			-e 's/^\(libsqlite3-sys =.*\)features\s*=\s*\["bundled"\],/\1/g' \
			"${S}/Cargo.toml" || die
	fi

	default
	sed -i -r "s|^#?\s*(WEB_VAULT_ENABLED)\s*=.*|\1=$(use web && echo true || echo false)|" .env.template || die
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
