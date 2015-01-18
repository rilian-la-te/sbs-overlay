# Copyright 2014 athor (rilian-la-te)
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit autotools confutils eutils git-2 systemd

DESCRIPTION="OSEC is AltLinux Security Tool"
HOMEPAGE="https://sourceforge.net/projects/o-security/"
EGIT_PROJECT='osec'
EGIT_REPO_URI="https://github.com/rilian-la-te/osec.git"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+perl +cdb"
REQUIRED_USE="cdb"

DEPEND="cdb? ( dev-db/tinycdb )
	perl? ( dev-lang/perl )
	sys-libs/libcap"

RDEPEND="${DEPEND}"

DEPEND="${DEPEND}
	sys-devel/bison
	sys-devel/flex"

#pkg_setup() {

#}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}/etc/osec" \
		--datadir="${EPREFIX}/etc/osec" \
		 || die "econf failed"
#		$(use_with e2fsattrs) \
#		$(use_with acl posix-acl) \
#		$(use_with audit) \
#		$(use_with curl) \
#		$(use_with !mhash gcrypt) \
#		$(use_with mhash mhash) \
#		$(use_with nls locale) \
#		$(use_with postgres psql) \
#		$(use_with prelink) \
#		$(use_with selinux) \
#		$(use_enable static) \
#		$(use_with xattr) \
}

src_install() {
	emake DESTDIR="${D}" install install-man || die "emake install failed"

	nonfatal dodoc AUTHORS ChangeLog NEWS README TODO data/osec.timer
	rm "${D}/usr/bin/osec_rpm_reporter" 
	if use !perl; then
		rm "${D}/usr/bin/osec_mailer"
		rm "${D}/usr/bin/osec_reporter"
	fi
	
}

pkg_postinst() {
	elog "Simple config file installed to /etc/osec/dirs.conf"
	elog "Cron job are installed to docs. To use, copy it to appropriate folder"
	elog "To start use osec, run chmod -R +r from osec user on checked folders"
}
