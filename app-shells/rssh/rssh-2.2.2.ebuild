# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/rssh/rssh-2.2.2.ebuild,v 1.2 2005/01/01 15:59:31 eradicator Exp $

DESCRIPTION="Restricted shell for SSHd"
HOMEPAGE="http://rssh.sourceforge.net/"
SRC_URI="mirror://sourceforge/rssh/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="sparc ppc x86"
IUSE="static"

RDEPEND="virtual/ssh"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:chmod u+s $(:chmod u+s $(DESTDIR)$(:' Makefile.in
}

src_compile() {
	econf \
		--libexecdir=/usr/lib/misc \
		--with-scp=/usr/bin/scp \
		--with-sftp-server=/usr/lib/misc/sftp-server \
		$(use_enable static) \
		 || die "econf failed"
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog CHROOT INSTALL README TODO
}
