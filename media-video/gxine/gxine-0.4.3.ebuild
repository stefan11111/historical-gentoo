# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gxine/gxine-0.4.3.ebuild,v 1.1 2005/04/18 11:09:41 flameeyes Exp $

inherit eutils nsplugins fdo-mime

DESCRIPTION="GTK+ Front-End for libxine"
HOMEPAGE="http://xine.sourceforge.net/"
LICENSE="GPL-2"

DEPEND="media-libs/libpng
	>=media-libs/xine-lib-1_beta10
	>=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.4
	dev-lang/spidermonkey
	lirc? ( app-misc/lirc )
	X? ( virtual/x11 )"
RDEPEND="nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

IUSE="nls lirc mozilla"

SLOT="0"
# Those needs spidermonkey: ~ppc64 ~sparc
KEYWORDS="~x86 ~ppc ~amd64"

SRC_URI="mirror://sourceforge/xine/${P}.tar.gz"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.4.1-menu-fix.patch

	# Fix icon as per icon theme specs.
	sed -i -e 's:gxine-logo.png:gxine:' ${S}/gxine.desktop
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable lirc) \
		--disable-dependency-tracking || die
	emake || die
}

src_install() {
	make DESTDIR=${D} \
		docdir=/usr/share/doc/${PF} \
		docsdir=/usr/share/doc/${PF} \
		install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README

	insinto /usr/share/icons/hicolor/48x48/apps
	newins pixmaps/gxine-logo.png gxine.png

	use mozilla && inst_plugin /usr/$(get_libdir)/gxine/gxineplugin.so
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
