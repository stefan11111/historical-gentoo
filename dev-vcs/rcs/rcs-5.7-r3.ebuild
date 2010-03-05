# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/rcs/rcs-5.7-r3.ebuild,v 1.1 2010/03/05 07:10:36 ulm Exp $

inherit eutils

DESCRIPTION="Revision Control System"
HOMEPAGE="http://www.gnu.org/software/rcs/"
SRC_URI="mirror://gnu/rcs/${P}.tar.gz
	mirror://gentoo/${P}-debian.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="sys-apps/diffutils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${P}-debian.diff
}

src_compile() {
	# econf BREAKS this!
	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		--with-diffutils || die

	emake || die
}

src_install() {
	make \
		prefix="${D}"/usr \
		man1dir="${D}"/usr/share/man/man1 \
		man3dir="${D}"/usr/share/man/man3 \
		man5dir="${D}"/usr/share/man/man5 \
		install || die

	dodoc ChangeLog CREDITS NEWS README REFS
}
