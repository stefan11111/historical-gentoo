# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-4.0.14-r2.ebuild,v 1.13 2003/10/02 01:56:30 agriffis Exp $

IUSE="tcltk java doc"

inherit eutils gnuconfig db

S="${WORKDIR}/${P}/build_unix"
DESCRIPTION="Berkeley DB"
SRC_URI="http://www.sleepycat.com/update/snapshot/${P}.tar.gz"
HOMEPAGE="http://www.sleepycat.com"
SLOT="4"
LICENSE="DB"
KEYWORDS="x86  ~ppc ~sparc alpha ~mips ~hppa ~arm ~amd64 ia64"

DEPEND="tcltk? ( dev-lang/tcl )
	java? ( virtual/jdk )"

src_unpack() {
	unpack ${A}

	# Get db to link libdb* to correct dependencies ... for example if we use
	# NPTL or NGPT, db detects usable mutexes, and should link against
	# libpthread, but does not do so ...
	# <azarah@gentoo.org> (23 Feb 2003)
	cd ${WORKDIR}/${P}; epatch ${FILESDIR}/${P}-fix-dep-link.patch
}

src_compile() {

	# gnuconfig doesn't work if ${S} points to build_unix, so we
	# change it temporarily
	if use mips; then
		einfo "Updating config.{guess,sub} for mips"
		local OLDS="${S}"
		S="${WORKDIR}/${P}/dist"
		gnuconfig_update
		S="${OLDS}"
	fi

	local myconf=

	use java \
		&& myconf="${myconf} --enable-java" \
		|| myconf="${myconf} --disable-java"

	use tcltk \
		&& myconf="${myconf} --enable-tcl --with-tcl=/usr/lib" \
		|| myconf="${myconf} --disable-tcl"

	if use java && [ -n "${JAVAC}" ]; then
		export PATH=`dirname ${JAVAC}`:${PATH}
		export JAVAC=`basename ${JAVAC}`
	fi

	# http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml
	has_version 'sys-devel/hardened-gcc' && \
		einfo "hardened-gcc: activating ${CC} -yet_exec for configuring"

	has_version 'sys-devel/hardened-gcc' && CC="${CC} -yet_exec"

	../dist/configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--datadir=/usr/share \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--enable-compat185 \
		--enable-cxx \
		--with-uniquename \
		${myconf} || die

	has_version 'sys-devel/hardened-gcc' && find ${W} -name "Makefile" -type f -exec \
		sed -i "s:-yet_exec::g" {} \;

#	disable posix mutexes as they are not available in linuxthreads from
#	the standard profile and they should be autodetected if available
#
#		--enable-posixmutexes \

	emake || make || die
}

src_install () {

	einstall || die

	db_src_install_usrbinslot

	db_src_install_headerslot

	db_src_install_doc

	db_src_install_usrlibcleanup
}

pkg_postinst () {
	db_fix_so
}

pkg_postrm () {
	db_fix_so
}
