# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/bitlbee/bitlbee-0.81a.ebuild,v 1.2 2003/11/19 19:37:52 weeve Exp $

inherit eutils

DESCRIPTION="Bitlbee is an irc to IM gateway that support multiple IM protocols"
HOMEPAGE="http://www.bitlbee.org"
SRC_URI="http://get.bitlbee.org/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~alpha"
IUSE="tcpd"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${P}.tar.gz

	# Patch the default xinetd file to add/adjust values to Gentoo defaults
	cd ${S}/doc
	epatch ${FILESDIR}/${PN}-0.80-xinetd.patch
}

src_compile() {
	local myconf
	use tcpd && myconf="${myconf} --tcpd=1"
	econf --datadir=/usr/share/bitlbee --etcdir=/etc/bitlbee ${myconf}
	emake || die "make failed"

	# make bitlbeed forking server
	cd utils
	[ -n "${CC}" ] \
		&& ${CC} ${CFLAGS} bitlbeed.c -o bitlbeed \
		|| gcc ${CFLAGS} bitlbeed.c -o bitlbeed

}

src_install() {
	mkdir -p ${D}/var/lib/bitlbee
	make install DESTDIR=${D} || die "install failed"
	make install-etc DESTDIR=${D} || die "install failed"
	keepdir /var/lib/bitlbee

	dodoc COPYING
	dodoc doc/{AUTHORS,CHANGES,CREDITS,FAQ,README,TODO}
	dohtml -A sgml doc/*.sgml
	doman doc/bitlbee.8

	dobin utils/bitlbeed

	insinto /etc/xinetd.d
	newins doc/bitlbee.xinetd bitlbee

	exeinto /etc/init.d
	newexe ${FILESDIR}/bitlbeed.init bitlbeed || die

	insinto /etc/conf.d
	newins ${FILESDIR}/bitlbeed.confd bitlbeed || die

	dodir /var/run/bitlbeed
	keepdir /var/run/bitlbeed

}

pkg_postinst() {
	chown nobody:nobody /var/lib/bitlbee
	chmod 700 /var/lib/bitlbee
}
