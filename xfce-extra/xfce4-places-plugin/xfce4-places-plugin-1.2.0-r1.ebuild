# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-places-plugin/xfce4-places-plugin-1.2.0-r1.ebuild,v 1.2 2011/12/23 16:30:53 jer Exp $

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Places menu plug-in for panel, like GNOME's"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-places-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.2/${P}.tar.bz2
	mirror://debian/pool/main/x/${PN}/${PN}_${PV}-3.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug libnotify"

RDEPEND=">=dev-libs/glib-2.22
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/exo-0.6
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8
	libnotify? ( >=x11-libs/libnotify-0.7 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		$(use_enable libnotify notifications)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}

src_prepare() {
	EPATCH_FORCE=yes EPATCH_SUFFIX=patch EPATCH_SOURCE="${WORKDIR}"/debian/patches epatch
	xfconf_src_prepare
}
