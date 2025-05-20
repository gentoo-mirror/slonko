# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1 systemd

DESCRIPTION="Community supported paperless: scan, index and archive your physical documents"
HOMEPAGE="https://github.com/paperless-ngx/paperless-ngx"
SRC_URI="https://github.com/paperless-ngx/paperless-ngx/releases/download/v${PV}/paperless-ngx-v${PV}.tar.xz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="audit compression mysql +ocr postgres remote-redis +sqlite zxing"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	|| ( mysql postgres sqlite )
"

ACCT_DEPEND="
	acct-group/paperless
	acct-user/paperless
"
EXTRA_DEPEND="
	app-text/unpaper
	$(python_gen_cond_dep '
		dev-python/hiredis[${PYTHON_USEDEP}]
		dev-python/websockets[${PYTHON_USEDEP}]')
"
ALLAUTH_MFA_DEPEND="
	$(python_gen_cond_dep '
		>=dev-python/fido2-1.1.2[${PYTHON_USEDEP}]
		>=dev-python/qrcode-7.0.0[${PYTHON_USEDEP}]')
"
DEPEND="
	${ACCT_DEPEND}
	${ALLAUTH_MFA_DEPEND}
	${EXTRA_DEPEND}
	${PYTHON_DEPS}
	app-text/poppler[utils]
	$(python_gen_cond_dep '
		>=dev-python/bleach-6.2.0[${PYTHON_USEDEP}]
		>=dev-python/celery-5.5.1[${PYTHON_USEDEP}]
		>=dev-python/channels-4.2[${PYTHON_USEDEP}]
		>=dev-python/channels-redis-4.2[${PYTHON_USEDEP}]
		>=dev-python/concurrent-log-handler-0.9.25[${PYTHON_USEDEP}]
		>=dev-python/dateparser-1.2[${PYTHON_USEDEP}]
		>=dev-python/django-5.1.7[${PYTHON_USEDEP}]
		<dev-python/django-5.2[${PYTHON_USEDEP}]
		>=dev-python/django-allauth-65.4.0[${PYTHON_USEDEP}]
		>=dev-python/django-celery-results-2.6.0[${PYTHON_USEDEP}]
		>=dev-python/django-cors-headers-4.7.0[${PYTHON_USEDEP}]
		>=dev-python/django-extensions-4.1[${PYTHON_USEDEP}]
		>=dev-python/django-filter-25.1[${PYTHON_USEDEP}]
		>=dev-python/django-guardian-2.4.0[${PYTHON_USEDEP}]
		dev-python/django-multiselectfield[${PYTHON_USEDEP}]
		dev-python/django-redis[${PYTHON_USEDEP}]
		>=dev-python/django-soft-delete-1.0.18[${PYTHON_USEDEP}]
		>=dev-python/djangorestframework-3.15.2[${PYTHON_USEDEP}]
		>=dev-python/djangorestframework-guardian-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/drf-spectacular-0.28[${PYTHON_USEDEP}]
		>=dev-python/drf-spectacular-sidecar-2025.4.1[${PYTHON_USEDEP}]
		>=dev-python/drf-writable-nested-0.7.1[${PYTHON_USEDEP}]
		>=dev-python/filelock-3.18.0[${PYTHON_USEDEP}]
		>=dev-python/gotenberg-client-0.10.0[${PYTHON_USEDEP}]
		>=dev-python/httpx-oauth-0.16[${PYTHON_USEDEP}]
		dev-python/humanize[${PYTHON_USEDEP}]
		>=dev-python/imap-tools-1.10.0[${PYTHON_USEDEP}]
		>=dev-python/inotifyrecursive-0.3[${PYTHON_USEDEP}]
		>=dev-python/jinja2-3.1.5[${PYTHON_USEDEP}]
		>=dev-python/langdetect-1.0.9[${PYTHON_USEDEP}]
		>=dev-python/nltk-3.9.1[${PYTHON_USEDEP}]
		>=dev-python/pathvalidate-3.2.3[${PYTHON_USEDEP}]
		>=dev-python/pdf2image-1.17.0[${PYTHON_USEDEP}]
		dev-python/pikepdf[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		>=dev-python/python-dateutil-2.9.0[${PYTHON_USEDEP}]
		>=dev-python/python-dotenv-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/python-gnupg-0.5.4[${PYTHON_USEDEP}]
		>=dev-python/python-ipware-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-magic-0.4.27[${PYTHON_USEDEP}]
		>=dev-python/pyzbar-0.1.9[${PYTHON_USEDEP}]
		>=dev-python/rapidfuzz-3.13.0[${PYTHON_USEDEP}]
		>=dev-python/redis-5.2.1[${PYTHON_USEDEP}]
		>=dev-python/scikit-learn-1.6.1[${PYTHON_USEDEP}]
		>=dev-python/setproctitle-1.3.4[${PYTHON_USEDEP}]
		>=dev-python/tika-client-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.67.1[${PYTHON_USEDEP}]
		dev-python/uvloop[${PYTHON_USEDEP}]
		>=dev-python/watchdog-6.0[${PYTHON_USEDEP}]
		>=dev-python/whitenoise-6.9[${PYTHON_USEDEP}]
		>=dev-python/whoosh-reloaded-2.7.5[${PYTHON_USEDEP}]
		>=www-servers/granian-2.2.0[${PYTHON_USEDEP}]')
	media-gfx/imagemagick[xml]
	media-gfx/optipng
	media-libs/jbig2enc
	audit? ( $(python_gen_cond_dep '
		>=dev-python/django-auditlog-3.1.2[${PYTHON_USEDEP}]') )
	compression? ( $(python_gen_cond_dep '
		>=dev-python/django-compression-middleware-0.5.0[${PYTHON_USEDEP}]') )
	mysql? ( >=dev-python/mysqlclient-2.2.7 )
	ocr? ( >=app-text/OCRmyPDF-16.10 )
	postgres? ( $(python_gen_cond_dep '
		>=dev-python/psycopg-3.2.5[native-extensions,${PYTHON_USEDEP}]') )
	!remote-redis? ( dev-db/redis )
	zxing? ( >=media-libs/zxing-cpp-2.3.0[python,${PYTHON_SINGLE_USEDEP}] )
"
RDEPEND="${DEPEND}"

DOCS=( docker/rootfs/etc/ImageMagick-6/paperless-policy.xml )

src_prepare() {
	default

	sed \
		-e "s|#PAPERLESS_CONSUMPTION_DIR=../consume|PAPERLESS_CONSUMPTION_DIR=/var/lib/paperless/consume|" \
		-e "s|#PAPERLESS_DATA_DIR=../data|PAPERLESS_DATA_DIR=/var/lib/paperless/data|" \
		-e "s|#PAPERLESS_MEDIA_ROOT=../media|PAPERLESS_MEDIA_ROOT=/var/lib/paperless/media|" \
		-e "s|#PAPERLESS_STATICDIR=../static|PAPERLESS_STATICDIR=/usr/share/paperless/static|" \
		-e "s|#PAPERLESS_CONVERT_TMPDIR=/var/tmp/paperless|PAPERLESS_CONVERT_TMPDIR=/var/lib/paperless/tmp|" \
		-i "paperless.conf" || die "Cannot update paperless.conf"

	cat >> "paperless.conf" <<- EOF

	# Custom
	GRANIAN_HOST=127.0.0.1
	GRANIAN_PORT=8000
	GRANIAN_WORKERS=1

	PAPERLESS_ENABLE_COMPRESSION=$(use compression && echo true || echo false)
	PAPERLESS_AUDIT_LOG_ENABLED=$(use audit && echo true || echo false)
	EOF
}

src_install() {
	einstalldocs

	# Install service files
	systemd_newunit "${FILESDIR}"/paperless-webserver-granian.service paperless-webserver.service
	systemd_newunit "${FILESDIR}"/paperless-scheduler.service paperless-scheduler.service
	systemd_newunit "${FILESDIR}"/paperless-consumer.service paperless-consumer.service
	systemd_newunit "${FILESDIR}"/paperless-task-queue.service paperless-task-queue.service
	systemd_newunit "${FILESDIR}"/paperless.target paperless.target
	if use remote-redis; then
		sed -e '/redis\.service/d' -i *.service "${D}$(systemd_get_systemunitdir)"/*.service
	fi

	# Install paperless files
	insinto /usr/share/paperless
	doins -r docs src static

	insinto /etc
	doins paperless.conf
	fowners root:paperless /etc/paperless.conf
	fperms 640 /etc/paperless.conf

	insinto /usr/lib/tmpfiles.d
	doins "${FILESDIR}"/paperless.tmpfiles
	fperms 644 /usr/lib/tmpfiles.d/paperless.tmpfiles

	# Set directories
	for dir in consume data media tmp; do
		keepdir /var/lib/paperless/${dir}
		fowners paperless:paperless /var/lib/paperless/${dir}
		case "${dir}" in
		data) fperms 700 /var/lib/paperless/${dir} ;;
		*)    fperms 750 /var/lib/paperless/${dir} ;;
		esac
	done

	# Main executable
	fperms 755 "/usr/share/paperless/src/manage.py"
	dosym -r "/usr/share/paperless/src/manage.py" "/usr/bin/paperless-manage"
}

pkg_postinst() {
	elog "To complete the installation of paperless, edit /etc/paperless.conf file and"
	elog "* Create the database with"
	elog ""
	elog "sudo -u paperless paperless-manage migrate"
	elog ""
	elog "* Create a super user account with"
	elog ""
	elog "sudo -u paperless paperless-manage createsuperuser"
	elog ""
	elog "After each update of paperless, you should run migration with"
	elog ""
	elog "sudo -u paperless paperless-manage migrate"
	elog ""
	elog "Paperless services can be started together with"
	elog ""
	elog "sudo systemctl start paperless.target"
}
