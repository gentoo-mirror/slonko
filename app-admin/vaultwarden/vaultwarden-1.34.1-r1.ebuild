# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER=1.85.0

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	ahash@0.8.12
	aho-corasick@1.1.3
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	allocator-api2@0.2.21
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	argon2@0.5.3
	async-channel@1.9.0
	async-channel@2.3.1
	async-compression@0.4.23
	async-executor@1.13.2
	async-global-executor@2.4.1
	async-io@2.4.1
	async-lock@3.4.0
	async-process@2.3.0
	async-signal@0.2.10
	async-std@1.13.1
	async-stream-impl@0.3.6
	async-stream@0.3.6
	async-task@4.7.1
	async-trait@0.1.88
	atomic-waker@1.1.2
	atomic@0.5.3
	atomic@0.6.0
	autocfg@1.4.0
	backtrace@0.3.75
	base64@0.13.1
	base64@0.21.7
	base64@0.22.1
	base64ct@1.7.3
	bigdecimal@0.4.8
	binascii@0.1.4
	bitflags@2.9.1
	blake2@0.10.6
	block-buffer@0.10.4
	blocking@1.6.1
	brotli-decompressor@5.0.0
	brotli@8.0.1
	bumpalo@3.17.0
	bytemuck@1.23.0
	byteorder@1.5.0
	bytes@1.10.1
	cached@0.55.1
	cached_proc_macro@0.24.0
	cached_proc_macro_types@0.1.1
	cc@1.2.24
	cfg-if@1.0.0
	chrono-tz-build@0.4.1
	chrono-tz@0.10.3
	chrono@0.4.41
	chumsky@0.9.3
	codemap@0.1.3
	concurrent-queue@2.5.0
	cookie@0.18.1
	cookie_store@0.21.1
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	cpufeatures@0.2.17
	crc32fast@1.4.2
	critical-section@1.2.0
	cron@0.15.0
	crossbeam-channel@0.5.15
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crypto-common@0.1.6
	darling@0.20.11
	darling_core@0.20.11
	darling_macro@0.20.11
	dashmap@6.1.0
	data-encoding@2.9.0
	data-url@0.3.1
	deranged@0.4.0
	derive_builder@0.20.2
	derive_builder_core@0.20.2
	derive_builder_macro@0.20.2
	derive_more-impl@2.0.1
	derive_more@2.0.1
	devise@0.4.2
	devise_codegen@0.4.2
	devise_core@0.4.2
	diesel-derive-newtype@2.1.2
	diesel@2.2.10
	diesel_derives@2.2.5
	diesel_logger@0.4.0
	diesel_migrations@2.2.0
	diesel_table_macro_syntax@0.2.0
	digest@0.10.7
	displaydoc@0.2.5
	document-features@0.2.11
	dotenvy@0.15.7
	dsl_auto_type@0.1.3
	either@1.15.0
	email-encoding@0.4.1
	email_address@0.2.9
	encoding_rs@0.8.35
	enum-as-inner@0.6.1
	env_home@0.1.0
	equivalent@1.0.2
	errno@0.3.12
	event-listener-strategy@0.5.4
	event-listener@2.5.3
	event-listener@5.4.0
	fastrand@2.3.0
	fern@0.7.1
	figment@0.10.19
	flate2@1.1.1
	fnv@1.0.7
	foldhash@0.1.5
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-lite@2.6.0
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-timer@3.0.3
	futures-util@0.3.31
	futures@0.3.31
	generator@0.7.5
	generator@0.8.5
	generic-array@0.14.7
	getrandom@0.2.16
	getrandom@0.3.3
	gimli@0.31.1
	glob@0.3.2
	gloo-timers@0.3.0
	governor@0.10.0
	grass_compiler@0.13.4
	h2@0.4.10
	half@1.8.3
	handlebars@6.3.2
	hashbrown@0.14.5
	hashbrown@0.15.3
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.5.1
	hickory-proto@0.25.2
	hickory-resolver@0.25.2
	hmac@0.12.1
	hostname@0.4.1
	html5gum@0.7.0
	http-body-util@0.1.3
	http-body@0.4.6
	http-body@1.0.1
	http@0.2.12
	http@1.3.1
	httparse@1.10.1
	httpdate@1.0.3
	hyper-rustls@0.27.6
	hyper-tls@0.6.0
	hyper-util@0.1.12
	hyper@0.14.32
	hyper@1.6.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.63
	icu_collections@2.0.0
	icu_locale_core@2.0.0
	icu_normalizer@2.0.0
	icu_normalizer_data@2.0.0
	icu_properties@2.0.1
	icu_properties_data@2.0.1
	icu_provider@2.0.0
	ident_case@1.0.1
	idna@1.0.3
	idna_adapter@1.2.1
	indexmap@2.9.0
	inlinable_string@0.1.15
	ipconfig@0.3.2
	ipnet@2.11.0
	is-terminal@0.4.16
	itoa@1.0.15
	jetscii@0.5.3
	job_scheduler_ng@2.2.0
	js-sys@0.3.77
	jsonwebtoken@9.3.1
	kv-log-macro@1.0.7
	lasso@0.7.3
	lazy_static@1.5.0
	lettre@0.11.16
	libc@0.2.172
	libm@0.2.15
	libmimalloc-sys@0.1.42
	libsqlite3-sys@0.33.0
	linux-raw-sys@0.4.15
	linux-raw-sys@0.9.4
	litemap@0.8.0
	litrs@0.4.1
	lock_api@0.4.12
	log@0.4.27
	loom@0.5.6
	loom@0.7.2
	matchers@0.1.0
	memchr@2.7.4
	migrations_internals@2.2.0
	migrations_macros@2.2.0
	mimalloc@0.1.46
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.8.8
	mio@1.0.4
	moka@0.12.10
	multer@3.1.0
	mysqlclient-sys@0.4.5
	native-tls@0.2.14
	nom@7.1.3
	nom@8.0.0
	nonzero_ext@0.3.0
	nu-ansi-term@0.46.0
	num-bigint@0.4.6
	num-conv@0.1.0
	num-derive@0.4.2
	num-integer@0.1.46
	num-modular@0.6.1
	num-order@1.2.0
	num-traits@0.2.19
	num_cpus@1.16.0
	num_threads@0.1.7
	object@0.36.7
	once_cell@1.21.3
	openssl-macros@0.1.1
	openssl-probe@0.1.6
	openssl-src@300.5.0+3.5.0
	openssl-sys@0.9.108
	openssl@0.10.72
	overload@0.1.1
	parking@2.2.1
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	parse-zoneinfo@0.3.1
	password-hash@0.5.0
	paste@1.0.15
	pastey@0.1.0
	pear@0.2.9
	pear_codegen@0.2.9
	pem@3.0.5
	percent-encoding@2.3.1
	pest@2.8.0
	pest_derive@2.8.0
	pest_generator@2.8.0
	pest_meta@2.8.0
	phf@0.11.3
	phf_codegen@0.11.3
	phf_generator@0.11.3
	phf_macros@0.11.3
	phf_shared@0.11.3
	pico-args@0.5.0
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	piper@0.2.4
	pkg-config@0.3.32
	polling@3.8.0
	portable-atomic@1.11.0
	potential_utf@0.1.2
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	pq-sys@0.7.1
	proc-macro2-diagnostics@0.10.1
	proc-macro2@1.0.95
	psl-types@2.0.11
	psm@0.1.26
	publicsuffix@2.3.0
	quanta@0.12.5
	quote@1.0.40
	quoted_printable@0.5.1
	r-efi@5.2.0
	r2d2@0.8.10
	rand@0.8.5
	rand@0.9.1
	rand_chacha@0.3.1
	rand_chacha@0.9.0
	rand_core@0.6.4
	rand_core@0.9.3
	raw-cpuid@11.5.0
	redox_syscall@0.5.12
	ref-cast-impl@1.0.24
	ref-cast@1.0.24
	regex-automata@0.1.10
	regex-automata@0.4.9
	regex-syntax@0.6.29
	regex-syntax@0.8.5
	regex@1.11.1
	reopen@1.0.3
	reqwest@0.12.15
	resolv-conf@0.7.4
	ring@0.17.14
	rmp@0.8.14
	rmpv@1.3.0
	rocket@0.5.1
	rocket_codegen@0.5.1
	rocket_http@0.5.1
	rocket_ws@0.1.1
	rpassword@7.4.0
	rtoolbox@0.0.3
	rustc-demangle@0.1.24
	rustc_version@0.4.1
	rustix@0.38.44
	rustix@1.0.7
	rustls-pemfile@1.0.4
	rustls-pemfile@2.2.0
	rustls-pki-types@1.12.0
	rustls-webpki@0.101.7
	rustls-webpki@0.103.3
	rustls@0.21.12
	rustls@0.23.27
	rustversion@1.0.21
	ryu@1.0.20
	same-file@1.0.6
	schannel@0.1.27
	scheduled-thread-pool@0.2.7
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sct@0.7.1
	security-framework-sys@2.14.0
	security-framework@2.11.1
	semver@1.0.26
	serde@1.0.219
	serde_cbor@0.11.2
	serde_derive@1.0.219
	serde_json@1.0.140
	serde_spanned@0.6.8
	serde_urlencoded@0.7.1
	sha1@0.10.6
	sha2@0.10.9
	sharded-slab@0.1.7
	shlex@1.3.0
	signal-hook-registry@1.4.5
	signal-hook@0.3.18
	simple_asn1@0.6.3
	siphasher@1.0.1
	slab@0.4.9
	smallvec@1.15.0
	socket2@0.5.10
	spin@0.9.8
	spinning_top@0.3.0
	stable-pattern@0.1.0
	stable_deref_trait@1.2.0
	stacker@0.1.21
	state@0.6.0
	strsim@0.11.1
	subtle@2.6.1
	syn@2.0.101
	sync_wrapper@1.0.2
	synstructure@0.13.2
	syslog@7.0.0
	system-configuration-sys@0.6.0
	system-configuration@0.6.1
	tagptr@0.2.0
	tempfile@3.20.0
	thiserror-impl@1.0.69
	thiserror-impl@2.0.12
	thiserror@1.0.69
	thiserror@2.0.12
	thread_local@1.1.8
	threadpool@1.8.1
	time-core@0.1.4
	time-macros@0.2.22
	time@0.3.41
	tinystr@0.8.1
	tinyvec@1.9.0
	tinyvec_macros@0.1.1
	tokio-macros@2.5.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.24.1
	tokio-rustls@0.26.2
	tokio-socks@0.5.2
	tokio-stream@0.1.17
	tokio-tungstenite@0.21.0
	tokio-util@0.7.15
	tokio@1.45.1
	toml@0.8.22
	toml_datetime@0.6.9
	toml_edit@0.22.26
	toml_write@0.1.1
	totp-lite@2.0.1
	tower-layer@0.3.3
	tower-service@0.3.3
	tower@0.5.2
	tracing-attributes@0.1.28
	tracing-core@0.1.33
	tracing-log@0.2.0
	tracing-subscriber@0.3.19
	tracing@0.1.41
	try-lock@0.2.5
	tungstenite@0.21.0
	typenum@1.18.0
	ubyte@0.10.4
	ucd-trie@0.1.7
	uncased@0.9.10
	unicode-ident@1.0.18
	unicode-xid@0.2.6
	untrusted@0.9.0
	url@2.5.4
	utf-8@0.7.6
	utf8_iter@1.0.4
	uuid@1.17.0
	valuable@0.1.1
	value-bag@1.11.1
	vcpkg@0.2.15
	version_check@0.9.5
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-futures@0.4.50
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	wasm-streams@0.4.2
	web-sys@0.3.77
	web-time@1.1.0
	webauthn-rs@0.3.2
	which@7.0.3
	widestring@1.2.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-collections@0.2.0
	windows-core@0.61.2
	windows-future@0.2.1
	windows-implement@0.60.0
	windows-interface@0.59.1
	windows-link@0.1.1
	windows-numerics@0.2.0
	windows-registry@0.4.0
	windows-result@0.3.4
	windows-strings@0.3.1
	windows-strings@0.4.2
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows-targets@0.53.0
	windows-threading@0.1.0
	windows@0.48.0
	windows@0.61.1
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.0
	winnow@0.6.26
	winnow@0.7.10
	winreg@0.50.0
	winsafe@0.0.19
	wit-bindgen-rt@0.39.0
	writeable@0.6.1
	yansi@1.0.1
	yoke-derive@0.8.0
	yoke@0.8.0
	yubico_ng@0.13.0
	zerocopy-derive@0.8.25
	zerocopy@0.8.25
	zerofrom-derive@0.1.6
	zerofrom@0.1.6
	zeroize@1.8.1
	zerotrie@0.2.2
	zerovec-derive@0.11.1
	zerovec@0.11.2
"

inherit cargo systemd

DESCRIPTION="Unofficial Bitwarden compatible server written in Rust"
HOMEPAGE="https://github.com/dani-garcia/vaultwarden"
SRC_URI="
	https://github.com/dani-garcia/vaultwarden/archive/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="AGPL-3"
# Dependent crate licenses
LICENSE+=" 0BSD Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0 ZLIB"
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
	sqlite? ( system-sqlite? ( >=dev-db/sqlite-3.49.1:3 ) )
	web? ( >=www-apps/vaultwarden-web-2025.5.0 )
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
	sed -i -r \
		-e "s|^#?\s*(WEB_VAULT_ENABLED)\s*=.*|\1=$(use web && echo true || echo false)|" \
		-e "s|^#?\s*(WEB_VAULT_FOLDER)\s*=.*|\1=/usr/share/webapps/vaultwarden-web|" \
		.env.template || die
}

src_configure() {
	local myfeatures=(
		$(usev mysql)
		$(usex postgres postgresql '')
		$(usev sqlite)
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	cargo_src_compile
}

src_install() {
	cargo_src_install

	einstalldocs

	# Install init.d and conf.d scripts
	newinitd "${FILESDIR}"/vaultwarden.init vaultwarden
	newconfd "${FILESDIR}"/vaultwarden.conf vaultwarden
	systemd_newunit "${FILESDIR}"/vaultwarden.service vaultwarden.service

	# Install /etc/vaultwarden.env
	insinto /etc
	newins .env.template vaultwarden.env
	fowners root:vaultwarden /etc/vaultwarden.env
	fperms 640 /etc/vaultwarden.env

	# Keep data dir
	keepdir /var/lib/vaultwarden/data
	fowners vaultwarden:vaultwarden /var/lib/vaultwarden/data
	fperms 700 /var/lib/vaultwarden/data
}

src_test() {
	cargo_src_test
}
