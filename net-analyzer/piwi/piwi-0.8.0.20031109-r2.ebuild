# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/piwi/piwi-0.8.0.20031109-r2.ebuild,v 1.6 2004/07/11 10:36:09 eldad Exp $

DESCRIPTION="(Prelude|Perl) IDS Web Interface"
HOMEPAGE="http://www.prelude-ids.org"

# [LeRoutier] son, i'll keep this versionning scheme : x.y.z.t (x.y to
# match the major of prelude, z is piwi
#SRC_URI="http://www.leroutier.net/Projects/PreludeIDS/${PN}_v${PV}.tar.gz"
#SRC_URI="http://dev.gentoo.org/~mboman/distfiles/${PN}_v${PV}.tar.gz"
SRC_URI="mirror://gentoo/${PN}_v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
IUSE="mysql postgres gd"
DEPEND=""
RDEPEND="
	dev-lang/perl
	dev-perl/DBI
	dev-perl/Date-Calc
	virtual/ghostscript
	dev-perl/Geo-IP
	postgres? ( dev-perl/DBD-Pg )
	mysql? ( dev-perl/DBD-mysql )
	gd? ( dev-perl/GDGraph )
"

S=${WORKDIR}/

src_compile() {
	if ! use mysql && ! use postgres; then
		eerror "You must have either MySQL or PostgreSQL enabled to use this software."
		eerror "You must put either 'mysql' or 'postgres' (or both) in your USE flags before emerging this."

		has_version ">=sys-apps/portage-2.0.50" && (
			einfo "You can add:"
			einfo "net-analyzer/piwi [use flags]"
			einfo "to the file:"
			einfo "/etc/portage/package.use"
			einfo "to permamently set this package's USE flags"
		)
		exit 1
	fi
}


src_install() {
	into /var/www/localhost/htdocs/piwi || die
	into /etc/piwi || die

	# "install" the files into the destination
	cp -aR ${S}/* ${D}/var/www/localhost/htdocs/piwi/ || die

	# Fix permissions
	# Opt not to use the ebuild functions fowners() and fperms()
	# as they doesn't seem to work reqursively.
	chown -R root:apache ${D}/var/www/localhost/htdocs/piwi/* || die
	chown -R apache:apache ${D}/var/www/localhost/htdocs/piwi/generated || die
	chmod -R o-rwx ${D}/var/www/localhost/htdocs/piwi/* || die

	# Move files around and create symlinks to make sure configuration files
	# are not being overwritten when you do upgrades...
	mv ${D}/var/www/localhost/htdocs/piwi/generated/Filters ${D}/etc/piwi/Filters || die
	dosym /etc/piwi/Filters /var/www/localhost/htdocs/piwi/generated/Filters

	mv ${D}/var/www/localhost/htdocs/piwi/Profiles ${D}/etc/piwi/Profiles || die
	dosym /etc/piwi/Profiles /var/www/localhost/htdocs/piwi/Profiles

	# default config.pl is looking for ghostscript in /usr/local/... that's not where
	# Gentoo has it.. So we do some sed magic to fix it..
	cat ${D}/var/www/localhost/htdocs/piwi/Functions/config.pl | sed s:/usr/local/bin/gs:/usr/bin/gs: > ${D}/etc/piwi/config.pl || die
	rm ${D}/var/www/localhost/htdocs/piwi/Functions/config.pl
	dosym /etc/piwi/config.pl /var/www/localhost/htdocs/piwi/Functions/config.pl

	# Install configuration file for apache
	insinto /etc/piwi
	doins ${FILESDIR}/piwi-apache.conf
}

pkg_postinst() {
	einfo ""
	einfo "To have Apache run PIWI, please do the following:"
	einfo "1) Include the /etc/piwi/piwi-apache.conf in your apache configuration"
	einfo "2) Edit /etc/conf.d/apache or /etc/conf.d/apache2 and add \"-D PIWI\""
	einfo "3) Edit /etc/piwi/config.pl to reflect your settings"
	ewarn ""
	ewarn "NOTE: If you do not perform these steps PIWI will _not_ work."
	ewarn "      You have been warned. Any bugs against this will be either:"
	ewarn ""
	ewarn "       - directed to /dev/null"
	ewarn "       - resolved with a RTFM comment"
	ewarn ""
	ewarn "Consider yourself warned"
	# Make sure that the user pay attention
	echo -ne "\a"; sleep 0.25 ; echo -ne "\a"; sleep 0.25
}
