# Copyright 2014 Athor (rilian-la-te)
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git-2

DESCRIPTION="pwd-force-locker is small utility that sets passwords expired after each shutdown"
HOMEPAGE="https://github.com/rilian-la-te/pwd-force-locker"
EGIT_PROJECT='pwd-force-locker'
EGIT_REPO_URI="https://github.com/rilian-la-te/pwd-screen-locker.git"
SRC_URI=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
        emake FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" bindir="${D}/usr/bin" libdir="${D}/lib" install
}
