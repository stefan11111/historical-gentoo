# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jline/jline-0.9.9-r1.ebuild,v 1.2 2007/01/05 04:22:49 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Java library for handling console input"
HOMEPAGE="http://jline.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	cd ${S}
	mkdir lib
	# we don't support maven for building yet. this build.xml was generated by:
	# - mvn ant:ant
	# - tweak build.xml to use <fileset dir="lib" includes="**/*.jar" for
	# build.classpath
	cp ${FILESDIR}/build-${PV}.xml build.xml || die "failed to copy build.xml"
}

src_install() {
	java-pkg_newjar target/${P}.jar
	use source && java-pkg_dosrc src/main/java
}
