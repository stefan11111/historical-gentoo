# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/java-access-bridge/java-access-bridge-1.3.1.ebuild,v 1.8 2004/05/29 03:28:36 pvdabeel Exp $

inherit java-pkg gnome2

DESCRIPTION="Gnome Java Accessibility Bridge"
HOMEPAGE="http://www.gnome.org/"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~amd64 ppc"
IUSE=""
RDEPEND=">=gnome-base/libbonobo-2
	>=gnome-extra/at-spi-1.3.9
	>=virtual/jdk-1.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-java/java-config"

DOCS="AUTHORS ChangeLog COPYING NEWS README"
G2CONF="${G2CONF} --with-java-home=${JAVA_HOME}"

src_install() {
	gnome2_src_install

	java-pkg_dojar ${D}/usr/share/jar/*.jar

	insinto /usr/share/${PN}
	doins ${D}/usr/share/jar/*.properties

	rm -rf ${D}/usr/share/jar

	einfo "Installing symbolic links into ${JAVA_HOME}/jre/lib"

	dodir ${JAVA_HOME}/jre/lib/ext
	dosym \
		${ROOT}/usr/share/${PN}/accessibility.properties \
		${JAVA_HOME}/jre/lib/accessibility.properties

	local jarfile
	for jar in ${D}/usr/share/${PN}/lib/*.jar
	do
		jarfile=$(basename $jar)
		dosym \
			${ROOT}/usr/share/${PN}/lib/$jarfile \
			${JAVA_HOME}/jre/lib/ext/$jarfile
	done
}

pkg_postinst() {
	einfo ""
	einfo "The Java Accessibility Bridge for GNOME has been installed."
	einfo ""
	einfo "For this to work with your regular java desktop applications,"
	einfo "make sure too add the following line to your ~/.orbitrc file:"
	einfo ""
	einfo "  ORBIIOPIPv4=1"
	einfo ""
	einfo "And then either:"
	einfo "  a) Restart your session, or"
	einfo "  b) Manually kill your bonobo-activation-server and"
	einfo "     at-spi-registryd processes."
	einfo ""
}
