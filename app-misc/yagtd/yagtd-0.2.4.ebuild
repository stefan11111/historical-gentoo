# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/yagtd/yagtd-0.2.4.ebuild,v 1.1 2009/03/02 14:00:37 bangert Exp $

inherit distutils

DESCRIPTION="CLI todo list manager based on the 'Getting Things Done' philosophy."
HOMEPAGE="https://gna.org/projects/yagtd/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	distutils_src_install
	dosym /usr/bin/yagtd.py /usr/bin/yagtd
}
