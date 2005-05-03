# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/qwerty/qwerty-1.1.ebuild,v 1.9 2005/05/03 09:03:18 usata Exp $

inherit elisp

IUSE=""
DESCRIPTION="Switch between QWERTY and DVORAK without changing the console keymap."
# gnu.emacs.sources Message-ID: <NJ104.93Mar1125218@bootes.cus.cam.ac.uk>"
HOMEPAGE="http://groups-beta.google.com/group/gnu.emacs.sources/msg/eab31c752dfdd3a5"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
DEPEND="virtual/emacs"

SITEFILE=50qwerty-gentoo.el
