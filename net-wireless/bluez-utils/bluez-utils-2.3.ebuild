# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-utils/bluez-utils-2.3.ebuild,v 1.2 2003/05/09 16:16:54 latexer Exp $

DESCRIPTION="bluetooth utilities"
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="sys-devel/bison
		sys-devel/flex
		>=net-wireless/bluez-libs-2.4"
RDEPEND=">=net-wireless/bluez-libs-2.4"
src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix some installation locations

	for dir in rfcomm tools; do
		mv $dir/Makefile.in ${T}/Makefile.in
		sed -e "s:\$(prefix)/usr/share/man:\@mandir\@:" \
			${T}/Makefile.in > $dir/Makefile.in;
	done

	mv hcid/Makefile.in ${T}/Makefile.in
	sed -e "s:\$(prefix)/etc/bluetooth:/etc/bluetooth:" \
		${T}/Makefile.in > hcid/Makefile.in
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	# rfcomm needs some devices created to function properly
	C=0
	while [ $C -lt 16 ]; do
		if [ ! -c /dev/rfcomm$C ]; then
			mknod -m 666 /dev/rfcomm$C c 216 $C
		fi
		C=`expr $C + 1`
	done
}
