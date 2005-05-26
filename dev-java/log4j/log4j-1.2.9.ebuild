# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/log4j/log4j-1.2.9.ebuild,v 1.8 2005/05/26 09:57:00 luckyduck Exp $

inherit java-pkg

DESCRIPTION="A low-overhead robust logging package for Java"
SRC_URI="mirror://apache/logging/log4j/${PV}/logging-${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 amd64 ppc64 ~sparc ppc"
IUSE="doc javamail jikes jms jmx source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4
	javamail? ( dev-java/sun-javamail-bin dev-java/sun-jaf-bin )
	jmx? ( dev-java/jmx )
	jms? ( =dev-java/openjms-bin-0.7.6 )"

S="${WORKDIR}/logging-${P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf dist/
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use javamail && antflags="${antflags} -Djavamail.jar=/usr/share/sun-javamail-bin/lib/mail.jar -Dactivation.jar=/usr/share/sun-jaf-bin/lib/activation.jar"
	use jmx && antflags="${antflags} -Djmx.jar=/usr/share/jmx/lib/jmxri.jar -Djmx-extra.jar=/usr/share/jmx/lib/jmxtools.jar"
	use jms && antflags="${antflags} -Djms.jar=/opt/openjms/lib/jms-1.0.2a.jar"
	ant ${antflags} || die "compilation error"
}

src_install() {
	cd dist/lib
	mv log4j-${PV}.jar ${PN}.jar
	java-pkg_dojar ${PN}.jar

	use doc && java-pkg_dohtml -r ${S}/docs/*
	use source && java-pkg_dosrc ${S}/src/java/*
}

