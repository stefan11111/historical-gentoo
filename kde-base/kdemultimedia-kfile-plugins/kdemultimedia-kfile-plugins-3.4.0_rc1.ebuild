# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-kfile-plugins/kdemultimedia-kfile-plugins-3.4.0_rc1.ebuild,v 1.2 2005/02/28 14:39:21 greg_g Exp $

KMNAME=kdemultimedia
KMMODULE=kfile-plugins
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="kfile plugins from kdemultimedia package"
KEYWORDS="~x86"
IUSE="oggvorbis theora"
DEPEND="media-libs/taglib
	oggvorbis? ( media-libs/libvorbis )
	theora? ( media-libs/libtheora )"

src_compile() {
	myconf="$myconf $(use_with oggvorbis vorbis)"
	kde-meta_src_compile
}
