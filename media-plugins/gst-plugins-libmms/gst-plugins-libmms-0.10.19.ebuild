# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-0.10.19.ebuild,v 1.5 2011/03/11 18:19:37 xarthisius Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.29
	>=media-libs/libmms-0.4"
DEPEND="${RDEPEND}"
