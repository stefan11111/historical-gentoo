# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql/postgresql-7.2.3.ebuild,v 1.7 2003/03/05 20:20:50 sethbc Exp $

DESCRIPTION="sophisticated Object-Relational DBMS"
SRC_URI="ftp://ftp.easynet.be/postgresql/v${PV}/${P}.tar.gz"
HOMEPAGE="http://www.postgresql.org/"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE="ssl nls java python tcltk perl"

DEPEND="virtual/glibc
	sys-devel/autoconf
	app-admin/sudo
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	>=sys-libs/zlib-1.1.3
	tcltk? ( >=dev-lang/tcl-8 >=dev-lang/tk-8.3.3-r1 )
	perl? ( >=sys-devel/perl-5.6.1-r2 )
	python? ( >=dev-lang/python-2.2 )
	java? ( =virtual/jdk-1.3* >=dev-java/ant-1.3 ) 
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
	nls? ( sys-devel/gettext )"
# java dep workaround for portage bug
# x86? ( java? ( =virtual/jdk-1.3* >=dev-java/ant-1.3 ) )
RDEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.3
	tcltk? ( >=dev-lang/tcl-8 )
	perl? ( >=sys-devel/perl-5.6.1-r2 )
	python? ( >=dev-lang/python-2.2 )
	java? ( =virtual/jdk-1.3* )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )"

pkg_setup() {
	local foo
	if [ "`use java`" ] ; then
		foo=`java-config --java-version 2>&1 | grep "1.4.0"`
		if [ ! -z "$foo" ] ; then
			einfo "Cannot build with Sun JDK 1.4.0, use any of the 1.3.x JDKs instead."
			exit 1
		fi
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# we know that a shared libperl is present, the default perl
	# config is however set to the static libperl.a
	# just remove the check
	patch -p1 < ${FILESDIR}/${P}-dyn-libperl-gentoo.diff || die
	patch -p0 < ${FILESDIR}/${P}-perl-gentoo.diff || die

	# cp ${FILESDIR}/${P}-build.xml ${S}/src/interfaces/jdbc/build.xml
}

src_compile() {
	local myconf
	use tcltk && myconf="--with-tcl"
	use python && myconf="$myconf --with-python"
	use perl && myconf="$myconf --with-perl"
	use java && myconf="$myconf --with-java"
	use ssl && myconf="$myconf --with-openssl"
	use nls && myconf="$myconf --enable-locale --enable-nls --enable-multibyte"
	use libg++ && myconf="$myconf --with-CXX"

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		--docdir=/usr/share/doc/${P} \
		--libdir=/usr/lib \
		--enable-syslog \
		--enable-depend \
		--with-gnu-ld \
		--with-pam \
		--with-maxbackends=1024 \
		$myconf || die


	make || die
}

pkg_preinst() {
	if ! groupmod postgres ; then
		groupadd -g 70 postgres || die "problem adding group postgres"
	fi

	if ! id postgres; then
		useradd -g postgres -s /bin/bash -d /var/lib/postgresql -c "postgres" postgres
		assert "problem adding user postgres"
	fi
}

src_install() {
	if [ "`use perl`" ]
	then
		mv ${S}/src/pl/plperl/Makefile ${S}/src/pl/plperl/Makefile_orig
		sed -e "s:(INST_DYNAMIC) /usr/lib:(INST_DYNAMIC) ${D}/usr/lib:" \
			${S}/src/pl/plperl/Makefile_orig > ${S}/src/pl/plperl/Makefile
		mv ${S}/src/pl/plperl/GNUmakefile ${S}/src/pl/plperl/GNUmakefile_orig
		sed -e "s:\$(DESTDIR)\$(plperl_installdir):\$(plperl_installdir):" \
			${S}/src/pl/plperl/GNUmakefile_orig > ${S}/src/pl/plperl/GNUmakefile
	fi

	make DESTDIR=${D} LIBDIR=${D}/usr/lib install || die
	make DESTDIR=${D} install-all-headers || die
	dodoc COPYRIGHT HISTORY INSTALL README register.txt
	cd ${S}/doc
	dodoc FAQ* KNOWN_BUGS MISSING_FEATURES README*
	dodoc TODO internals.ps bug.template
	docinto sgml
	dodoc src/sgml/*.{sgml,dsl}
	docinto sgml/ref
	dodoc src/sgml/ref/*.sgml
	docinto sgml/graphics
	dodoc src/graphics/*
	rm -rf ${D}/usr/doc ${D}/mnt
	exeinto /usr/bin
	
	if [ `use java` ]; then
		dojar ${D}/usr/share/postgresql/java/postgresql.jar
		rm ${D}/usr/share/postgresql/java/postgresql.jar
	fi

	dodir /usr/include/postgresql/pgsql
	cp ${D}/usr/include/*.h ${D}/usr/include/postgresql/pgsql

	exeinto /etc/init.d/
	doexe ${FILESDIR}/${PV}/${PN}

	exeinto /etc/conf.d/
	doexe ${FILESDIR}/postgresql
}

pkg_postinst() {
	einfo ">>> Execute the following command"
	einfo ">>> ebuild  /var/db/pkg/dev-db/${P}/${P}.ebuild config"
	einfo ">>> to setup the initial database environment."
}

pkg_config() {
	einfo ">>> Creating data directory ..."
	mkdir -p /var/lib/postgresql/data
	chown -Rf postgres.postgres /var/lib/postgresql
	chmod 700 /var/lib/postgresql/data

	einfo ">>> Initializing the database ..."
	if [ -f /var/lib/postgresql/data/PG_VERSION ] ; then
		echo -n "A postgres data directory already exists from version "; cat /var/lib/postgresql/data/PG_VERSION
		echo "Read the documentation to check how to upgrade to version ${PV}."
	else
		sudo -u postgres /usr/bin/initdb --pgdata /var/lib/postgresql/data
	fi
}
