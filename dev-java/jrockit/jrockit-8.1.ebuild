# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit/jrockit-8.1.ebuild,v 1.7 2004/01/09 02:17:32 mr_bones_ Exp $

IUSE=""

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="nostrip"

inherit java

if [[ $ARCH == ia64 ]]; then
	At="jrockit-8.1-j2se1.4.1-linux64.bin"
else
	At="jrockit-8.1-j2se1.4.1-linux32.bin"
fi

S="${WORKDIR}"
SRC_URI=""
DESCRIPTION="BEA WebLogic's J2SE Development Kit, version 8.1"
HOMEPAGE="http://commerce.bea.com/downloads/weblogic_jrockit.jsp"
LICENSE="jrockit"
SLOT="1.4"
KEYWORDS="x86 ia64"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.5
	>=app-arch/unzip-5.50-r1"

PROVIDE="virtual/jre-1.4
	virtual/jdk-1.4
	virtual/java-scheme-2"

src_unpack() {
	local b=32
	[[ $ARCH == ia64 ]] && b=64

	if [ ! -f ${DISTDIR}/${At} ] ; then
		eerror "Please download ${At} from ${HOMEPAGE}"
		eerror "(select the \"Linux ($b bit)\" package format of \"WebLogic JRockit 8.1\")"
		eerror "and move it to ${DISTDIR}."
		eerror "NOTE: This download REQUIRES a fairly extensive registration process."
		die "Download ${At} and put it into ${DISTDIR}."
	fi
	unzip ${DISTDIR}/${At} *.zip
	for z in *.zip ; do
		unzip $z
		rm $z
	done
}

src_install () {
	local dirs="bin console include jre lib"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -dpR $i ${D}/opt/${P}/
	done

	newdoc README.TXT README
	newdoc "License Agreement.txt" LICENSE

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	# Set as default VM if none exists
	einfo "Please review the license agreement in /usr/doc/${P}/LICENSE"
	einfo "If you do not agree to the terms of this license, please uninstall this package"
}
