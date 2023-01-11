# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd

DESCRIPTION="Community supported paperless: scan, index and archive your physical documents"
HOMEPAGE="https://github.com/paperless-ngx/paperless-ngx"
SRC_URI="https://github.com/paperless-ngx/paperless-ngx/releases/download/v${PV}/paperless-ngx-v${PV}.tar.xz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mysql +ocr postgres remote-redis +sqlite"
REQUIRED_USE="|| ( mysql postgres sqlite )"

ACCT_DEPEND="
	acct-group/paperless
	acct-user/paperless
"
EXTRA_DEPEND="
	app-text/unpaper
	dev-python/hiredis
"

DEPEND="
	${ACCT_DEPEND}
	${EXTRA_DEPEND}
	app-text/poppler[utils]
	app-text/pdfminer
	dev-python/asgiref
	dev-python/celery
	>=dev-python/channels-3.0
	<dev-python/channels-4.0
	>=dev-python/channels-redis-3.4.1
	<dev-python/channels-redis-4.0
	dev-python/concurrent-log-handler
	>=dev-python/dateparser-1.1
	>=dev-python/django-4.1
	dev-python/django-celery-results
	dev-python/django-cors-headers
	dev-python/django-extensions
	>=dev-python/django-filter-22.1
	dev-python/django-redis
	>=dev-python/djangorestframework-3.14
	dev-python/filelock
	dev-python/imap-tools
	>=dev-python/inotifyrecursive-0.3
	dev-python/langdetect
	dev-python/pathvalidate
	dev-python/pdf2image
	dev-python/pikepdf
	>=dev-python/pillow-9.3
	dev-python/python-dateutil
	dev-python/python-dotenv
	dev-python/python-gnupg
	dev-python/python-magic
	dev-python/pyzbar
	dev-python/rapidfuzz
	dev-python/redis-py
	dev-python/tqdm
	dev-python/uvicorn
	>=dev-python/watchdog-2.1
	>=dev-python/whitenoise-6.2
	>=dev-python/whoosh-2.7
	media-gfx/imagemagick
	media-gfx/optipng
	media-libs/jbig2enc
	www-servers/gunicorn
	mysql? ( dev-python/mysqlclient )
	ocr? ( >=app-text/OCRmyPDF-14.0 )
	postgres? ( dev-python/psycopg:2 )
	!remote-redis? ( dev-db/redis )
"
RDEPEND="${DEPEND}"
# dev-python/nltk - masked
# dev-python/requests - Tika
# tika
# sci-libs/scikit-learn (lots of deps)

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
	for dir in data media tmp; do
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
