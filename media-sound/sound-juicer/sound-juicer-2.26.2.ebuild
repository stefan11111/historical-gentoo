# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sound-juicer/sound-juicer-2.26.2.ebuild,v 1.6 2010/03/12 21:28:00 ranger Exp $

EAPI="2"

inherit eutils gnome2

DESCRIPTION="CD ripper for GNOME 2"
HOMEPAGE="http://www.burtonini.com/blog/computers/sound-juicer/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="test"

# FIXME: possibly automagic dual slot dep on musicbrainz
COMMON_DEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.14

	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	media-libs/libcanberra[gtk]
	dev-libs/dbus-glib

	>=media-libs/musicbrainz-2.1.3:1
	>=media-libs/musicbrainz-3.0.2:3
	>=dev-libs/libcdio-0.70[-minimal]
	>=gnome-extra/gnome-media-2.11.91
	>=app-cdr/brasero-0.9.1

	>=media-libs/gstreamer-0.10.15:0.10
	>=media-libs/gst-plugins-base-0.10:0.10"

RDEPEND="${COMMON_DEPEND}
	>=media-plugins/gst-plugins-gconf-0.10:0.10
	>=media-plugins/gst-plugins-gio-0.10:0.10
	|| (
		>=media-plugins/gst-plugins-cdparanoia-0.10:0.10
		>=media-plugins/gst-plugins-cdio-0.10:0.10 )
	>=media-plugins/gst-plugins-meta-0.10-r2:0.10"

DEPEND="${COMMON_DEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.40
	>=app-text/scrollkeeper-0.3.5
	app-text/gnome-doc-utils
	test? ( ~app-text/docbook-xml-dtd-4.3 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"

	# needed to get around some sandboxing checks
	export GST_INSPECT=/bin/true
}

pkg_postinst() {
	gnome2_pkg_postinst
	ewarn
	ewarn "If ${PN} does not rip to some music format, please check your"
	ewarn "USE flags on media-plugins/gst-plugins-meta"
	ewarn
}
