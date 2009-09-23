# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/x264-encoder/x264-encoder-0.0.20090923.ebuild,v 1.1 2009/09/23 21:32:32 aballier Exp $

EAPI=2
inherit eutils multilib toolchain-funcs versionator

MY_P=x264-snapshot-$(get_version_component_range 3)-2245

DESCRIPTION="A free commandline encoder for X264/AVC streams"
HOMEPAGE="http://www.videolan.org/developers/x264.html"
SRC_URI="ftp://ftp.videolan.org/pub/videolan/x264/snapshots/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug +mp4 +threads"

RDEPEND="mp4? ( >=media-video/gpac-0.4.1_pre20060122 )
	~media-libs/x264-${PV}"
DEPEND="${RDEPEND}
	amd64? ( >=dev-lang/yasm-0.6.2 )
	x86? ( || ( >=dev-lang/yasm-0.6.2 dev-lang/nasm )
		!<dev-lang/yasm-0.6.2 )
	x86-fbsd? ( >=dev-lang/yasm-0.6.2 )
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-nostrip.patch \
		"${FILESDIR}"/${PN}-nolib-20090408.patch
}

src_configure() {
	tc-export CC

	local myconf=""
	use debug && myconf="${myconf} --enable-debug"

	./configure \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--disable-avis-input \
		$(use_enable mp4 mp4-output) \
		$(use_enable threads pthread) \
		--enable-pic \
		--enable-shared \
		--extra-asflags="${ASFLAGS}" \
		--extra-cflags="${CFLAGS}" \
		--extra-ldflags="${LDFLAGS}" \
		--host="${CHOST}" \
		${myconf} \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
