# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/asm/asm-3.2.ebuild,v 1.4 2010/02/26 12:24:15 phajdan.jr Exp $

WANT_ANT_TASKS="ant-owanttask"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Bytecode manipulation framework for Java"
HOMEPAGE="http://asm.objectweb.org"
SRC_URI="http://download.forge.objectweb.org/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="3"
IUSE=""
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

# Needs deps we don't have yet
RESTRICT="test"

EANT_DOC_TARGET="jdoc"

# Fails if this property is not set
EANT_EXTRA_ARGS="-Dobjectweb.ant.tasks.path=foobar"

src_install() {
	for x in output/dist/lib/*.jar ; do
		java-pkg_newjar ${x} $(basename ${x/-${PV}})
	done
	use doc && java-pkg_dojavadoc output/dist/doc/javadoc/user/
	use source && java-pkg_dosrc src/*
}
