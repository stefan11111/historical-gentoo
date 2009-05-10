# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/yaydl/yaydl-1.2.ebuild,v 1.1 2009/05/10 08:47:00 volkmar Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Yet Another Youtube DownLoader which is downloading more than youtube"
HOMEPAGE="http://pdes-net.org/x-haui/yaydl.html"
SRC_URI="http://pdes-net.org/x-haui/scripts/perl/yaydl_youtubedownloader/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="encode soundextract"

DEPEND=""
RDEPEND="dev-lang/perl
	dev-perl/LWP-UserAgent-Determined
	dev-perl/MP3-Info
	dev-perl/Term-ProgressBar
	dev-perl/URI
	encode? ( || ( media-video/ffmpeg[encode]
		media-video/mplayer[encode,mp3,xvid] ) )
	soundextract? ( || ( media-video/ffmpeg[encode,mp3] ) )"

S=${WORKDIR}/${PN}

# TODO:
# need from upstream to fix mencoder soundextract and choose a default encoder

src_prepare() {
	# let ffmpeg doing soundextract and remove mencoder soundextract
	# making ffmpeg first choice for encoding
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_install() {
	exeinto /usr/bin
	newexe ${PN}.pl ${PN} || die "newexe failed"
	dodoc changelog README || die "dodoc failed"
}

pkg_postinst() {
	elog "${PN} is supporting a lot of video websites."
	elog "Look at ${HOMEPAGE} for more information."
}
