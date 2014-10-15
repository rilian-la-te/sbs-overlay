# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/aide/aide-0.15.1.ebuild,v 1.6 2014/03/01 23:07:16 mgorny Exp $

EAPI="5"

inherit autotools confutils eutils git-2

DESCRIPTION="OSEC is AltLinux Security Tool"
HOMEPAGE="https://sourceforge.net/projects/o-security/"
EGIT_PROJECT='osec'
EGIT_REPO_URI="https://github.com/rilian-la-te/osec.git"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="static perl"

DEPEND="dev-db/tinycdb
	perl? ( dev-lang/perl )"

RDEPEND="!static? ( ${DEPEND} )"

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
#		$(use_with zlib) \
#		--sysconfdir="${EPREFIX}/etc/osec" \
#		 || die "econf failed"
#		$(use_with e2fsattrs) \
}

src_install() {
	emake DESTDIR="${D}" install install-man || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO data/osec.cron || die
#	dohtml doc/manual.html || die
}

pkg_postinst() {
	elog
	elog
}
