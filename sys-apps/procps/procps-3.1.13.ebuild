# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-3.1.13.ebuild,v 1.2 2003/10/08 03:34:01 drobbins Exp $

IUSE="selinux"

S=${WORKDIR}/${P}
DESCRIPTION="Standard informational utilities and process-handling tools -ps top tload snice vmstat free w watch uptime pmap skill pkill kill pgrep sysctl"
SRC_URI="http://${PN}.sf.net/${P}.tar.gz
	selinux? mirror://gentoo/${PN}-3.1.8-selinux.patch.bz2"
HOMEPAGE="http://procps.sourceforge.net/"

inherit flag-o-matic

replace-flags "-O3" "-O2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~arm ~mips ia64"

RDEPEND=">=sys-libs/ncurses-5.2-r2"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.10.35
	selinux? ( >=sys-apps/selinux-small-2003011510-r2 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	use selinux && epatch ${DISTDIR}/${PN}-3.1.8-selinux.patch.bz2

	# Use the CFLAGS from /etc/make.conf.
	for file in `find . -iname "Makefile"`;do
		sed -i "s:-O2:${CFLAGS}:" ${file}
	done
}

src_compile() {
	emake || die
}

src_install() {
	einstall DESTDIR="${D}"|| die

	dodoc BUGS COPYING COPYING.LIB NEWS TODO
	docinto proc
	dodoc proc/COPYING
	docinto ps
	dodoc ps/COPYING ps/HACKING
}

pkg_postinst() {
	einfo "NOTE: By default \"ps\" and \"top\" no longer"
	einfo "show threads. You can use the '-m' flag"
	einfo "in ps or the 'H' key in top to show them"
}
