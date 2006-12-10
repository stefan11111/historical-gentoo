# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-community/mysql-community-5.1.14_beta.ebuild,v 1.1 2006/12/10 00:34:04 vivo Exp $

# Leave this empty
MYSQL_VERSION_ID=""
MYSQL_RERELEASE=""
# Set the patchset revision to use, must be either empty or a decimal number
MYSQL_PATCHSET_REV=""
BASE_URI="mirror://mysql/Downloads/MySQL-${PV%.*}"

inherit mysql

#REMEMBER!!!: update also eclass/mysql*.eclass prior to commit
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"

src_test() {
	cd "${S}"
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	make check || die "make check failed"
	if ! useq "minimal" ; then
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		local retstatus
		addpredict /this-dir-does-not-exist/t9.MYI

		cd mysql-test
		sed -i -e "s|PORT=3306|PORT=3307|g" mysql-test-run
		./mysql-test-run
		retstatus=$?

		# Just to be sure ;)
		pkill -9 -f "${S}/ndb" 2>/dev/null
		pkill -9 -f "${S}/sql" 2>/dev/null
		[[ $retstatus -eq 0 ]] || die "make test failed"
	else
		einfo "Skipping server tests due to minimal build."
	fi
}
