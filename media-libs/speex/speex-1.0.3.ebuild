# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/speex/speex-1.0.3.ebuild,v 1.8 2005/04/26 13:02:56 flameeyes Exp $

IUSE="ogg sse"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Speex - Speech encoding library"
HOMEPAGE="http://www.speex.org"
SRC_URI="http://www.speex.org/download/${MY_P}.tar.gz"

SLOT="0"
LICENSE="BSD as-is"
KEYWORDS="~x86 ~hppa amd64 alpha ia64"

DEPEND="virtual/libc
	ogg? ( >=media-libs/libogg-1.0 )"

src_compile() {
	local myconf
	use ogg && myconf="--enable-ogg=yes --with-ogg-dir=/usr" \
		|| myconf="--enable-ogg=no"
	if [ "${ARCH}" != "amd64" ]
	then
		use sse && myconf="${myconf} --enable-sse"
	fi
	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
	rm -rf ${D}/usr/share/doc/*

	insinto /usr/share/doc/${P}
	doins ${S}/doc/manual.pdf
	dodoc AUTHORS ChangeLog README TODO NEWS
}

