# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgda/libgda-0.2.93.ebuild,v 1.1 2001/11/04 11:03:30 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gda lib"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-db/${P}.tar.gz
	 ftp://ftp.gnome-db.org/pub/gnome-db/sources/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/gnome-db"

RDEPEND="virtual/glibc
	 >=gnome-base/gconf-1.0.4-r2
	 >=gnome-base/oaf-0.6.6-r1
	 >=gnome-base/bonobo-1.0.9-r1
	 >=sys-libs/gdbm-1.8.0
	 >=sys-libs/readline-4.1
	 >=dev-perl/CORBA-ORBit-0.4.3
	 >=dev-db/sqlite-2.0.8
	 mysql? ( >=dev-db/mysql-3.23.26 )
	 postgres? ( >=dev-db/postgresql-7.1 )
	 odbc? ( >=dev-db/unixODBC-1.8.13 )
	 ldap? ( >=net-nds/openldap-1.2.11 )"

DEPEND="${RDEPEND}
	sys-apps/which"


src_compile() {

	local myconf 

	if [ "`use mysql`" ]
	then
		myconf="--with-mysql=/usr"
	fi

  	if [ "`use ldap`" ]
	then
    		myconf="$myconf --with-ldap=/usr"
  	fi

  	if [ "`use odbc`" ]
	then
    		myconf="$myconf --with-odbc"
  	fi

  	if [ "`use postgres`" ]
	then
    		myconf="$myconf --with-postgres=/usr"
  	fi
  
  	# Wierd one, it dont detect bonobo. If someone could have a look
	# and fix if i havent gotten to it yet.
	myconf="$myconf --disable-bonobotest"

	# Do not compile buildin sqlite
	cp configure configure.orig
	grep -v sqlite configure.orig >configure
	chmod +x configure

	./configure --host=${CHOST} 					\
		    --prefix=/usr	 				\
		    --sysconfdir=/etc		 			\
		    --localstatedir=/var/lib				\
		    $myconf || die

	# Build and use an external version of sqlite since some versions
	# of libgda have a bug where the buildin do not compile.
	# Also cant hurt to use the latest version of sqlite :)
	mv ${S}/providers/gda-default-server/gda-default.h 		\
		${S}/gda-default.h.orig
	sed -e 's/\"build_sqlite\/sqlite\.h\"/<sqlite.h>/'		\
		${S}/gda-default.h.orig >				\
		${S}/providers/gda-default-server/gda-default.h || die
	ln -s /usr/lib/libsqlite.a					\
		${S}/providers/gda-default-server/sqlite/libsqlite.a
	mv providers/gda-default-server/Makefile			\
		providers/gda-default-server/Makefile.orig
	grep -v '= sqlite' providers/gda-default-server/Makefile.orig >	\
		providers/gda-default-server/Makefile

	# Doesn't work with -j 4 (hallski)
	make LDFLAGS="-lncurses" LIBREADLINE="-lreadline -lncurses" || die
}

src_install() {

	make  prefix=${D}/usr						\
	      sysconfdir=${D}/etc					\
	      localstatedir=${D}/var/lib				\
	      INSTALLMAN3DIR=${D}/usr/share/man/man3 			\
	      GDA_oafinfodir=${D}/usr/share/oaf				\
	      install || die

	into /usr

	# Not needed as we build sqlite seperately
#	dobin providers/gda-default-server/build_sqlite/{lemon,sqlite}

	dodoc AUTHORS COPYING.* ChangeLog NEWS README
}
