# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-dv/gst-plugins-dv-0.10.30.ebuild,v 1.1 2011/07/31 03:19:40 leio Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin to demux and decode DV"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libdv-0.100
	>=media-libs/gst-plugins-base-0.10.33"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="libdv"
