# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gxine/gxine-0.4.1.ebuild,v 1.1 2005/01/23 10:40:48 corsair Exp $

inherit eutils nsplugins fdo-mime

DESCRIPTION="GTK+ Front-End for libxine"
HOMEPAGE="http://xine.sourceforge.net/"
LICENSE="GPL-2"

DEPEND="media-libs/libpng
	>=media-libs/xine-lib-1_beta10
	>=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.4
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )"
RDEPEND="nls? ( sys-devel/gettext )"

IUSE="X nls lirc"

SLOT="0"
KEYWORDS="~x86 ~ppc sparc ~amd64 ~ppc64"

SRC_URI="mirror://sourceforge/xine/${P}.tar.gz"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-menu-fix.patch
}

src_compile() {
	# Most of these are not working currently, but are here for completeness
	local myconf
	use X || myconf="${myconf} --disable-x11 --disable-xv"

	myconf="${myconf} $(use_enable nls)"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

	insinto /usr/share/pixmaps
	doins pixmaps/gxine-logo.png

	inst_plugin /usr/$(get_libdir)/gxine/gxineplugin.so
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
