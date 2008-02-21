# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-speex/gst-plugins-speex-0.10.7.ebuild,v 1.1 2008/02/21 15:41:16 zaheerm Exp $

inherit gst-plugins-good

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="GStreamer plugin to allow encoding and decoding of speex"

IUSE=""
RDEPEND=">=media-libs/speex-1.1.6
	>=media-libs/gstreamer-0.10.17
	>=media-libs/gst-plugins-base-0.10.17"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
