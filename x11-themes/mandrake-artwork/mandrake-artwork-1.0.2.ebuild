# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mandrake-artwork/mandrake-artwork-1.0.2.ebuild,v 1.7 2005/01/27 20:56:55 greg_g Exp $

inherit eutils kde-functions

MDK_EXTRAVERSION="1mdk"

DESCRIPTION="Mandrake's Galaxy theme for GTK1, GTK2, Metacity and KDE"
HOMEPAGE="http://www.mandrakelinux.com"
SRC_URI="mirror://gentoo/galaxy-${PV}-${MDK_EXTRAVERSION}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~alpha ~sparc"
IUSE="kde"

RDEPEND=">=x11-libs/gtk+-2.0
	 >=media-libs/gdk-pixbuf-0.2.5
	 =x11-libs/gtk+-1.2*
	 kde? ( >=kde-base/kdebase-3.1 )"
DEPEND="${RDEPEND}
	app-arch/rpm2targz"

src_unpack() {
	rpm2targz ${DISTDIR}/${A}
	tar xz --no-same-owner -f galaxy-${PV}-${MDK_EXTRAVERSION}.src.tar.gz
	tar xj --no-same-owner -f galaxy-${PV}.tar.bz2
}

src_compile() {
	cd ${WORKDIR}/galaxy-${PV}
	#make distclean

	#epatch ${FILESDIR}/galaxy-gtk24.patch

	if use kde; then
		set-qtdir 3
		set-kdedir 3
		mv thememdk/mandrake_client/Makefile.in thememdk/mandrake_client/Makefile.in.orig
		cat thememdk/mandrake_client/Makefile.in.orig | sed s:\$\{libdir\}\/kwin.la:${KDEDIR}/lib/kwin.la:g > thememdk/mandrake_client/Makefile.in
		rm thememdk/mandrake_client/Makefile.in.orig
		econf --with-qt-dir=${QTDIR} || die "econf failed"
	else
		sed -si s/KDE_CHECK_FINAL// configure.in
		sed -si s/AC_PATH_KDE// configure.in
		autoconf
		sed -si s/thememdk// Makefile.am
		sed -si s/thememdk// Makefile.in
		automake
		sed -si s/thememdk// Makefile.am
		sed -si s/thememdk// Makefile.in
		automake
	fi
	econf || die
	emake || die
}

src_install () {
	cd ${WORKDIR}/galaxy-${PV}
	einstall || die
	dodoc AUTHORS COPYING README ChangeLog
}
