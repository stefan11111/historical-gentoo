# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.25.ebuild,v 1.4 2010/04/05 18:26:30 armin76 Exp $

inherit gst-plugins-base

KEYWORDS="alpha amd64 arm ~hppa ia64 ~ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libogg-1.0"
DEPEND="${RDEPEND}"
