# Copyright 2002 Maik Schreiber
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jedit/jedit-4.0.ebuild,v 1.6 2002/11/29 23:28:25 vapier Exp $

MY_PV=${PV//.}
S="${WORKDIR}/jEdit"
DESCRIPTION="A programmer's editor written in Java"
HOMEPAGE="http://www.jedit.org"
SRC_URI="mirror://sourceforge/jedit/${PN}${MY_PV}source.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="jikes"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}
	>=dev-java/ant-1.4.1
	jikes? ( >=dev-java/jikes-1.17 )"

src_compile() {
	local antflags

	antflags=""
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} || die "compile problem"
}

src_install () {
	dodir /usr/jedit
	dodir /usr/bin

	cp -R jedit.jar jars macros modes properties startup ${D}/usr/jedit
	chmod -R u+rw,ug-s,go+u,go-w \
		${D}/usr/jedit/jedit.jar \
		${D}/usr/jedit/jars \
		${D}/usr/jedit/macros \
		${D}/usr/jedit/modes \
		${D}/usr/jedit/properties \
		${D}/usr/jedit/startup

	cat >${D}/usr/jedit/jedit.sh <<-EOF
		#!/bin/bash

		cd /usr/jedit
		java -jar /usr/jedit/jedit.jar $@
	EOF

	chmod 755 ${D}/usr/jedit/jedit.sh

	ln -s ../jedit/jedit.sh ${D}/usr/bin/jedit
}
