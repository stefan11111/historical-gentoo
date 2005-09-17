# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hddtemp/hddtemp-0.3_beta13.ebuild,v 1.3 2005/09/17 21:31:17 hansmi Exp $

inherit eutils

MY_P=${P/_beta/-beta}

DESCRIPTION="A simple utility to read the temperature of SMART capable hard drives"
HOMEPAGE="http://www.guzu.net/linux/hddtemp.php"
SRC_URI="http://www.guzu.net/linux/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="nls"

DEPEND="virtual/libc
	net-misc/wget"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-setsid.patch

	ebegin "Trying to download the latest hddtemp.db file"
	wget -q --timeout=10 http://www.guzu.net/linux/hddtemp.db
	eend $?
}

src_compile() {
	local myconf

	myconf="--with-db-path=/usr/share/hddtemp/hddtemp.db"
	# disabling nls breaks compiling
	use nls || myconf="--disable-nls ${myconf}"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README TODO Changelog

	insinto /usr/share/hddtemp
	if [ -f hddtemp.db ]; then
		doins hddtemp.db
	else
		doins ${FILESDIR}/hddtemp.db
	fi

	insinto /etc/conf.d ; donewins ${FILESDIR}/hddtemp-conf.d hddtemp
	exeinto /etc/init.d ; newexe ${FILESDIR}/hddtemp-init hddtemp
}
