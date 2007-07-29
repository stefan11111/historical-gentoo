# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/lxr/lxr-0.9.5.ebuild,v 1.4 2007/07/29 17:28:37 phreak Exp $

inherit perl-module webapp multilib eutils

DESCRIPTION="general purpose source code indexer and cross-referener with a web-based frontend"
HOMEPAGE="http://sourceforge.net/projects/lxr"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cvs freetext mysql postgres"

RDEPEND="dev-util/ctags
	www-servers/apache
	freetext? ( >=www-apps/swish-e-2.1 )
	dev-lang/perl
	dev-perl/DBI
	dev-perl/File-MMagic
	cvs? ( app-text/rcs )
	postgres? ( dev-db/postgresql dev-perl/DBD-Pg )
	mysql? ( dev-perl/DBD-mysql )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/initdb-mysql.patch

	sed -i \
		-e 's|/usr/local/bin/swish-e|/usr/bin/swish-e|' \
		-e 's|/usr/bin/ctags|/usr/bin/exuberant-ctags|' \
		-e "s|'glimpse|#'glimpse|g" \
		-e "s:/path/to/lib:${VENDOR_LIB}:" \
		templates/lxr.conf
	sed -i \
		-e 's|Apache::Registry|ModPerl::PerlRun|' \
		.htaccess
	sed -i \
		-e 's|require Local;|require LXR::Local;|' \
		-e 's|use Local;|use LXR::Local;|' \
		-e 's|package Local;|package LXR::Local;|' \
		Local.pm lib/LXR/Common.pm diff find ident search source
}

# prevent eclasses from overriding this
src_compile() { :; }

src_install() {
	perlinfo
	webapp_src_preinst

	insinto "${VENDOR_LIB}"
	doins -r lib/LXR || die
	insinto "${VENDOR_LIB}"/LXR
	doins Local.pm

	dodoc BUGS CREDITS.txt ChangeLog HACKING INSTALL notes .htaccess* swish-e.conf

	exeinto "${MY_HTDOCSDIR}"
	doexe diff find genxref ident search source || die
	insinto "${MY_HTDOCSDIR}"
	doins .htaccess* templates/* || die

	webapp_configfile "${MY_HTDOCSDIR}"/lxr.conf "${MY_HTDOCSDIR}"/.htaccess
	webapp_sqlscript mysql initdb-mysql
	webapp_sqlscript postgresql initdb-postgres
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_hook_script "${FILESDIR}"/reconfig
	webapp_src_install
}
