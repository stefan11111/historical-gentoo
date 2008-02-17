# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gdesklets-core/gdesklets-core-0.36_beta.ebuild,v 1.1 2008/02/17 22:12:16 nixphoeni Exp $

# We want the latest autoconf and automake (the default)
inherit gnome2 eutils autotools multilib

MY_PN="gDesklets"
MY_P="${MY_PN}-${PV/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="GNOME Desktop Applets: Core library for desktop applets"
SRC_URI="http://students.fim.uni-passau.de/~meyerc/gDesklets/${MY_P}.tar.bz2"
HOMEPAGE="http://www.gdesklets.de"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

# is libgsf needed for runtime or just compiling?
RDEPEND=">=dev-lang/python-2.3
	>=dev-libs/glib-2.4
	gnome-extra/libgsf
	>=gnome-base/librsvg-2.8
	>=gnome-base/libgtop-2.8.2
	>=dev-python/pygtk-2.10
	>=dev-python/gnome-python-2.6
	>=dev-libs/expat-1.95.8
	>=dev-python/pyxml-0.8.3-r1"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {

	gnome2_src_unpack

	cd "${S}"
	# Use po/LINGUAS - see gnome bug #506828
	epatch "${FILESDIR}/${P}-linguas.patch"
	# Fix the creation of the /usr/bin/gdesklets link to respect libdir
	epatch "${FILESDIR}/${P}-binary_link_fix.patch"

}

src_install() {

	gnome2_src_install

	# Install the gdesklets-control-getid script
	insinto /usr/$(get_libdir)/gdesklets
	insopts -m0555
	doins "${FILESDIR}/gdesklets-control-getid"

	# Create a global directory for Displays
	dodir /usr/$(get_libdir)/gdesklets/Displays

}

pkg_postinst() {

	# Remove conflicts with x11-misc/shared-mime-info and auto-generated
	# MIME info
	rm -rf 	"${D}/usr/share/mime/"

	gnome2_pkg_postinst

	echo
	elog "gDesklets Displays are required before the library"
	elog "will be usable. The displays are found in -"
	elog "           x11-plugins/desklet-* ,"
	elog "at http://www.gdesklets.de, or at http://gdesklets.zencomputer.ca"
	elog
	elog "Next you'll need to start gdesklets using"
	elog "           ${ROOT}usr/bin/gdesklets start"
	elog "If you're using GNOME this can be done conveniently"
	elog "through Applications->Accessories->gDesklets"
	elog
	elog "If you're updating from a version less than 0.35_rc1,"
	elog "you can migrate your desklet configurations by"
	elog "running"
	elog "           ${ROOT}usr/$(get_libdir)/gdesklets/gdesklets-migration-tool"
	elog "after the first time you run gdesklets"
	echo

	# This stuff is important, especially the migration-tool
	# information which flies by on an update.
	epause 9

}
