# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/mousepad/mousepad-0.2.12.ebuild,v 1.13 2007/05/27 06:45:47 kumba Exp $

inherit xfce44

xfce44

DESCRIPTION="Text editor"
HOMEPAGE="http://www.xfce.org/projects/mousepad/"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_core_package
