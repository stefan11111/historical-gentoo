# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugzilla/bugzilla-2.22.3.ebuild,v 1.7 2008/02/05 15:20:39 hollow Exp $

inherit webapp depend.apache

DESCRIPTION="Bugzilla is the Bug-Tracking System from the Mozilla project"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/webtools/${P}.tar.gz"
HOMEPAGE="http://www.bugzilla.org"

LICENSE="MPL-1.1 NPL-1.1"
KEYWORDS="~alpha ~amd64 ia64 ppc ppc64 sparc x86"

IUSE="extras graphviz mysql postgres"

RDEPEND="
	>=dev-lang/perl-5.6.1
	postgres? ( >=dev-perl/DBD-Pg-1.45 )
	mysql? ( >=dev-perl/DBD-mysql-3.0007 )
	graphviz? ( media-gfx/graphviz )
	>=dev-perl/AppConfig-1.52
	>=virtual/perl-CGI-2.93
	>=dev-perl/TimeDate-1.16
	>=dev-perl/DBI-1.38
	>=virtual/perl-File-Spec-0.84
	virtual/perl-File-Temp
	>=dev-perl/Template-Toolkit-2.13
	>=dev-perl/Text-Tabs+Wrap-2001.0131
	>=dev-perl/MailTools-1.67
	>=virtual/perl-MIME-Base64-3.01
	dev-perl/MIME-tools
	virtual/perl-Storable

	extras? (
	dev-perl/HTML-Scrubber
	dev-perl/Template-GD
	>=dev-perl/Chart-2.3
	>=dev-perl/GD-1.20
	dev-perl/GDGraph
	dev-perl/GDTextUtil
	dev-perl/perl-ldap
	>=dev-perl/PatchReader-0.9.4
	dev-util/patchutils
	dev-perl/XML-Twig )
"
# dev-util/patchutils needed for interdiff

need_apache2

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove CVS directories
	find . -type d -name 'CVS' -print | xargs rm -rf
}

src_install () {
	webapp_src_preinst

	cp -r ${S}/* ${D}/${MY_HTDOCSDIR} || die

	cp ${FILESDIR}/2.22/apache.htaccess ${D}/${MY_HTDOCSDIR}/.htaccess

	local FILE="bugzilla.cron.daily bugzilla.cron.tab"
	cd ${FILESDIR}/2.22
	cp ${FILE} ${D}/${MY_HTDOCSDIR}

	webapp_hook_script ${FILESDIR}/2.22/reconfig
	webapp_postinst_txt en ${FILESDIR}/2.22/postinstall-en.txt
	webapp_src_install

	# bug #124282
	chmod -R +x ${D}/${MY_HTDOCSDIR}/*.cgi
}
