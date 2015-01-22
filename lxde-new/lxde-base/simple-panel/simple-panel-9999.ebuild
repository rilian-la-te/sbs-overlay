# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxpanel/lxpanel-0.7.0-r1.ebuild,v 1.1 2014/09/10 01:54:45 nullishzero Exp $

EAPI="4"

inherit autotools eutils readme.gentoo versionator git-2

MAJOR_VER="$(get_version_component_range 1-2)"

DESCRIPTION="Lightweight desktop panel"
HOMEPAGE="http://lxde.org/"
EGIT_PROJECT='simple-panel'
EGIT_REPO_URI="https://github.com/rilian-la-te/simple-panel.git"
EGIT_BRANCH="gtk3-only"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86 ~x86-interix ~amd64-linux ~arm-linux ~x86-linux"
SLOT="0"
IUSE="+alsa wifi"
RESTRICT="test"  # bug 249598

RDEPEND="x11-libs/gtk+:3
	x11-libs/libwnck:3
	>=x11-libs/libfm-1.2.0[gtk3]
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	alsa? ( media-libs/alsa-lib )
	wifi? ( net-wireless/wireless-tools )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

DOC_CONTENTS="If you have problems with broken icons shown in the main panel,
you will have to configure panel settings via its menu.
This will not be an issue with first time installations."

src_prepare() {
	#bug #522404
#	epatch "${FILESDIR}"/${PN}-0.7.0-right-click-fix.patch
#	epatch "${FILESDIR}"/${PN}-0.5.9-sandbox.patch
	#bug #415595
	sed -i "s:-Werror::" configure.ac || die
	eautoreconf
}

src_configure() {
	local plugins="netstatus,volume,cpu,deskno,batt, \
		kbled,xkb,thermal,cpufreq,monitors,weather"

	use wifi && plugins+=",netstat"
	use alsa && plugins+=",volumealsa"
	[[ ${CHOST} == *-interix* ]] && plugins=deskno,kbled,xkb
	econf $(use_enable alsa) --with-x --with-plugins="${plugins}"
	# the gtk+ dep already pulls in libX11, so we might as well hardcode with-x
}

src_install () {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README.md

	# Get rid of the .la files.
	find "${D}" -name '*.la' -delete

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
