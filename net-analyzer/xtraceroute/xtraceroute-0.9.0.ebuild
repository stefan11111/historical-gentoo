# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xtraceroute/xtraceroute-0.9.0.ebuild,v 1.13 2004/04/29 09:40:52 dholm Exp $

DESCRIPTION="neat graphical traceroute displaying route on the globe"
SRC_URI="http://www.dtek.chalmers.se/~d3august/xt/dl/${P}.tar.gz
	http://www.dtek.chalmers.se/~d3august/xt/dl/ndg_files.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/~d3august/xt/"

KEYWORDS="x86 sparc ~ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE="nls"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	net-analyzer/traceroute
	<x11-libs/gtkglarea-1.99.0
	media-libs/gdk-pixbuf
	net-misc/host"

src_compile() {
	# specify --from-code to fix bug 25395 (01 Aug 2003 agriffis)
	XGETTEXT='/usr/bin/xgettext --from-code=ISO-8859-1' \
	./configure \
		`use_enable nls` \
		--host=${CHOST} \
		--prefix=/usr \
		--with-host=/usr/bin/hostx \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die "emake failed"
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "make install failed"

	# Install documentation.
	dodoc AUTHORS NEWS README TODO || die "dodoc failed"

	#Install NDG loc database
	cd ${D}/usr/share/xtraceroute/
	unpack "ndg_files.tar.gz"
}
