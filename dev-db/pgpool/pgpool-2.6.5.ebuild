# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgpool/pgpool-2.6.5.ebuild,v 1.1 2005/11/12 15:05:07 nakano Exp $

DESCRIPTION="Connection pool server for PostgreSQL"
HOMEPAGE="http://pgpool.projects.postgresql.org/"
SRC_URI="http://pgfoundry.org/frs/download.php/499/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-db/libpq"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "/^logdir/s:/tmp:/var/run:g" pgpool.conf.sample || die
}

src_compile() {
	econf --with-pgsql=/usr/include/postgresql || die
	emake || die
}

src_install () {
	einstall || die
	mv ${D}/etc/pgpool.conf.sample ${D}/etc/pgpool.conf
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README* TODO
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}.init ${PN}
}
