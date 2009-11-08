# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/vanessa-adt/vanessa-adt-0.0.8.ebuild,v 1.1 2009/11/08 13:52:32 patrick Exp $

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Provides Abstract Data Types (ADTs) Includes queue, dynamic array, hash and key value ADT."
HOMEPAGE="http://www.vergenet.net/linux/vanessa/"
SRC_URI="http://www.vergenet.net/linux/vanessa/download/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/vanessa-logger-0.0.7"
S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die "error configure"
	emake || die "error compiling"
}

src_install() {
	make DESTDIR="${D}" install || die "error installing"
	dodoc AUTHORS NEWS README TODO
}
