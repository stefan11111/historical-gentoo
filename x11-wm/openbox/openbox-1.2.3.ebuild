# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-1.2.3.ebuild,v 1.3 2002/07/10 19:07:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="ftp://sunsite.dk/projects/openbox/${P}.tar.gz"
HOMEPAGE="http://openbox.sunsite.dk"

DEPEND="virtual/x11"
	
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

PROVIDE="virtual/blackbox"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

src_compile() {
	local myconf
	use nls	\
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	use kde 	\
		&& myconf="${myconf} --enable-kde" \
		&& export KDEDIR=/usr/kde/2 \
		|| myconf="${myconf} --disable-kde"

	use gnome 	\
		&& myconf="${myconf} --enable-gnome" \
		|| myconf="${myconf} --disable-gnome"
	 	
	econf \
		--with-x \
		--enable-shape \
		--enable-slit \
		--enable-interlace \
		--enable-clobber \
		${myconf} || die

	emake || die
}

src_install () {

	einstall \
		sysconfdir=${D}/etc/X11/openbox || die

	dodoc CHANGE* AUTHORS INSTALL README* TODO LICENSE BUGS CodingStyle
	docinto data
	dodoc data/README*

	dodir /etc/X11/Sessions
	echo "/usr/bin/openbox" > ${D}/etc/X11/Sessions/openbox
	chmod +x ${D}/etc/X11/Sessions/openbox
}
