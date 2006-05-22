# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vorbis/gst-plugins-vorbis-0.10.4.ebuild,v 1.12 2006/05/22 00:03:33 tcort Exp $

inherit eutils gst-plugins-base

KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/libvorbis-1
	 >=media-libs/libogg-1
	 >=media-libs/gst-plugins-base-0.10.4"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
