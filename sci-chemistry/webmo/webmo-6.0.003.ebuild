# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/webmo/webmo-6.0.003.ebuild,v 1.2 2005/12/04 08:42:14 spyderous Exp $

inherit eutils webapp

MY_SRC_PN="WebMO"
MY_SRC_P="${MY_SRC_PN}.${PV}"
DESCRIPTION="Web-based interface to computational chemistry packages"
HOMEPAGE="http://webmo.net/"
SRC_URI="${MY_SRC_P}.tar.gz"
LICENSE="WebMO"
SLOT="${PVR}"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""
RDEPEND="dev-lang/perl
	net-www/apache"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_SRC_PN}.install"

pkg_nofetch() {
	einfo "Go to http://webmo.net/ and register for a free license."
	einfo "Download ${SRC_URI} and place it in ${DISTDIR}."
}

src_unpack() {
	# We need a license number to proceed
	if [[ -z ${WEBMO_LICENSE} ]]; then
		msg="You must set WEBMO_LICENSE to your license number in make.conf."
		ewarn "$msg"
		die "$msg"
	fi

	# Check for invalid license values. Valid are dddd-dddd-dddd
	if [[ ${WEBMO_LICENSE} != [0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9] ]]; then
		msg="Invalid license format. Licenses should be DDDD-DDDD-DDDD (D is a digit)."
		ewarn "$msg"
		die "$msg"
	fi

	unpack ${A}

	# Set up program locations to match where portage installs them
	epatch ${FILESDIR}/gentoo-locations.patch

	# Add a data directory for gamess, because WebMO expects everything
	# in one directory instead of FHS
	# (Depends on gentoo-locations.patch)
	epatch ${FILESDIR}/add-gamess-data-directory.patch

	# Don't run diagnose.pl or ask about being root user
	epatch ${FILESDIR}/dont-be-interactive-or-diagnose.patch

	# Make setup.conf
	create_setup_conf
}

src_compile() {
	# Doesn't compile, it's perl+html
	true
}

src_install() {
	webapp_src_preinst

	# Install everything
	perl setup.pl || die "Check ${S}/diagnose.html for errors"

	# Get ${D} out of main config file
	dosed "${MY_CGIBINDIR}/webmo/interfaces/globals.int"

	webapp_hook_script ${FILESDIR}/reconfig

	local files=$(find ${D}${MY_HOSTROOTDIR}/webmo ${D}${MY_CGIBINDIR}/webmo/interfaces)
	# Add the directories themselves
	files="${files} ${MY_HOSTROOTDIR}/webmo ${MY_CGIBINDIR}/webmo/interfaces"
	files=$(echo ${files} | sed -e "s:${D}::g")
	for file in ${files}; do
		webapp_configfile "${file}"
		webapp_serverowned "${file}"
	done

	webapp_src_install
}

pkg_postinst() {
	einfo
	einfo "Be sure that this line is uncommented in httpd.conf:"
	einfo "AddHandle cgi-scripts .cgi"
	einfo
	einfo "The diagnose.pl script can be run if WebMO doesn't work properly."
	einfo

	webapp_pkg_postinst
}

create_setup_conf() {
	local SETUP_CONF="${S}/setup.conf"

	echo_setup perlPath /usr/bin/perl "${SETUP_CONF}"
	echo_setup htmlBase "${D}${MY_HTDOCSDIR}" "${SETUP_CONF}"
	echo_setup url_htmlBase /webmo "${SETUP_CONF}"
	echo_setup cgiBase "${D}${MY_CGIBINDIR}/webmo" "${SETUP_CONF}"
	echo_setup url_cgiBase /cgi-bin/webmo "${SETUP_CONF}"
	echo_setup userBase "${D}${MY_HOSTROOTDIR}/webmo" "${SETUP_CONF}"
	echo_setup license "${WEBMO_LICENSE}" "${SETUP_CONF}"
}

# Takes three arguments:
# 1: variable, 2: value, 3: file to echo them to
echo_setup() {
	# All values must be double-quoted, so escape the inner quotes.
	echo "${1}=\"${2}\"" >> ${3}
}
