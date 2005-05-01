# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/libgtk-java/libgtk-java-2.4.9.ebuild,v 1.1 2005/05/01 16:20:48 karltk Exp $

#
# WARNING: Because java-gnome is a set of bindings to native GNOME libraries, 
# it has, like any GNOME project, a massive autoconf setup, and unlike many 
# other java libraries, it has its own [necessary] `make install` step.
# As a result, this ebuild is VERY sensitive to the internal layout of the
# upstream project. Because these issues are currently evolving upstream,
# simply version bumping this ebuild is not likely to work but FAILURES WILL
# BE VERY SUBTLE IF IT DOES NOT WORK.
# 

inherit eutils gnome.org

DESCRIPTION="Java bindings for GTK libraries (allow GTK applications to be written in Java)"
HOMEPAGE="http://java-gnome.sourceforge.net/"
RDEPEND=">=x11-libs/gtk+-2.4
	>=virtual/jre-1.2"

DEPEND="${RDEPEND}
	>=virtual/jdk-1.2
	app-arch/zip"

#
# Critical that this match gtkapiversion
#
SLOT="2.4"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc"
IUSE="gcj"

src_unpack() {
	unpack ${A}
	cd ${S}

	# I know it's better to use ${P}, but I don't feel like duplicating 
	# the patch files for every bloody point release. I'll copy them at 
	# major version releases.

	epatch ${FILESDIR}/libgtk-java-2.4.8.1_gentoo-PN-SLOT.patch

	use gcj || epatch ${FILESDIR}/libgtk-java-2.4.8.1_find-jni.patch

	# Rediculous glitch from upstream's packaging.
	rm -f ${S}/config.cache
}

src_compile() {
	local conf

	use gcj	|| conf="${conf} --without-gcj-compile"

	cd ${S}

	#
	# Ordinarily, moving things around post `make install` would do 
	# the trick, but there are paths hard coded in .pc files and in the
	# `make install` step itself that need to be influenced.
	#
	# NOTE: THIS RELIES ON PORTAGE PASSING $PN AND $SLOT IN THE ENVIRONMENT
	#

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
			${conf} || die "./configure failed"
	make || die
}

src_install() {
	make prefix=${D}/usr install || die

	mv ${D}/usr/share/doc/libgtk${SLOT}-java ${D}/usr/share/doc/${PF}

	# the upstream install scatters things around a bit. The following cleans
	# that up to make it policy compliant.

	# I originally tried java-pkg_dojar here, but it has a few glitches 
	# like not copying symlinks as symlinks which makes a mess.

	dodir /usr/share/${PN}-${SLOT}/lib
	mv ${D}/usr/share/java/*.jar ${D}/usr/share/${PN}-${SLOT}/lib
	rm -rf ${D}/usr/share/java

	mkdir ${D}/usr/share/${PN}-${SLOT}/src
	cd ${S}/src/java
	zip -r ${D}/usr/share/${PN}-${SLOT}/src/libgtk-java-${PV}.src.zip *

	# again, with dojar misbehaving, better do to this manually for the 
	# time being.

	echo "DESCRIPTION=${DESCRIPTION}" \
		>  ${D}/usr/share/${PN}-${SLOT}/package.env

	echo "CLASSPATH=/usr/share/${PN}-${SLOT}/lib/gtk${SLOT}.jar" \
		>> ${D}/usr/share/${PN}-${SLOT}/package.env
}
