# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mutt/mutt-1.4-r3.ebuild,v 1.12 2003/02/27 22:37:05 agriffis Exp $

IUSE="ssl nls slang cjk mbox"

S=$WORKDIR/${P}
DESCRIPTION="a small but very powerful text-based mail client"
SRC_URI="ftp://ftp.mutt.org/mutt/mutt-${PV}i.tar.gz
	http://www.spinnaker.de/mutt/compressed/patch-${PV}.rr.compressed.1.gz
	cjk?( http://www.emaillab.org/mutt/1.4/mutt-${PV}i-ja.1.tar.gz )" 
HOMEPAGE="http://www.mutt.org"

DEPEND=">=sys-libs/ncurses-5.2
	ssl? ( >=dev-libs/openssl-0.9.6 )
	slang? ( >=sys-libs/slang-1.4.2 )"

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa"

pkg_setup() {

	if [ "`use cjk`" -a "${WANT_JA}" != "yes" ]
		then
			echo
			eerror "The cjk USE option is only available for japanese support"
			eerror "If you want japanese support in mutt, please do:"
			eerror
			eerror "  # WANT_JA=\"yes\" emerge mutt"
			eerror
			eerror "Otherwise, (such as Korean or Chinese)"
			eerror 
			eerror "  # USE=\"-cjk\" emerge mutt"
			die "Wont build cjk support without being forced"
		fi
}

src_unpack() { 
	unpack ${P}i.tar.gz 
	if [ "`use cjk`" ]; then
		unpack ${P}i-ja.1.tar.gz  
  		cd ${S} 
		patch -p1 < ../mutt-1.4i-ja.1/patch-1.4.tt.ja.1 || die 
	fi
		zcat ${DISTDIR}/patch-${PV}.rr.compressed.1.gz | patch -d ${S} -p1 ||
		die
}
      
src_compile() {
	local myconf
	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"

	# --without-slang doesn't work;
	# specify --with-curses if you don't want slang
	# (26 Sep 2001 agriffis)

	use slang \
		&& myconf="${myconf} --with-slang" \
		|| myconf="${myconf} --with-curses"

	use mbox \
		&& myconf="${myconf} --with-maildir=/var/spool/mail" \
		|| myconf="${myconf} --with-homespool=Maildir"

	use cjk && myconf="$myconf --enable-default-japanese"

	econf \
		--sysconfdir=/etc/mutt \
		--with-docdir=/usr/share/doc/mutt-$PVR \
		--with-regex --enable-pop --enable-imap --enable-nfs-fix \
		--disable-fcntl --enable-flock --enable-external-dotlock \
		--enable-compressed \
		${myconf} || die
	
	cp doc/Makefile doc/Makefile.orig
	sed 's/README.UPGRADE//' doc/Makefile.orig > doc/Makefile
	make || die "make failed (myconf=${myconf})"
}

src_install () {
	make DESTDIR=$D install || die
	find $D/usr/share/doc -type f |grep -v html | xargs gzip
	insinto /etc/mutt
	if [ "`use mbox`" ]; then
		echo "Not installing an /etc/Muttrc as mbox is default configuration"
		echo "with mutt"
	else
		doins $FILESDIR/Muttrc
	fi

	dodoc BEWARE COPYRIGHT ChangeLog NEWS OPS* PATCHES README* TODO VERSION
}
