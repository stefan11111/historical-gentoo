# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/liferea/liferea-0.9.7a.ebuild,v 1.1 2005/09/04 13:18:18 citizen428 Exp $

inherit gnome2

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="firefox gtkhtml mozilla"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.5.10
	firefox? ( www-client/mozilla-firefox )
	!firefox? ( mozilla? ( www-client/mozilla ) )
	gtkhtml? ( =gnome-extra/libgtkhtml-2* )
	!mozilla? ( !firefox? ( =gnome-extra/libgtkhtml-2* ) )
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="README AUTHORS ChangeLog COPYING"
USE_DESTDIR="1"

pkg_setup() {
	if ! use gtkhtml && ! use mozilla && ! use firefox ; then
		ewarn "None of the \"gtkhtml\", \"mozilla\" or \"firefox\" HTML backends"
		ewarn "was selected by USE flags. Will use \"gtkhtml\"."
	elif use mozilla && use firefox ; then
		ewarn "Both \"mozilla\" and \"firefox\" were selected by USE flags."
		ewarn "Will use \"firefox\"."
	fi
}

src_compile() {
	if ! use mozilla && ! use firefox || use gtkhtml ; then
		G2CONF="${G2CONF} --enable-gtkhtml2"
	else
		G2CONF="${G2CONF} --disable-gtkhtml2"
	fi
	if use firefox ; then
		G2CONF="${G2CONF} --enable-gecko=firefox"
	elif use mozilla ; then
		G2CONF="${G2CONF} --enable-gecko=mozilla"
	else
		G2CONF="${G2CONF} --disable-gecko"
	fi
	# disable DBus until >=0.3.0 is unmasked
	G2CONF="${G2CONF} --disable-dbus"
	gnome2_src_compile
}
