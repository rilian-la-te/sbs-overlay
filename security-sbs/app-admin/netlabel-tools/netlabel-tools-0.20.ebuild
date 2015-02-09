# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
SLOT="0"
inherit eutils autotools flag-o-matic
MY_PN=netlabel_tools
S=${WORKDIR}/${MY_PN}-${PV}
SRC_URI="mirror://sourceforge/project/netlabel/${MY_PN}/${PV}/${MY_PN}-${PV}.tar.gz"

IUSE="systemd doc"

RDEPEND="dev-libs/libnl:1.1"
DEPEND="doc? ( app-doc/doxygen )"

src_unpack() {
    if [ "${A}" != "" ]; then
        unpack ${A}
    fi
    cd "${MY_PN}-${PV}"
}

src_prepare() {
	epatch ${FILESDIR}/${P}-alt-build-netlabelctl.patch
	epatch ${FILESDIR}/${P}-alt-s0-mark-flag.patch
	if ! use doc ; then
		sed -i 's/doc//g' Makefile || die
	fi
}

src_configure() {
	econf \
	$(use_enable systemd)
}
