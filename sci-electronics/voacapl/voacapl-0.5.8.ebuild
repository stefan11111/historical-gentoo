# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/voacapl/voacapl-0.5.8.ebuild,v 1.2 2012/03/11 15:40:27 ago Exp $

EAPI="2"

DESCRIPTION="HF propagation prediction tool"
HOMEPAGE="http://www.qsl.net/hz1jw/voacapl/index.html"
SRC_URI="http://www.qsl.net/hz1jw/${PN}/downloads/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" docdir=/usr/share/doc/${PF} install \
		|| die "make install failed"
}
