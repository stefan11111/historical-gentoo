# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libotf/libotf-0.9.4.ebuild,v 1.4 2008/06/15 06:34:03 zmedico Exp $

DESCRIPTION="Library for handling OpenType fonts (OTF)"
HOMEPAGE="http://www.m17n.org/libotf/"
SRC_URI="http://www.m17n.org/libotf/${P}.tar.gz"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="x86 ppc alpha amd64 ppc64 sparc hppa"
IUSE="X"
RDEPEND="x11-libs/libXaw
	x11-libs/libICE
	>=media-libs/freetype-2.1"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use X || sed -i -e '/^bin_PROGRAMS/s/otfview//' example/Makefile.in || die
}

src_install() {

	emake DESTDIR="${D}" install || die

	dodoc AUTHORS INSTALL NEWS README ChangeLog
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-0.9.3"
	previous_less_than_0_9_3=$?
}

pkg_postinst() {
	if [[ $previous_less_than_0_9_3 = 0 ]] ; then

	ewarn
	ewarn "Shared library extension has been changed. You may need to recompile"
	ewarn "everything depending on this library (in short, please remerge m17n-lib"
	ewarn " if you are upgrading)."
	ewarn

	fi
}
