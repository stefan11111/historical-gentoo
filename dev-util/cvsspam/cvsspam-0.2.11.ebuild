# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsspam/cvsspam-0.2.11.ebuild,v 1.4 2005/05/12 17:47:28 nakano Exp $

DESCRIPTION="Utility to send colored HTML CVS-mails"
SRC_URI="http://www.badgers-in-foil.co.uk/projects/cvsspam/${P}.tar.gz"
HOMEPAGE="http://www.badgers-in-foil.co.uk/projects/cvsspam/"
LICENSE="GPL-2"
DEPEND="virtual/libc"
RDEPEND="dev-lang/ruby"
KEYWORDS="x86 ppc"
SLOT="0"
IUSE=""

src_install () {
	dobin collect_diffs.rb || die
	dobin cvsspam.rb || die
	dobin record_lastdir.rb || die
	insinto /etc/cvsspam || die
	doins cvsspam.conf || die

	dohtml cvsspam-doc.html
	dodoc COPYING CREDITS TODO cvsspam-doc.pdf
}
