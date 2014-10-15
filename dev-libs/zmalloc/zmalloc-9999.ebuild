# Copyright 2014 Athor (rilian-la-te)
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git-2

DESCRIPTION="ZMalloc is AltLinux secure allocator"
HOMEPAGE="http://www.sisyphus.ru/en/srpm/Sisyphus/libzmalloc"
EGIT_PROJECT='libzmalloc'
EGIT_REPO_URI="https://github.com/rilian-la-te/libzmalloc.git"
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
