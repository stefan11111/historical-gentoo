# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gini/gini-0.5.1.ebuild,v 1.6 2004/07/13 05:00:56 eradicator Exp $

IUSE=""

DESCRIPTION="gini is a free streaming media server for unix-like operating systems"
HOMEPAGE="http://gini.sf.net"
SRC_URI="mirror://sourceforge/gini/${P}.tar.bz2"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ~sparc ~amd64"

DEPEND="dev-libs/glib"

src_install() {
	einstall || die

	dodoc AUTHORS BUGS README TODO COPYING ChangeLog INSTALL NEWS
}
