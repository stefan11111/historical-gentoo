# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-0.90-r1.ebuild,v 1.2 2004/03/08 21:18:33 genone Exp $

inherit eutils

DESCRIPTION="a RAD tool for BASIC"
HOMEPAGE="http://gambas.sourceforge.net"
SRC_URI="http://gambas.sourceforge.net/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="postgres mysql sdl doc curl debug"
DEPEND=">=sys-devel/automake-1.7.5
	>=x11-base/xfree-4.3.0
	>=x11-libs/qt-3.2
	>=kde-base/kdelibs-3.2
	sdl? ( media-libs/libsdl )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	curl? ( net-ftp/curl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:-Os::' configure
	# replace braindead Makefile
	rm Makefile*
	cp "${FILESDIR}/Makefile.am-${PV}" ./Makefile.am
	automake
	# patches against hardcoded paths
	epatch ${FILESDIR}/non-symlink-${PV}.patch
	epatch ${FILESDIR}/info-location-${PV}.patch
}

src_compile() {
	local myconf

	myconf="${myconf} --enable-kde --enable-qt"
	myconf="${myconf} `use_enable mysql`"
	myconf="${myconf} `use_enable postgres`"
	myconf="${myconf} `use_enable sdl`"
	myconf="${myconf} `use_enable curl`"

	if use debug; then
		myconf="${myconf} --disable-optimization --enable-debug"
	else
		myconf="${myconf} --enable-optimization --disable-debug"
	fi

	econf ${myconf} || die

	emake || die
}

src_install() {
	export PATH="${D}/usr/bin:${PATH}"
	einstall || die

	dodoc README INSTALL NEWS AUTHORS ChangeLog COPYING TODO

	# only install the API docs and examples with USE=doc
	if use doc; then
		mv ${D}/usr/share/help ${D}/usr/share/doc/${PF}/html
		mv ${D}/usr/share/examples ${D}/usr/share/doc/${PF}/examples
		einfo "Compiling examples ..."
		cd ${D}/usr/share/doc/${PF}/examples
		for p in *; do
			cd $p
			gbc -ag
			gba
			cd ..
		done
	fi
	rm -rf ${D}/usr/share/help ${D}/usr/share/examples
}
