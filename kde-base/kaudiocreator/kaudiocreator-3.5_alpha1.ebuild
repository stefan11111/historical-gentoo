# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaudiocreator/kaudiocreator-3.5_alpha1.ebuild,v 1.1 2005/09/07 10:53:52 flameeyes Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE CD ripper and audio encoder frontend"
KEYWORDS="~amd64"
IUSE="encode flac mp3 vorbis"
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcddb)
	media-sound/cdparanoia"

# External encoders used - no optional compile-time support
RDEPEND="$DEPEND
	$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-kioslaves)
	encode? ( vorbis? ( media-sound/vorbis-tools )
	          flac? ( media-libs/flac )
	          mp3? ( media-sound/lame ) )"

KMCOPYLIB="libkcddb libkcddb"
KMEXTRACTONLY="libkcddb"
KMCOMPILEONLY="kscd
	libkcddb/"

src_compile () {
	DO_NOT_COMPILE=libkcddb kde-meta_src_compile myconf configure
	cd $S/libkcddb && make configbase.h cdinfodialogbase.h

	# Library deps seems not to be built as they should :/
	cd $S/kscd/libwm/audio && make libworkmanaudio.la && \
	cd $S/kscd/libwm && make libworkman.la && \
	cd $S/kscd && make libkcompactdisc.la || \
		die "failed to make prerequisite libraries."

	DO_NOT_COMPILE=libkcddb kde-meta_src_compile make
}
