# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-2.2.ebuild,v 1.3 2003/02/13 07:07:30 vapier Exp $

inherit elisp

IUSE=""

DESCRIPTION="Mew is a great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="ftp://ftp.mew.org/pub/Mew/release/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

SITEFILE=50mew-gentoo.el

src_compile() {
	make || die
}

src_install() {
	make prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN}  install || die

 	elisp-install ${PN} *.el *.elc || die
 	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	dodoc 00*
	einfo "Refer to the Info documentation on Mew for how to get started."
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
