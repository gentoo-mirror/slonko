# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

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
	dev-python/hiredis
	dev-python/websockets
"

DEPEND="
	${ACCT_DEPEND}
	${EXTRA_DEPEND}
	${PYTHON_DEPS}
	app-text/poppler[utils]
	$(python_gen_cond_dep '
		dev-python/asgiref[${PYTHON_USEDEP}]
		dev-python/bleach[${PYTHON_USEDEP}]
		dev-python/celery[${PYTHON_USEDEP}]
		>=dev-python/channels-4.0[${PYTHON_USEDEP}]
		>=dev-python/channels-redis-4.0[${PYTHON_USEDEP}]
		dev-python/concurrent-log-handler[${PYTHON_USEDEP}]
		>=dev-python/dateparser-1.2[${PYTHON_USEDEP}]
		>=dev-python/django-4.2.9[${PYTHON_USEDEP}]
		<dev-python/django-5.0[${PYTHON_USEDEP}]
		dev-python/django-celery-results[${PYTHON_USEDEP}]
		dev-python/django-cors-headers[${PYTHON_USEDEP}]
		dev-python/django-extensions[${PYTHON_USEDEP}]
		>=dev-python/django-filter-23.5[${PYTHON_USEDEP}]
		dev-python/django-guardian[${PYTHON_USEDEP}]
		dev-python/django-multiselectfield[${PYTHON_USEDEP}]
		dev-python/django-redis[${PYTHON_USEDEP}]
		>=dev-python/djangorestframework-3.14[${PYTHON_USEDEP}]
		dev-python/djangorestframework-guardian[${PYTHON_USEDEP}]
		dev-python/drf-writable-nested[${PYTHON_USEDEP}]
		dev-python/filelock[${PYTHON_USEDEP}]
		dev-python/imap-tools[${PYTHON_USEDEP}]
		>=dev-python/inotifyrecursive-0.3[${PYTHON_USEDEP}]
		dev-python/langdetect[${PYTHON_USEDEP}]
		dev-python/nltk[${PYTHON_USEDEP}]
		dev-python/pathvalidate[${PYTHON_USEDEP}]
		dev-python/pdf2image[${PYTHON_USEDEP}]
		dev-python/pikepdf[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/python-dotenv[${PYTHON_USEDEP}]
		dev-python/python-gnupg[${PYTHON_USEDEP}]
		>=dev-python/python-ipware-2.0.0[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/pyzbar[${PYTHON_USEDEP}]
		dev-python/rapidfuzz[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
		>=dev-python/scikit-learn-1.3
		dev-python/tqdm[${PYTHON_USEDEP}]
		<dev-python/uvicorn-0.26.0[${PYTHON_USEDEP}]
		>=dev-python/watchdog-3.0[${PYTHON_USEDEP}]
		>=dev-python/whitenoise-6.6[${PYTHON_USEDEP}]
		>=dev-python/whoosh-2.7[${PYTHON_USEDEP}]')
	media-gfx/imagemagick[xml]
	media-gfx/optipng
	media-libs/jbig2enc
	www-servers/gunicorn
	audit? ( $(python_gen_cond_dep '
		dev-python/django-auditlog[${PYTHON_USEDEP}]') )
	compression? ( $(python_gen_cond_dep '
		dev-python/django-compression-middleware[${PYTHON_USEDEP}]') )
	mysql? ( dev-python/mysqlclient )
	ocr? ( >=app-text/OCRmyPDF-15.4 )
	postgres? ( dev-python/psycopg:2 )
	!remote-redis? ( dev-db/redis )
	zxing? ( media-libs/zxing-cpp[python,${PYTHON_SINGLE_USEDEP}] )
"
RDEPEND="${DEPEND}"
# dev-python/tika
# dev-python/gotenberg-client

DOCS=( docker/imagemagick-policy.xml )

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
	PAPERLESS_ENABLE_COMPRESSION=$(use compression && echo true || echo false)
	PAPERLESS_AUDIT_LOG_ENABLED=$(use audit && echo true || echo false)
	EOF
}

src_install() {
	einstalldocs

	# Install service files
	systemd_newunit "${FILESDIR}"/paperless-webserver.service paperless-webserver.service
	systemd_newunit "${FILESDIR}"/paperless-scheduler.service paperless-scheduler.service
	systemd_newunit "${FILESDIR}"/paperless-consumer.service paperless-consumer.service
	systemd_newunit "${FILESDIR}"/paperless-task-queue.service paperless-task-queue.service
	systemd_newunit "${FILESDIR}"/paperless.target paperless.target
	if use remote-redis; then
		sed -e '/redis\.service/d' -i *.service "${D}$(systemd_get_systemunitdir)"/*.service
	fi

	# Install paperless files
	insinto /usr/share/paperless
	doins -r docs src static gunicorn.conf.py requirements.txt

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
