# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/taylor-uucp/taylor-uucp-1.07-r1.ebuild,v 1.4 2006/03/10 19:38:38 hansmi Exp $

inherit eutils flag-o-matic

DESCRIPTION="Taylor UUCP"
HOMEPAGE="http://www.airs.com/ian/uucp.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/uucp/uucp-${PV}.tar.gz"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ppc ~sparc x86"

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

S="${WORKDIR}/uucp-1.07"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gentoo.patch"
	#disable lazy bindings
	sed -i -e "s:^LDFLAGS *=.*\$:& ${LDFLAGS} $(bindnow-flags):" "${S}/Makefile.in"
}

src_compile() {
	econf --with-newconfigdir=/etc/uucp || die "configure failed"
	make || die "make failed"
}

src_install() {
	dodir /usr/share/man/man{1,8}
	dodir /usr/share/info
	dodir /etc/uucp
	dodir /usr/bin /usr/sbin
	diropts -o uucp -g uucp -m 0750
	keepdir /var/log/uucp /var/spool/uucp
	diropts -o uucp -g uucp -m 0775
	keepdir /var/spool/uucppublic

	make \
		"prefix=${D}/usr" \
		"sbindir=${D}/usr/sbin" \
		"bindir=${D}/usr/bin" \
		"man1dir=${D}/usr/share/man/man1" \
		"man8dir=${D}/usr/share/man/man8" \
		"newconfigdir=${D}/etc/uucp" \
		"infodir=${D}/usr/share/info" \
		install install-info || die "make install failed"
	sed -i -e 's:/usr/spool:/var/spool:g' sample/config
	cp sample/* "${D}/etc/uucp"
	dodoc ChangeLog NEWS README TODO
}

pkg_preinst() {
	usermod -s /bin/bash uucp
}
