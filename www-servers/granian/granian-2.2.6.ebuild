# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=yes
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{10..13} )

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aes@0.8.4
	anyhow@1.0.98
	arc-swap@1.7.1
	atomic-waker@1.1.2
	autocfg@1.4.0
	backtrace@0.3.75
	base64@0.22.1
	base64ct@1.7.3
	bitflags@2.9.0
	block-buffer@0.10.4
	block-padding@0.3.3
	bus@2.4.1
	bytes@1.10.1
	cbc@0.1.2
	cc@1.2.21
	cfg-if@1.0.0
	cipher@0.4.4
	const-oid@0.9.6
	cpufeatures@0.2.17
	crossbeam-channel@0.5.15
	crossbeam-utils@0.8.21
	crypto-common@0.1.6
	data-encoding@2.8.0
	der@0.7.10
	digest@0.10.7
	either@1.15.0
	equivalent@1.0.2
	fnv@1.0.7
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	futures@0.3.31
	generic-array@0.14.7
	getrandom@0.2.16
	getrandom@0.3.2
	gimli@0.31.1
	h2@0.4.10
	hashbrown@0.15.3
	heck@0.5.0
	hermit-abi@0.3.9
	hmac@0.12.1
	http-body-util@0.1.3
	http-body@1.0.1
	http@1.3.1
	httparse@1.10.1
	httpdate@1.0.3
	hyper-util@0.1.11
	hyper@1.6.0
	indexmap@2.9.0
	indoc@2.0.6
	inout@0.1.4
	itertools@0.14.0
	itoa@1.0.15
	libc@0.2.172
	libmimalloc-sys@0.1.42
	lock_api@0.4.12
	log@0.4.27
	memchr@2.7.4
	memoffset@0.9.1
	mimalloc@0.1.46
	miniz_oxide@0.8.8
	mio@1.0.3
	num_cpus@1.16.0
	object@0.36.7
	once_cell@1.21.3
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	pbkdf2@0.12.2
	pem@3.0.5
	percent-encoding@2.3.1
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkcs5@0.7.1
	pkcs8@0.10.2
	portable-atomic@1.11.0
	ppv-lite86@0.2.21
	proc-macro2@1.0.95
	pyo3-build-config@0.24.2
	pyo3-ffi@0.24.2
	pyo3-log@0.12.3
	pyo3-macros-backend@0.24.2
	pyo3-macros@0.24.2
	pyo3@0.24.2
	python3-dll-a@0.2.13
	quote@1.0.40
	r-efi@5.2.0
	rand@0.9.1
	rand_chacha@0.9.0
	rand_core@0.6.4
	rand_core@0.9.3
	redox_syscall@0.5.12
	ring@0.17.14
	rustc-demangle@0.1.24
	rustls-pemfile@2.2.0
	rustls-pki-types@1.12.0
	rustls-webpki@0.103.2
	rustls@0.23.27
	salsa20@0.10.2
	scopeguard@1.2.0
	scrypt@0.11.0
	serde@1.0.219
	serde_derive@1.0.219
	sha1@0.10.6
	sha2@0.10.9
	shlex@1.3.0
	signal-hook-registry@1.4.5
	slab@0.4.9
	smallvec@1.15.0
	socket2@0.5.8
	spki@0.7.3
	subtle@2.6.1
	syn@2.0.101
	target-lexicon@0.13.2
	thiserror-impl@2.0.12
	thiserror@2.0.12
	tikv-jemalloc-sys@0.6.0+5.3.0-1-ge13ca993e8ccb9ba9847cc330696e02839f328f7
	tikv-jemallocator@0.6.0
	tls-listener@0.11.0
	tokio-macros@2.5.0
	tokio-rustls@0.26.2
	tokio-stream@0.1.17
	tokio-tungstenite@0.26.2
	tokio-util@0.7.15
	tokio@1.44.2
	tracing-core@0.1.33
	tracing@0.1.41
	tungstenite@0.26.2
	typenum@1.18.0
	unicode-ident@1.0.18
	unindent@0.2.4
	untrusted@0.9.0
	utf-8@0.7.6
	version_check@0.9.5
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	windows-sys@0.52.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	wit-bindgen-rt@0.39.0
	zerocopy-derive@0.8.25
	zerocopy@0.8.25
	zeroize@1.8.1
"

inherit cargo distutils-r1 pypi

DESCRIPTION="A Rust HTTP server for Python applications"
HOMEPAGE="
	https://github.com/emmett-framework/granian
	https://pypi.org/project/granian/
"
SRC_URI+="
	${CARGO_CRATE_URIS}
"
LICENSE="BSD"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD ISC MIT Unicode-3.0
"
SLOT="0"
KEYWORDS="amd64"

DOCS=( README.md )

RDEPEND="
	>=dev-python/click-8.0.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
"

BDEPEND="
	${RUST_DEPEND}
	test? (
		>=dev-python/httpx-0.28[${PYTHON_USEDEP}]
		>=dev-python/pytest-asyncio-0.26[${PYTHON_USEDEP}]
		>=dev-python/sniffio-1.3[${PYTHON_USEDEP}]
		>=dev-python/websockets-15.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_unpack() {
	cargo_src_unpack
}

python_test() {
	rm -rf granian || die
	epytest
}
