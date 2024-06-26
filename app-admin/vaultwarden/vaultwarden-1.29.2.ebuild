# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.20.0
	adler@1.0.2
	aho-corasick@1.0.3
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	argon2@0.5.1
	async-channel@1.9.0
	async-compression@0.4.1
	async-executor@1.5.1
	async-global-executor@2.3.1
	async-io@1.13.0
	async-lock@2.8.0
	async-process@1.7.0
	async-std@1.12.0
	async-stream@0.3.5
	async-stream-impl@0.3.5
	async-task@4.4.0
	async-trait@0.1.73
	atomic@0.5.3
	atomic-waker@1.1.1
	autocfg@1.1.0
	backtrace@0.3.68
	base64@0.13.1
	base64@0.21.2
	base64ct@1.6.0
	binascii@0.1.4
	bitflags@1.3.2
	bitflags@2.4.0
	blake2@0.10.6
	block-buffer@0.10.4
	blocking@1.3.1
	brotli@3.3.4
	brotli-decompressor@2.3.4
	bumpalo@3.13.0
	byteorder@1.4.3
	bytes@1.4.0
	cached@0.44.0
	cached_proc_macro@0.17.0
	cached_proc_macro_types@0.1.0
	cc@1.0.82
	cfg-if@1.0.0
	chrono@0.4.26
	chrono-tz@0.8.3
	chrono-tz-build@0.2.0
	concurrent-queue@2.2.0
	cookie@0.16.2
	cookie@0.17.0
	cookie_store@0.16.2
	cookie_store@0.19.1
	core-foundation@0.9.3
	core-foundation-sys@0.8.4
	cpufeatures@0.2.9
	crc32fast@1.3.2
	cron@0.12.0
	crossbeam-utils@0.8.16
	crypto-common@0.1.6
	darling@0.14.4
	darling_core@0.14.4
	darling_macro@0.14.4
	dashmap@5.5.0
	data-encoding@2.4.0
	data-url@0.3.0
	deranged@0.3.7
	devise@0.4.1
	devise_codegen@0.4.1
	devise_core@0.4.1
	diesel@2.1.0
	diesel_derives@2.1.0
	diesel_logger@0.3.0
	diesel_migrations@2.1.0
	diesel_table_macro_syntax@0.1.0
	digest@0.10.7
	dotenvy@0.15.7
	either@1.9.0
	email-encoding@0.2.0
	email_address@0.2.4
	encoding_rs@0.8.32
	enum-as-inner@0.5.1
	equivalent@1.0.1
	errno@0.3.2
	errno-dragonfly@0.1.2
	error-chain@0.12.4
	event-listener@2.5.3
	fastrand@1.9.0
	fastrand@2.0.0
	fern@0.6.2
	figment@0.10.10
	flate2@1.0.26
	fnv@1.0.7
	foreign-types@0.3.2
	foreign-types-shared@0.1.1
	form_urlencoded@1.2.0
	futures@0.3.28
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-executor@0.3.28
	futures-io@0.3.28
	futures-lite@1.13.0
	futures-macro@0.3.28
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-timer@3.0.2
	futures-util@0.3.28
	generator@0.7.5
	generic-array@0.14.7
	getrandom@0.2.10
	gimli@0.27.3
	glob@0.3.1
	gloo-timers@0.2.6
	governor@0.6.0
	h2@0.3.20
	half@1.8.2
	handlebars@4.3.7
	hashbrown@0.12.3
	hashbrown@0.13.2
	hashbrown@0.14.0
	heck@0.4.1
	hermit-abi@0.3.2
	hmac@0.12.1
	hostname@0.3.1
	html5gum@0.5.7
	http@0.2.9
	http-body@0.4.5
	httparse@1.8.0
	httpdate@1.0.3
	hyper@0.14.27
	hyper-tls@0.5.0
	iana-time-zone@0.1.57
	iana-time-zone-haiku@0.1.2
	ident_case@1.0.1
	idna@0.2.3
	idna@0.3.0
	idna@0.4.0
	indexmap@1.9.3
	indexmap@2.0.0
	inlinable_string@0.1.15
	instant@0.1.12
	io-lifetimes@1.0.11
	ipconfig@0.3.2
	ipnet@2.8.0
	is-terminal@0.4.9
	itoa@1.0.9
	jetscii@0.5.3
	job_scheduler_ng@2.0.4
	js-sys@0.3.64
	jsonwebtoken@8.3.0
	kv-log-macro@1.0.7
	lazy_static@1.4.0
	lettre@0.10.4
	libc@0.2.147
	libmimalloc-sys@0.1.33
	libsqlite3-sys@0.26.0
	linked-hash-map@0.5.6
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.5
	lock_api@0.4.10
	log@0.4.20
	loom@0.5.6
	lru-cache@0.1.2
	mach2@0.4.1
	match_cfg@0.1.0
	matchers@0.1.0
	matches@0.1.10
	memchr@2.5.0
	migrations_internals@2.1.0
	migrations_macros@2.1.0
	mimalloc@0.1.37
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	mio@0.8.8
	multer@2.1.0
	mysqlclient-sys@0.2.5
	native-tls@0.2.11
	no-std-compat@0.4.1
	nom@7.1.3
	nonzero_ext@0.3.0
	nu-ansi-term@0.46.0
	num-bigint@0.4.3
	num-derive@0.4.0
	num-integer@0.1.45
	num-traits@0.2.16
	num_cpus@1.16.0
	num_threads@0.1.6
	object@0.31.1
	once_cell@1.18.0
	openssl@0.10.56
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@111.27.0+1.1.1v
	openssl-sys@0.9.91
	overload@0.1.1
	parking@2.1.0
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	parse-zoneinfo@0.3.0
	password-hash@0.5.0
	paste@1.0.14
	pear@0.2.7
	pear_codegen@0.2.7
	pem@1.1.1
	percent-encoding@2.3.0
	pest@2.7.2
	pest_derive@2.7.2
	pest_generator@2.7.2
	pest_meta@2.7.2
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_shared@0.11.2
	pico-args@0.5.0
	pin-project-lite@0.2.12
	pin-utils@0.1.0
	pkg-config@0.3.27
	polling@2.8.0
	ppv-lite86@0.2.17
	pq-sys@0.4.8
	proc-macro2@1.0.66
	proc-macro2-diagnostics@0.10.1
	psl-types@2.0.11
	publicsuffix@2.2.3
	quanta@0.11.1
	quick-error@1.2.3
	quote@1.0.32
	quoted_printable@0.4.8
	r2d2@0.8.10
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	raw-cpuid@10.7.0
	redox_syscall@0.3.5
	ref-cast@1.0.19
	ref-cast-impl@1.0.19
	regex@1.9.3
	regex-automata@0.1.10
	regex-automata@0.3.6
	regex-syntax@0.6.29
	regex-syntax@0.7.4
	reqwest@0.11.18
	resolv-conf@0.7.0
	ring@0.16.20
	rmp@0.8.12
	rmpv@1.0.1
	rpassword@7.2.0
	rtoolbox@0.0.1
	rustc-demangle@0.1.23
	rustix@0.37.23
	rustix@0.38.8
	rustls@0.21.6
	rustls-pemfile@1.0.3
	rustls-webpki@0.101.4
	rustversion@1.0.14
	ryu@1.0.15
	same-file@1.0.6
	schannel@0.1.22
	scheduled-thread-pool@0.2.7
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sct@0.7.0
	security-framework@2.9.2
	security-framework-sys@2.9.1
	semver@1.0.18
	serde@1.0.183
	serde_cbor@0.11.2
	serde_derive@1.0.183
	serde_json@1.0.104
	serde_spanned@0.6.3
	serde_urlencoded@0.7.1
	sha-1@0.10.1
	sha1@0.10.5
	sha2@0.10.7
	sharded-slab@0.1.4
	signal-hook@0.3.17
	signal-hook-registry@1.4.1
	simple_asn1@0.6.2
	siphasher@0.3.10
	slab@0.4.8
	smallvec@1.11.0
	socket2@0.4.9
	socket2@0.5.3
	spin@0.5.2
	spin@0.9.8
	stable-pattern@0.1.0
	state@0.6.0
	strsim@0.10.0
	subtle@2.5.0
	syn@1.0.109
	syn@2.0.28
	syslog@6.1.0
	tempfile@3.7.1
	thiserror@1.0.44
	thiserror-impl@1.0.44
	thread_local@1.1.7
	threadpool@1.8.1
	time@0.3.25
	time-core@0.1.1
	time-macros@0.2.11
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio@1.31.0
	tokio-macros@2.1.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.24.1
	tokio-socks@0.5.1
	tokio-stream@0.1.14
	tokio-tungstenite@0.19.0
	tokio-util@0.7.8
	toml@0.7.6
	toml_datetime@0.6.3
	toml_edit@0.19.14
	totp-lite@2.0.0
	tower-service@0.3.2
	tracing@0.1.37
	tracing-attributes@0.1.26
	tracing-core@0.1.31
	tracing-log@0.1.3
	tracing-subscriber@0.3.17
	trust-dns-proto@0.22.0
	trust-dns-resolver@0.22.0
	try-lock@0.2.4
	tungstenite@0.19.0
	typenum@1.16.0
	ubyte@0.10.3
	ucd-trie@0.1.6
	uncased@0.9.9
	unicode-bidi@0.3.13
	unicode-ident@1.0.11
	unicode-normalization@0.1.22
	unicode-xid@0.2.4
	untrusted@0.7.1
	url@2.4.0
	utf-8@0.7.6
	uuid@1.4.1
	valuable@0.1.0
	value-bag@1.4.1
	vcpkg@0.2.15
	version_check@0.9.4
	waker-fn@1.1.0
	walkdir@2.3.3
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.87
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-futures@0.4.37
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-streams@0.2.3
	web-sys@0.3.64
	webauthn-rs@0.3.2
	which@4.4.0
	widestring@1.0.2
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.48.0
	windows-sys@0.48.0
	windows-targets@0.48.1
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.48.0
	winnow@0.5.10
	winreg@0.10.1
	winreg@0.50.0
	yansi@0.5.1
	yansi@1.0.0-rc.1
	yubico@0.11.0
"
declare -A GIT_CRATES=(
	[rocket]="https://github.com/SergioBenitez/Rocket;ce441b5f46fdf5cd99cb32b8b8638835e4c2a5fa;Rocket-%commit%/core/lib"
	[rocket_ws]="https://github.com/SergioBenitez/Rocket;ce441b5f46fdf5cd99cb32b8b8638835e4c2a5fa;Rocket-%commit%/contrib/ws"
)

inherit cargo systemd

DESCRIPTION="Unofficial Bitwarden compatible server written in Rust"
HOMEPAGE="https://github.com/dani-garcia/vaultwarden"
SRC_URI="
	https://github.com/dani-garcia/vaultwarden/archive/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mysql postgres +sqlite system-sqlite"

REQUIRED_USE="|| ( mysql postgres sqlite )"

ACCT_DEPEND="
	acct-group/vaultwarden
	acct-user/vaultwarden
"
DEPEND="
	${ACCT_DEPEND}
	>=app-admin/vaultwarden-web-vault-2023.7.1
	dev-libs/openssl:0=
	>=virtual/rust-1.69.0
	sqlite? ( system-sqlite? ( >=dev-db/sqlite-3.41.2:3 ) )
"
RDEPEND="${DEPEND}"

src_prepare() {
	# Force update of vulnerable rustls-webpki
	sed -i\
		-e '/^name = "rustls-webpki"/ {n; s/0\.101\.3/0.101.4/; n; n; s/261e9e0888cba427c3316e6322805653c9425240b6fd96cee7cb671ab70ab8d0/7d93931baf2d282fff8d3a532bbfd7653f734643161b87e3e01e59a04439bf0d/}' \
		"${S}/Cargo.lock" || die
	sed -i \
		-e '/^rocket /d' \
		-e 's/^rocket_ws = {\(.*\)}.*/rocket = {features = ["tls", "json"], default-features = false, \1}\nrocket_ws = {\1}\n/' \
		"${S}/Cargo.toml" || die
	if use system-sqlite; then
		sed -i \
			-e 's/^\(libsqlite3-sys =.*\)features\s*=\s*\["bundled"\],/\1/g' \
			"${S}/Cargo.toml" || die
	fi

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
