# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-power-manager/xfce4-power-manager-1.2.0.ebuild,v 1.2 2012/05/05 07:19:57 mgorny Exp $

EAPI=4
inherit flag-o-matic linux-info xfconf

DESCRIPTION="Power manager for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-power-manager"
SRC_URI="mirror://xfce/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug kernel_linux networkmanager policykit +xfce_plugins_brightness"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.24
	>=sys-power/upower-0.9.15
	>=x11-libs/gtk+-2.20:2
	>=x11-libs/libnotify-0.7
	>=x11-libs/libXrandr-1.2
	x11-libs/libX11
	x11-libs/libXext
	>=xfce-base/xfconf-4.10
	>=xfce-base/libxfce4ui-4.10
	>=xfce-base/libxfce4util-4.10
	kernel_linux? ( sys-fs/udisks:0 )
	policykit? ( >=sys-auth/polkit-0.104-r1 )
	xfce_plugins_brightness? ( >=xfce-base/xfce4-panel-4.10 )"
RDEPEND="${COMMON_DEPEND}
	networkmanager? ( net-misc/networkmanager )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
	x11-proto/xproto"

pkg_setup() {
	if use kernel_linux; then
		CONFIG_CHECK="~TIMER_STATS"
		linux-info_pkg_setup
	fi

	XFCONF=(
		$(use_enable policykit polkit)
		--enable-dpms
		$(use_enable networkmanager network-manager)
		$(use_enable xfce_plugins_brightness panel-plugins)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}

src_install() {
	xfconf_src_install \
		docdir=/usr/share/doc/${PF}/html \
		imagesdir=/usr/share/doc/${PF}/html/images
}
