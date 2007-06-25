# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gentoo-syntax/gentoo-syntax-1.6-r1.ebuild,v 1.1 2007/06/25 10:00:28 opfer Exp $

inherit elisp

DESCRIPTION="Emacs modes for editing ebuilds and other Gentoo specific files"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.el.bz2
	mirror://gentoo/${PN}-${PV}-ChangeLog.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

SIMPLE_ELISP=t
SITEFILE=51${PN}-gentoo.el

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	newdoc "${WORKDIR}/${PN}-${PV}-ChangeLog" ChangeLog

	# the following is for backwards compatibility
	dosym gentoo-syntax.el "${SITELISP}/${PN}/ebuild-mode.el"
	dosym gentoo-syntax.elc "${SITELISP}/${PN}/ebuild-mode.elc"
}
