# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/sendmail/sendmail-8.12.4.ebuild,v 1.4 2002/06/11 21:19:16 g2boojum Exp $

DESCRIPTION="Widely-used Mail Transport Agent (MTA)."
HOMEPAGE="http://www.sendmail.org"
LICENSE="Sendmail"
SLOT="0"

PROVIDE="virtual/mta"
DEPEND="virtual/glibc
		net-misc/hesiod
		sys-libs/gdbm
		sys-devel/m4
		sasl? ( dev-libs/cyrus-sasl )
		tcpd? ( sys-apps/tcp-wrappers )
		ssl? ( dev-libs/openssl )
		ldap? ( net-nds/openldap )"

# We need some db; pick gdbm if none in USE
if [ -n "`use gdbm`" ]
then
	DEPEND="${DEPEND}
			sys-libs/gdbm"
elif [ -n "`use berkdb`" ]
then
	DEPEND="${DEPEND}
			sys-libs/db-3.2"
else
	DEPEND="${DEPEND}
			sys-libs/gdbm"
fi

RDEPEND="${DEPEND}
		>=net-mail/mailbase-0.00
		!virtual/mta"

SRC_URI="ftp://ftp.sendmail.org/pub/${PN}/${PN}.${PV}.tar.gz"

S=${WORKDIR}/${P}

pkg_setup() {
	if ! grep -q ^smmsp: /etc/group
	then
		groupadd smmsp || die "problem adding group smmsp"
	fi
	if ! grep -q ^smmsp: /etc/passwd
	then
		useradd -d /var/spool/mqueue -g smmsp -s /dev/null smmsp \
			|| die "problem adding user smmsp"
	fi
}

src_unpack() {
	unpack ${A}
	for file in ${PN}-8.12.2-{makemapman,smrsh-paths,unix}
	do
		cat ${FILESDIR}/${file}.patch | patch -d ${S} -p1 || die "${file} patch failed"
	done

	confCCOPTS="${CFLAGS}"
	confMAPDEF="-DNEWDB -DMAP_REGEX"
	confENVDEF="-DXDEBUG=0"
	confLIBS="-lnsl -lcrypt"
	conf_sendmail_ENVDEF="-DFALSE=0 -DTRUE=1"
	conf_sendmail_LIBS=""
	use sasl && confLIBS="${confLIBS} -lsasl"  \
		&& confENVDEF="${confENVDEF} -DSASL" \
		&& conf_sendmail_ENVDEF="${conf_sendmail_ENVDEF} -DSASL"  \
		&& conf_sendmail_LIBS="${conf_sendmail_LIBS} -lsasl"
	use tcpd && confENVDEF="${confENVDEF} -DTCPWRAPPERS" \
		&& confLIBS="${confLIBS} -lwrap"
	use ssl && confENVDEF="${confENVDEF} -DSTARTTLS" \
		&& confLIBS="${confLIBS} -lssl -lcrypto" \
		&& conf_sendmail_ENVDEF="${conf_sendmail_ENVDEF} -DSTARTTLS" \
		&& conf_sendmail_LIBS="${conf_sendmail_LIBS} -ssl -lcrypto"
	use ldap && confMAPDEF="${confMAPDEF} -DLDAPMAP" \
		&& confLIBS="${confLIBS} -lldap -llber"
	use gdbm && confLIBS="${confLIBS} -lgdbm"
	sed -e "s/@@confCCOPTS@@/${confCCOPTS}/" \
		-e "s/@@confMAPDEF@@/${confMAPDEF}/" \
		-e "s/@@confENVDEF@@/${confENVDEF}/" \
		-e "s/@@confLIBS@@/${confLIBS}/" \
		-e "s/@@conf_sendmail_ENVDEF@@/${conf_sendmail_ENVDEF}/" \
		-e "s/@@conf_sendmail_LIBS@@/${conf_sendmail_LIBS}/" \
		${FILESDIR}/site.config.m4 > ${S}/devtools/Site/site.config.m4
}

src_compile() {
	for x in libmilter libsmutil sendmail mailstats rmail praliases smrsh makemap vacation mail.local
	do
		pushd ${x}
		sh Build 
		popd
	done
}

src_install () {
	OBJDIR="obj.`uname -s`.`uname -r`.`arch`"
	dodir /etc/pam.d /usr/bin /usr/include/libmilter /usr/lib 
	dodir /usr/share/man/man{1,5,8} /usr/sbin /var/log /usr/share/sendmail-cf
	dodir /var/spool/{mqueue,clientmqueue}
	for dir in libmilter libsmutil sendmail mailstats praliases smrsh makemap vacation
	do
		make DESTDIR=${D} MANROOT=/usr/share/man/man \
			SBINOWN=root SBINGRP=root UBINOWN=root UBINGRP=root \
			MANOWN=root MANGRP=root INCOWN=root INCGRP=root \
			LIBOWN=root LIBGRP=root GBINOWN=root GBINGRP=root \
			MSPQOWN=root CFOWN=root CFGRP=root \
			install -C ${OBJDIR}/${dir} \
			|| die "install failed"
	done
	for dir in rmail mail.local
	do
		make DESTDIR=${D} MANROOT=/usr/share/man/man \
			SBINOWN=root SBINGRP=root UBINOWN=root UBINGRP=root \
			MANOWN=root MANGRP=root INCOWN=root INCGRP=root \
			LIBOWN=root LIBGRP=root GBINOWN=root GBINGRP=root \
			MSPQOWN=root CFOWN=root CFGRP=root \
			force-install -C ${OBJDIR}/${dir} \
			|| die "install failed"
	done
	dosym /usr/sbin/makemap /usr/bin/makemap
	dodoc FAQ LICENSE KNOWNBUGS README RELEASE_NOTES doc/op/op.ps
	newdoc sendmail/README README.sendmail
	newdoc sendmail/SECURITY SECURITY
	newdoc sendmail/TUNING TUNING
	newdoc smrsh/README README.smrsh
	newdoc libmilter/README README.libmilter
	newdoc cf/README README.cf
	newdoc cf/cf/README README.install-cf
	cp -a cf/* ${D}/usr/share/sendmail-cf
	insinto /etc/mail
	newins cf/cf/generic-linux.mc sendmail.mc
	newins cf/cf/generic-linux.cf sendmail.cf
	echo "# local-host-names - include all aliases for your machine here" \
		> ${D}/etc/mail/local-host-names
	cat << EOF > ${D}/etc/mail/local-host-names
# trusted-users - users that can send mail as others without a warning
# apache, mailman, majordomo, uucp are good candidates
EOF
	cat << EOF > ${D}/etc/mail/access
# Check the /usr/share/doc/sendmail/README.cf file for a description
# of the format of this file. (search for access_db in that file)
# The /usr/share/doc/sendmail/README.cf is part of the sendmail-doc
# package.
#
# by default we allow relaying from localhost...
localhost.localdomain		RELAY
localhost			RELAY
127.0.0.1			RELAY

EOF
}
