# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/semantic/semantic-1.4.ebuild,v 1.4 2003/10/25 21:57:15 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="The Semantic Bovinator is a lexer, parser-generator, and parser written in Emacs Lisp"
HOMEPAGE="http://cedet.sourceforge.net/semantic.shtml"
SRC_URI="mirror://sourceforge/cedet/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs
	app-emacs/speedbar
	app-emacs/eieio"

S="${WORKDIR}/${P}"

src_compile() {
	make LOADPATH="${SITELISP}/speedbar ${SITELISP}/eieio" || die
}

src_install() {
	elisp-install ${PN} *.el *.elc *.bnf
	elisp-site-file-install ${FILESDIR}/60semantic-gentoo.el

	dodoc ChangeLog NEWS INSTALL
	doinfo semantic.info*
}

pkg_postinst() {
	elisp-site-regen
	einfo "See the /usr/share/doc/${P}/INSTALL.gz for tips on how to customize this package"
}

pkg_postrm() {
	elisp-site-regen
}
