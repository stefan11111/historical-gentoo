# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/viewcvs/viewcvs-0.9.2-r1.ebuild,v 1.3 2004/05/30 20:29:13 robbat2 Exp $

PDATE=${PV/0.9.2_p/}
DESCRIPTION="Viewcvs, a web interface to cvs and subversion"
HOMEPAGE="http://viewcvs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PDATE}.tar.gz"

LICENSE="viewcvs"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=""
RDEPEND=">=app-text/rcs-5.7
	>=dev-util/cvs-1.11
	sys-apps/diffutils
	net-www/apache"

WWW="/home/httpd/viewcvs"

doinstall() {
	# start_location=$1
	# end_location=$2
	# mode=$3
	if [ -d $1 ]; then
		install -o root -d ${D}/$2
		for f in ${1}/*
		do
			doinstall ${f} ${f/${1}/${2}} $3
		done
	else
		sed -e "{ s,\(^#!.*$\),#!/usr/bin/python,; \
		s,\(<VIEWCVS_INSTALL_DIRECTORY>\),${WWW},; \
		s,\(^LIBRARY_DIR\)\(.*\$\),\1 = \"${WWW}/lib\",; \
		s,\(^CONF_PATHNAME\)\(.*\$\),\1 = \"${WWW}/viewcvs.conf\",}" ${1} >${1}.cpy

		install -o root -m $3 ${1}.cpy ${D}/$2
		rm ${1}.cpy
	fi
}

src_install() {
	cd ${S}
	install -o root -d ${D}/${WWW}/cgi

	doinstall cgi/viewcvs.cgi ${WWW}/cgi/viewcvs.cgi 755
	doinstall cgi/query.cgi ${WWW}/cgi/query.cgi 755
	doinstall standalone.py ${WWW}/standalone.py 755
	doinstall tools/loginfo-handler ${WWW}/loginfo-handler 755
	doinstall tools/cvsdbadmin ${WWW}/cvsdbadmin 755
	doinstall tools/make-database ${WWW}/make-database 755

	insinto /etc/viewcvs
	doinstall cgi/viewcvs.conf.dist ${WWW}/viewcvs.conf 644
	doinstall cgi/cvsgraph.conf.dist ${WWW}/cvsgraph.conf 644

	doinstall lib ${WWW}/lib 644
	doinstall templates ${WWW}/templates 644

	doinstall website ${WWW}/doc 644

	dosym ${WWW}/viewcvs.conf /etc/viewcvs/viewcvs.conf
	dosym ${WWW}/cvsgraph.conf /etc/viewcvs/cvsgraph.conf

	cat <<EOF >apache.conf
ScriptAlias /viewcvs /home/httpd/viewcvs/cgi/viewcvs.cgi
ScriptAlias /cvsquery /home/httpd/viewcvs/cgi/cvsquery.cgi

<Directory /home/httpd/viewcvs/cgi>
	Options ExecCGI
	<IfModule mod_access.c>
		Order allow,deny
		Allow from all
	</IfModule>
</Directory>
EOF
	dodoc INSTALL TODO CHANGES README apache.conf
}

pkg_postinst() {
	ewarn "Before using viewcvs make sure you configure it correctly."
	einfo "There is a sample apache integration configuration file in the"
	einfo "documentation directory named: apache.conf"
}
