# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jhead/jhead-2.90.ebuild,v 1.6 2011/12/11 17:49:17 armin76 Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Exif Jpeg camera setting parser and thumbnail remover"
HOMEPAGE="http://www.sentex.net/~mwandel/jhead"
SRC_URI="http://www.sentex.net/~mwandel/${PN}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 ~ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

src_prepare() {
	# bug 275200 - respect flags and use mktemp instead of mkstemp
	epatch "${FILESDIR}"/${P}-mkstemp_respect_flags.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	dobin ${PN}
	dodoc *.txt
	dohtml *.html
	doman ${PN}.1
}
