# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/enscript/enscript-1.6.3-r1.ebuild,v 1.11 2003/03/01 04:16:57 vapier Exp $

DESCRIPTION="GNU's enscript is a powerful text-to-postsript converter"
SRC_URI="http://www.iki.fi/mtr/genscript/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/enscript/enscript.html"

KEYWORDS="x86 ~ppc sparc"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls"

DEPEND="sys-devel/flex
	sys-devel/bison
	nls? ( sys-devel/gettext )"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog FAQ.html NEWS README* THANKS TODO
}

pkg_postinst() {
	einfo "Now, customize /etc/enscript.cfg."
}
