# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/run-mailcap/run-mailcap-3.23_p1-r1.ebuild,v 1.5 2004/02/22 19:40:50 agriffis Exp $

MY_PV="${PV/_p/-}"
DESCRIPTION="Execute programs via entries in the mailcap file"
HOMEPAGE="http://packages.debian.org/unstable/net/mime-support.html"
SRC_URI="mirror://debian/pool/main/m/mime-support/mime-support_${MY_PV}.tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~hppa amd64"
IUSE=""
DEPEND=""
RDEPEND=">=dev-lang/perl-5.6*"

S=${WORKDIR}/mime-support

src_compile() {
	sed -i run-mailcap -e 's:^\(\$xtermprgrm=\)"/usr/bin/x-terminal-emulator":\1$ENV{XTERMCMD} || "xterm":'
	cp run-mailcap.man run-mailcap.1
	cp mailcap.man mailcap.5
}

src_install() {
	dobin run-mailcap
	doman run-mailcap.1 mailcap.5
	insinto /etc
	doins mime.types
	for i in compose edit see print; do
		( cd ${D}/usr/bin && ln -s run-mailcap $i )
		( cd ${D}/usr/share/man/man1 && ln -s run-mailcap.1 $i.1 )
	done
}
