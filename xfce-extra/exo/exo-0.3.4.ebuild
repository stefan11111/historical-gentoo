# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/exo/exo-0.3.4.ebuild,v 1.13 2008/11/14 15:53:48 angelos Exp $

inherit eutils xfce44 python multilib autotools

XFCE_VERSION=4.4.2
xfce44
xfce44_core_package

DESCRIPTION="Extensions, widgets and framework library with session management support"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug doc hal libnotify python"

RDEPEND=">=dev-lang/perl-5.6
	dev-perl/URI
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce-mcs-plugins-${XFCE_MASTER_VERSION}
	libnotify? ( x11-libs/libnotify )
	hal? ( >=sys-apps/hal-0.5.7.1 )
	python? ( dev-python/pygtk )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	dev-util/pkgconfig
	dev-util/xfce4-dev-tools
	doc? ( dev-util/gtk-doc )
	dev-util/intltool"

XFCE_CONFIG="${XFCE_CONFIG}	$(use_enable python) \
	$(use_enable libnotify notifications) \
	$(use_enable hal) --enable-mcs-plugin"

DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"

# See bug 166568 for reference
src_unpack() {
	unpack ${A}
	sed -i -e 's:-Werror::g' "${S}"/configure
	epatch "${FILESDIR}"/${P}-remove-libmd5.patch
	AT_M4DIR=/usr/share/xfce4/dev-tools/m4macros eautoreconf
}

# See bug 164780 for reference
src_install() {
	xfce44_src_install
	rm -f "${D}"/usr/lib*/python*/site-packages/pyexo.py[co]
	rm -f "${D}"/usr/lib*/python*/site-packages/${PN}-0.3/${PN}/__init__.py[co]
}

pkg_postinst() {
	xfce44_pkg_postinst
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages
}

pkg_postrm() {
	xfce44_pkg_postrm
	python_mod_cleanup
}
