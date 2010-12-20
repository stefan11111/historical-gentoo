# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-flac/gst-plugins-flac-0.10.23.ebuild,v 1.3 2010/12/20 17:24:26 hwoarang Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer encoder/decoder/tagger for FLAC"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/flac-1.1.4
	>=media-libs/gst-plugins-base-0.10.29"
DEPEND="${RDEPEND}"
