# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akode/akode-3.4.0_rc1.ebuild,v 1.1 2005/02/27 20:21:29 danarmak Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="aRts plugins for various formats"
KEYWORDS="~x86"
IUSE="flac oggvorbis speex mad arts alsa libsamplerate jack"
DEPEND="arts? ( $(deprange $PV $MAXKDEVER kde-base/arts) )
	flac? ( media-libs/flac )
	oggvorbis? ( media-sound/vorbis-tools )
	speex? ( media-libs/speex )
	!=media-libs/speex-1.1.4
	media-libs/libsamplerate
	mad? ( media-libs/libmad )
	libsamplerate? ( media-libs/libsamplerate )
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"

# MISSING: polypaudio - no gentoo ebuild as yet
# TODO: configure needs a pkg-config file for media-sound/jack to detect it

src_compile() {
	use speex && myconf="$myconf --with-extra-includes=/usr/include/speex"
	myconf="$myconf $(use_with mad libmad) $(use_with flac) $(use_with libsamplerate)
			$(use_with alsa) $(use_with jack) $(use_with oggvorbis vorbis)"

	kde-meta_src_compile
}
