# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-init-scripts/mysql-init-scripts-2.0_pre1.ebuild,v 1.2 2011/01/13 20:07:12 robbat2 Exp $

DESCRIPTION="Gentoo MySQL init scripts."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
# This _will_ break with MySQL 5.0, 4.x, 3.x
# It also NEEDS openrc for the save_options/get_options builtins.
RDEPEND="!<dev-db/mysql-5.1
		 sys-apps/openrc"

src_install() {
	newconfd "${FILESDIR}/mysql-5.1.53-conf.d" "mysql"
	newinitd "${FILESDIR}/mysql-5.1.53-init.d" "mysql"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/logrotate.mysql" "mysql"
}

pkg_postinst() {
	grep -sq mysql_slot "${ROOT}"/etc/conf.d/mysql
	old_conf_present=$?
	grep -sq mysql_slot "${ROOT}"/etc/init.d/mysql
	old_init_present=$?

	egrep -sq 'MY_CNF|MY_ARGS|(STARTUP|STOP)_TIMEOUT' "${ROOT}"/etc/conf.d/mysql
	new_conf_present=$?
	grep -sq 'MY_CNF|MY_ARGS|(STARTUP|STOP)_TIMEOUT' "${ROOT}"/etc/init.d/mysql
	new_init_present=$?

	einfo "Please note if you are using multiple internal 'slots' in the old"
	einfo "conf.d fille, that you should use multiple init files now."

	# new scripts present	
	if [ $new_conf_present -eq 0 -a $new_init_present -eq 0 -a
		 $old_conf_present -eq 1 -a $old_init_present -eq 1 ]; then
		:
	elif [ $old_conf_present -eq 0 -a $old_init_present -eq 0 -a
		 $new_conf_present -eq 1 -a $new_init_present -eq 1 ]; then
		ewarn "Old /etc/init.d/mysql and /etc/conf.d/mysql still present!"
		ewarn "Update both of those files to the new versions!"
	else
		eerror "DANGER, mixed update of /etc/init.d/mysql and /etc/conf.d/mysql"
		eerror "detected! You must update BOTH to the new versions"
	fi
}
