# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER=1.80.0

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	ahash@0.8.11
	aho-corasick@1.1.3
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	allocator-api2@0.2.21
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	argon2@0.5.3
	async-channel@1.9.0
	async-channel@2.3.1
	async-compression@0.4.18
	async-executor@1.13.1
	async-global-executor@2.4.1
	async-io@2.4.0
	async-lock@3.4.0
	async-process@2.3.0
	async-signal@0.2.10
	async-std@1.13.0
	async-stream-impl@0.3.6
	async-stream@0.3.6
	async-task@4.7.1
	async-trait@0.1.83
	atomic-waker@1.1.2
	atomic@0.5.3
	atomic@0.6.0
	autocfg@1.4.0
	backtrace@0.3.74
	base64@0.13.1
	base64@0.21.7
	base64@0.22.1
	base64ct@1.6.0
	bigdecimal@0.4.7
	binascii@0.1.4
	bitflags@2.6.0
	blake2@0.10.6
	block-buffer@0.10.4
	blocking@1.6.1
	brotli-decompressor@4.0.1
	brotli@7.0.0
	bumpalo@3.16.0
	bytemuck@1.20.0
	byteorder@1.5.0
	bytes@1.9.0
	cached@0.54.0
	cached_proc_macro@0.23.0
	cached_proc_macro_types@0.1.1
	cc@1.2.3
	cfg-if@1.0.0
	chrono-tz-build@0.4.0
	chrono-tz@0.10.0
	chrono@0.4.39
	chumsky@0.9.3
	codemap@0.1.3
	concurrent-queue@2.5.0
	cookie@0.18.1
	cookie_store@0.21.1
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	cpufeatures@0.2.16
	crc32fast@1.4.2
	cron@0.12.1
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	darling@0.20.10
	darling_core@0.20.10
	darling_macro@0.20.10
	dashmap@6.1.0
	data-encoding@2.6.0
	data-url@0.3.1
	deranged@0.3.11
	devise@0.4.2
	devise_codegen@0.4.2
	devise_core@0.4.2
	diesel@2.2.6
	diesel_derives@2.2.3
	diesel_logger@0.4.0
	diesel_migrations@2.2.0
	diesel_table_macro_syntax@0.2.0
	digest@0.10.7
	displaydoc@0.2.5
	document-features@0.2.10
	dotenvy@0.15.7
	dsl_auto_type@0.1.2
	either@1.13.0
	email-encoding@0.3.1
	email_address@0.2.9
	encoding_rs@0.8.35
	enum-as-inner@0.6.1
	equivalent@1.0.1
	errno@0.3.10
	event-listener-strategy@0.5.3
	event-listener@2.5.3
	event-listener@5.3.1
	fastrand@2.3.0
	figment@0.10.19
	flate2@1.0.35
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-lite@2.5.0
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-timer@3.0.3
	futures-util@0.3.31
	futures@0.3.31
	generator@0.7.5
	generic-array@0.14.7
	getrandom@0.2.15
	gimli@0.31.1
	glob@0.3.1
	gloo-timers@0.3.0
	governor@0.7.0
	grass_compiler@0.13.4
	h2@0.4.7
	half@1.8.3
	handlebars@6.2.0
	hashbrown@0.14.5
	hashbrown@0.15.2
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.4.0
	hickory-proto@0.24.2
	hickory-resolver@0.24.2
	hmac@0.12.1
	home@0.5.9
	hostname@0.3.1
	hostname@0.4.0
	html5gum@0.7.0
	http-body-util@0.1.2
	http-body@0.4.6
	http-body@1.0.1
	http@0.2.12
	http@1.2.0
	httparse@1.9.5
	httpdate@1.0.3
	hyper-rustls@0.27.3
	hyper-tls@0.6.0
	hyper-util@0.1.10
	hyper@0.14.31
	hyper@1.5.1
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.61
	icu_collections@1.5.0
	icu_locid@1.5.0
	icu_locid_transform@1.5.0
	icu_locid_transform_data@1.5.0
	icu_normalizer@1.5.0
	icu_normalizer_data@1.5.0
	icu_properties@1.5.1
	icu_properties_data@1.5.0
	icu_provider@1.5.0
	icu_provider_macros@1.5.0
	ident_case@1.0.1
	idna@1.0.3
	idna_adapter@1.2.0
	indexmap@2.7.0
	inlinable_string@0.1.15
	ipconfig@0.3.2
	ipnet@2.10.1
	is-terminal@0.4.13
	itoa@1.0.14
	jetscii@0.5.3
	job_scheduler_ng@2.0.5
	js-sys@0.3.76
	jsonwebtoken@9.3.0
	kv-log-macro@1.0.7
	lasso@0.7.3
	lazy_static@1.5.0
	lettre@0.11.11
	libc@0.2.168
	libm@0.2.11
	libmimalloc-sys@0.1.39
	libsqlite3-sys@0.30.1
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.14
	litemap@0.7.4
	litrs@0.4.1
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
	miniz_oxide@0.8.0
	mio@1.0.3
	multer@3.1.0
	mysqlclient-sys@0.4.2
	native-tls@0.2.12
	no-std-compat@0.4.1
	nom@7.1.3
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
	object@0.36.5
	once_cell@1.20.2
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.4.1+3.4.0
	openssl-sys@0.9.104
	openssl@0.10.68
	overload@0.1.1
	parking@2.2.1
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	parse-zoneinfo@0.3.1
	password-hash@0.5.0
	paste@1.0.15
	pear@0.2.9
	pear_codegen@0.2.9
	pem@3.0.4
	percent-encoding@2.3.1
	pest@2.7.15
	pest_derive@2.7.15
	pest_generator@2.7.15
	pest_meta@2.7.15
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.11.2
	pico-args@0.5.0
	pin-project-lite@0.2.15
	pin-utils@0.1.0
	piper@0.2.4
	pkg-config@0.3.31
	polling@3.7.4
	portable-atomic@1.10.0
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	pq-sys@0.6.3
	proc-macro2-diagnostics@0.10.1
	proc-macro2@1.0.92
	psl-types@2.0.11
	psm@0.1.24
	publicsuffix@2.3.0
	quanta@0.12.3
	quick-error@1.2.3
	quote@1.0.37
	quoted_printable@0.5.1
	r2d2@0.8.10
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	raw-cpuid@11.2.0
	redox_syscall@0.5.7
	ref-cast-impl@1.0.23
	ref-cast@1.0.23
	regex-automata@0.1.10
	regex-automata@0.4.9
	regex-syntax@0.6.29
	regex-syntax@0.8.5
	regex@1.11.1
	reopen@1.0.3
	reqwest@0.12.9
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
	rustix@0.38.42
	rustls-pemfile@1.0.4
	rustls-pemfile@2.2.0
	rustls-pki-types@1.10.0
	rustls-webpki@0.101.7
	rustls-webpki@0.102.8
	rustls@0.21.12
	rustls@0.23.19
	rustversion@1.0.18
	ryu@1.0.18
	same-file@1.0.6
	schannel@0.1.27
	scheduled-thread-pool@0.2.7
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sct@0.7.1
	security-framework-sys@2.12.1
	security-framework@2.11.1
	semver@1.0.23
	serde@1.0.215
	serde_cbor@0.11.2
	serde_derive@1.0.215
	serde_json@1.0.133
	serde_spanned@0.6.8
	serde_urlencoded@0.7.1
	sha1@0.10.6
	sha2@0.10.8
	sharded-slab@0.1.7
	shlex@1.3.0
	signal-hook-registry@1.4.2
	signal-hook@0.3.17
	simple_asn1@0.6.2
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.8
	spin@0.9.8
	spinning_top@0.3.0
	stable-pattern@0.1.0
	stable_deref_trait@1.2.0
	stacker@0.1.17
	state@0.6.0
	strsim@0.11.1
	subtle@2.6.1
	syn@2.0.90
	sync_wrapper@1.0.2
	synstructure@0.13.1
	syslog@7.0.0
	system-configuration-sys@0.6.0
	system-configuration@0.6.1
	tempfile@3.14.0
	thiserror-impl@1.0.69
	thiserror-impl@2.0.6
	thiserror@1.0.69
	thiserror@2.0.6
	thread_local@1.1.8
	threadpool@1.8.1
	time-core@0.1.2
	time-macros@0.2.19
	time@0.3.37
	tinystr@0.7.6
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	tokio-macros@2.4.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.24.1
	tokio-rustls@0.26.1
	tokio-socks@0.5.2
	tokio-stream@0.1.17
	tokio-tungstenite@0.21.0
	tokio-util@0.7.13
	tokio@1.42.0
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.22
	totp-lite@2.0.1
	tower-service@0.3.3
	tracing-attributes@0.1.28
	tracing-core@0.1.33
	tracing-log@0.2.0
	tracing-subscriber@0.3.19
	tracing@0.1.41
	try-lock@0.2.5
	tungstenite@0.21.0
	typenum@1.17.0
	ubyte@0.10.4
	ucd-trie@0.1.7
	uncased@0.9.10
	unicode-ident@1.0.14
	unicode-xid@0.2.6
	untrusted@0.9.0
	url@2.5.4
	utf-8@0.7.6
	utf16_iter@1.0.5
	utf8_iter@1.0.4
	uuid@1.11.0
	valuable@0.1.0
	value-bag@1.10.0
	vcpkg@0.2.15
	version_check@0.9.5
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.99
	wasm-bindgen-futures@0.4.49
	wasm-bindgen-macro-support@0.2.99
	wasm-bindgen-macro@0.2.99
	wasm-bindgen-shared@0.2.99
	wasm-bindgen@0.2.99
	wasm-streams@0.4.2
	web-sys@0.3.76
	web-time@1.1.0
	webauthn-rs@0.3.2
	which@7.0.0
	widestring@1.1.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-registry@0.2.0
	windows-result@0.2.0
	windows-strings@0.1.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows@0.48.0
	windows@0.52.0
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
	winnow@0.6.20
	winreg@0.50.0
	winsafe@0.0.19
	write16@1.0.0
	writeable@0.5.5
	yansi@1.0.1
	yoke-derive@0.7.5
	yoke@0.7.5
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zerofrom-derive@0.1.5
	zerofrom@0.1.5
	zeroize@1.8.1
	zerovec-derive@0.10.3
	zerovec@0.10.4
"

declare -A GIT_CRATES=(
	[fern]='https://github.com/daboross/fern;3e775ccfafe7d24baee39826d38011981b2e55b5;fern-%commit%'
	[yubico]='https://github.com/BlackDex/yubico-rs;00df14811f58155c0f02e3ab10f1570ed3e115c6;yubico-rs-%commit%'
)

inherit cargo systemd

DESCRIPTION="Unofficial Bitwarden compatible server written in Rust"
HOMEPAGE="https://github.com/dani-garcia/vaultwarden"
SRC_URI="
	https://github.com/dani-garcia/vaultwarden/archive/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

PATCHES=( "${FILESDIR}/rust-1.84.patch" )

LICENSE="AGPL-3"
# Dependent crate licenses
LICENSE+=" 0BSD Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0"
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
	sqlite? ( system-sqlite? ( >=dev-db/sqlite-3.46.0:3 ) )
	web? ( >=app-admin/vaultwarden-web-vault-2024.6.2c )
"
RDEPEND="${DEPEND}"

# rust does not use *FLAGS from make.conf, silence portage warning
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_prepare() {
	local crate_dir
	for crate in "${!GIT_CRATES[@]}"; do
		crate_dir=( "${WORKDIR}/${crate}"-* )
		sed -i \
			-e "/^${crate}/s|git.*|path = \"${crate_dir}/\" }|" \
			"${S}/Cargo.toml" || die
	done

	if use system-sqlite; then
		sed -i \
			-e 's/^\(libsqlite3-sys =.*\)features\s*=\s*\["bundled"\],/\1/g' \
			"${S}/Cargo.toml" || die
	fi

	default
	sed -i -r "s|^#?\s*(WEB_VAULT_ENABLED)\s*=.*|\1=$(use web && echo true || echo false)|" .env.template || die
}

src_configure() {
	local myfeatures=(
		$(usev mysql)
		$(usex postgres postgresql '')
		$(usev sqlite)
	)
	cargo_src_configure
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
