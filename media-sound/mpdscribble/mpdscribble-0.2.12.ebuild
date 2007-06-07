# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpdscribble/mpdscribble-0.2.12.ebuild,v 1.5 2007/06/07 18:08:48 gustavoz Exp $

DESCRIPTION="An MPD client that submits information to audioscrobbler."
HOMEPAGE="http://www.frob.nl/scribble.html"
SRC_URI="http://www.frob.nl/projects/scribble/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc sparc ~x86"
IUSE=""
DEPEND=">=net-libs/libsoup-2.2"

src_install() {
	make DESTDIR=${D} install || die

	exeinto /usr/share/mpdscribble
	doexe setup.sh

	doman mpdscribble.1
	newinitd ${FILESDIR}/mpdscribble.rc mpdscribble

	dodoc AUTHORS ChangeLog NEWS README TODO

	dodir /var/cache/mpdscribble
}

pkg_postinst() {
	elog ""
	elog "Please run:"
	elog "  /usr/share/mpdscribble/setup.sh"
	elog "in order to configure mpdscribble. If you do this as root, a"
	elog "system-wide configuration will be created. Otherwise, a per-user"
	elog "configuration file will be created."
	elog ""
	elog "To start mpdscribble:"
	elog "  /etc/init.d/mpdscribble start"
	elog ""
}
