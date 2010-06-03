# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/exim/exim-4.72.ebuild,v 1.1 2010/06/03 19:23:55 grobian Exp $

EAPI="3"

inherit eutils toolchain-funcs multilib pam

IUSE="tcpd ssl postgres mysql ldap pam exiscan-acl lmtp ipv6 sasl dnsdb perl mbx X nis syslog spf srs gnutls sqlite dovecot-sasl radius maildir +dkim dcc dsn"

DSN_EXIM_V=469
DSN_V=1_3

DESCRIPTION="A highly configurable, drop-in replacement for sendmail"
SRC_URI="ftp://ftp.exim.org/pub/exim/exim4/${P}.tar.bz2
	mirror://gentoo/system_filter.exim.gz
	dsn? ( mirror://sourceforge/eximdsn/eximdsn-patch-1.3/exim_${DSN_EXIM_V}_dsn_${DSN_V}.patch )"
HOMEPAGE="http://www.exim.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

PROVIDE="virtual/mta"

DEPEND=">=sys-apps/sed-4.0.5
	>=sys-libs/db-3.2
	dev-libs/libpcre
	perl? ( sys-devel/libperl )
	pam? ( virtual/pam )
	tcpd? ( sys-apps/tcp-wrappers )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	gnutls? ( net-libs/gnutls
			  dev-libs/libtasn1 )
	ldap? ( >=net-nds/openldap-2.0.7 )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-base )
	sasl? ( >=dev-libs/cyrus-sasl-2.1.14 )
	spf? ( >=mail-filter/libspf2-1.2.5-r1 )
	srs? ( mail-filter/libsrs_alt )
	X? ( x11-proto/xproto
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXt
		x11-libs/libXaw
	)
	sqlite? ( dev-db/sqlite )
	radius? ( net-dialup/radiusclient )
	virtual/libiconv
	"
	# added X check for #57206
RDEPEND="${DEPEND}
	!virtual/mta
	!net-mail/mailwrapper
	>=net-mail/mailbase-0.00-r5
	virtual/logger
	dcc? ( mail-filter/dcc )
	"

src_prepare() {
	epatch "${FILESDIR}"/exim-4.14-tail.patch
	epatch "${FILESDIR}"/exim-4.43-r2-localscan_dlopen.patch
	epatch "${FILESDIR}"/exim-4.69-r1.27021.patch
	# for cross-compilation, but currently breaks normal compiles :/ #266591
	#epatch "${FILESDIR}"/${P}-buildconfig-cross-compile.patch

	use maildir && epatch "${FILESDIR}"/exim-4.20-maildir.patch
	use dsn && epatch "${DISTDIR}"/exim_${DSN_EXIM_V}_dsn_${DSN_V}.patch
}

src_configure() {
	local myconf

	sed -i "/SYSTEM_ALIASES_FILE/ s'SYSTEM_ALIASES_FILE'${EPREFIX}/etc/mail/aliases'" "${S}"/src/configure.default
	cp "${S}"/src/configure.default "${S}"/src/configure.default.orig

	# includes typo fix for bug #47106
	sed -e "48i\CFLAGS=${CFLAGS}" \
		-e "s:# AUTH_CRAM_MD5=yes:AUTH_CRAM_MD5=yes:" \
		-e "s:# AUTH_PLAINTEXT=yes:AUTH_PLAINTEXT=yes:" \
		-e "s:BIN_DIRECTORY=/usr/exim/bin:BIN_DIRECTORY=${EPREFIX}/usr/sbin:" \
		-e "s:COMPRESS_COMMAND=/usr/bin/gzip:COMPRESS_COMMAND=${EPREFIX}/bin/gzip:" \
		-e "s:ZCAT_COMMAND=/usr/bin/zcat:ZCAT_COMMAND=${EPREFIX}/bin/zcat:" \
		-e "s:CONFIGURE_FILE=/usr/exim/configure:CONFIGURE_FILE=${EPREFIX}/etc/exim/exim.conf:" \
		-e "s:EXIM_MONITOR=eximon.bin:# EXIM_MONITOR=eximon.bin:" \
		-e "s:# INFO_DIRECTORY=/usr/local/info:INFO_DIRECTORY=${EPREFIX}/usr/share/info:" \
		-e "s:# LOG_FILE_PATH=/var/log/exim_%slog:LOG_FILE_PATH=${EPREFIX}/var/log/exim/exim_%s.log:" \
		-e "s:# PID_FILE_PATH=/var/lock/exim.pid:PID_FILE_PATH=${EPREFIX}/var/run/exim.pid:" \
		-e "s:# SPOOL_DIRECTORY=/var/spool/exim:SPOOL_DIRECTORY=${EPREFIX}/var/spool/exim:" \
		-e "s:# SUPPORT_MAILDIR=yes:SUPPORT_MAILDIR=yes:" \
		-e "s:# SUPPORT_MAILSTORE=yes:SUPPORT_MAILSTORE=yes:" \
		-e "s:EXIM_USER=:EXIM_USER=mail:" \
		-e "s:# AUTH_SPA=yes:AUTH_SPA=yes:" \
		-e "s:^ZCAT_COMMAND.*$:ZCAT_COMMAND=${EPREFIX}/bin/zcat:" \
		-e "s:# LOOKUP_PASSWD=yes:LOOKUP_PASSWD=yes:" \
		src/EDITME > Local/Makefile

	# exiscan-acl is now integrated - enable it when use-flag set
	if use exiscan-acl; then
		sed -i "s:# WITH_CONTENT_SCAN=yes:WITH_CONTENT_SCAN=yes:" Local/Makefile
		sed -i "s:# WITH_OLD_DEMIME=yes:WITH_OLD_DEMIME=yes:" Local/Makefile
	elif (use spf || use srs ) then
		eerror SPF and SRS support require exiscan-acl to be enabled, please add
		eerror to your USE settings.
		exit 1
	fi

	if use spf; then
		myconf="${myconf} -lspf2"
		sed -i "s:# EXPERIMENTAL_SPF=yes:EXPERIMENTAL_SPF=yes:" Local/Makefile
		mycflags="${mycflags} -DEXPERIMENTAL_SPF"
	fi
	if use srs; then
		myconf="${myconf} -lsrs_alt"
		sed -i "s:# EXPERIMENTAL_SRS=yes:EXPERIMENTAL_SRS=yes:" Local/Makefile
	fi

	cd Local
	# enable optional exim_monitor support via X use flag bug #46778
	if use X; then
		einfo "Configuring eximon"
		cp ../exim_monitor/EDITME eximon.conf
		sed -i "s:# EXIM_MONITOR=eximon.bin:EXIM_MONITOR=eximon.bin:" Makefile
	fi
	if use perl; then
		sed -i "s:# EXIM_PERL=perl.o:EXIM_PERL=perl.o:" Makefile
	fi
	# mbox useflag renamed, see bug #110741
	if use mbx; then
		sed -i "s:# SUPPORT_MBX=yes:SUPPORT_MBX=yes:" Makefile
	fi
	if use pam; then
		sed -i "s:# \(SUPPORT_PAM=yes\):\1:" Makefile
		myconf="${myconf} -lpam"
	fi
	if use sasl; then
		sed -i "s:# CYRUS_SASLAUTHD_SOCKET=${EPREFIX}/var/state/saslauthd/mux:CYRUS_SASLAUTHD_SOCKET=${EPREFIX}/var/lib/sasl2/mux:"  Makefile
		sed -i "s:# AUTH_CYRUS_SASL=yes:AUTH_CYRUS_SASL=yes:" Makefile
		myconf="${myconf} -lsasl2"
	fi
	if use tcpd; then
		sed -i "s:# \(USE_TCP_WRAPPERS=yes\):\1:" Makefile
		myconf="${myconf} -lwrap"
	fi
	if use lmtp; then
		sed -i "s:# \(TRANSPORT_LMTP=yes\):\1:" Makefile
	fi
	if use ipv6; then
		echo "HAVE_IPV6=YES" >> Makefile
		# to fix bug #41196
		echo "IPV6_USE_INET_PTON=yes" >> Makefile
	fi
	if use dovecot-sasl; then
		sed -i "s:# AUTH_DOVECOT=yes:AUTH_DOVECOT=yes:" Makefile
	fi
	if use radius; then
		myconf="${myconf} -lradiusclient"
		sed -i "s:# RADIUS_CONFIG_FILE=/etc/radiusclient/radiusclient.conf:RADIUS_CONFIG_FILE=${EPREFIX}/etc/radiusclient/radiusclient.conf:" Makefile
		sed -i "s:# RADIUS_LIB_TYPE=RADIUSCLIENT$:RADIUS_LIB_TYPE=RADIUSCLIENT:" Makefile
	fi
	if [[ -n ${myconf} ]] ; then
		echo "EXTRALIBS=${myconf} ${LDFLAGS}" >> Makefile
	fi

	# make iconv usage explicit
	echo "HAVE_ICONV=yes" >> Makefile
	# if we use libiconv, now is the time to tell so
	use !elibc_glibc && echo "EXTRALIBS_EXIM=-liconv" >> Makefile

	cd "${S}"
	if use ssl; then
		sed -i \
			-e "s:# \(SUPPORT_TLS=yes\):\1:" Local/Makefile
		if use gnutls; then
			sed -i \
				-e "s:# \(USE_GNUTLS=yes\):\1:" \
				-e "s:# \(TLS_LIBS=-lgnutls -ltasn1 -lgcrypt\):\1:" Local/Makefile
		else
			sed -i \
				-e "s:# \(TLS_LIBS=-lssl -lcrypto\):\1:" Local/Makefile
		fi
	fi

	LOOKUP_INCLUDE=
	LOOKUP_LIBS=

	if use ldap; then
		sed -i \
			-e "s:# \(LOOKUP_LDAP=yes\):\1:" \
			-e "s:# \(LDAP_LIB_TYPE=OPENLDAP2\):\1:" Local/Makefile
		LOOKUP_INCLUDE="-I${EROOT}usr/include/ldap"
		LOOKUP_LIBS="-lldap -llber"
	fi

	if use mysql; then
		sed -i "s:# LOOKUP_MYSQL=yes:LOOKUP_MYSQL=yes:" Local/Makefile
		LOOKUP_INCLUDE="$LOOKUP_INCLUDE -I${EROOT}usr/include/mysql"
		LOOKUP_LIBS="$LOOKUP_LIBS -lmysqlclient"
	fi

	if use postgres; then
		sed -i "s:# LOOKUP_PGSQL=yes:LOOKUP_PGSQL=yes:" Local/Makefile
		LOOKUP_INCLUDE="$LOOKUP_INCLUDE -I${EROOT}usr/include/postgresql"
		LOOKUP_LIBS="$LOOKUP_LIBS -lpq"
	fi
	if use sqlite; then
		sed -i "s:# LOOKUP_SQLITE=yes: LOOKUP_SQLITE=yes:" Local/Makefile
		LOOKUP_INCLUDE="$LOOKUP_INCLUDE -I${EROOT}usr/include/sqlite"
		LOOKUP_LIBS="$LOOKUP_LIBS -lsqlite3"
	fi
	if [[ -n ${LOOKUP_INCLUDE} ]]; then
		sed -i "s:# LOOKUP_INCLUDE=-I /usr/local/ldap/include -I /usr/local/mysql/include -I /usr/local/pgsql/include:LOOKUP_INCLUDE=$LOOKUP_INCLUDE:" \
			Local/Makefile
	fi

	if [[ -n ${LOOKUP_LIBS} ]]; then
		sed -i "s:# LOOKUP_LIBS=-L/usr/local/lib -lldap -llber -lmysqlclient -lpq -lgds -lsqlite3:LOOKUP_LIBS=$LOOKUP_LIBS:" \
			Local/Makefile
	fi

	sed -i -e 's/^buildname=.*/buildname=exim-gentoo/g' Makefile

	sed -i "s:# LOOKUP_DSEARCH=yes:LOOKUP_DSEARCH=yes:" Local/Makefile

	if use dnsdb; then
		sed -i "s:# LOOKUP_DNSDB=yes:LOOKUP_DNSDB=yes:" Local/Makefile
	fi
	sed -i "s:# LOOKUP_CDB=yes:LOOKUP_CDB=yes:" Local/Makefile

	if use nis; then
		sed -i -e "s:# LOOKUP_NIS=yes:LOOKUP_NIS=yes:" \
			-e "s:# LOOKUP_NISPLUS=yes:LOOKUP_NISPLUS=yes:" Local/Makefile
	fi
	if use syslog; then
		sed -i "s:LOG_FILE_PATH=/var/log/exim/exim_%s.log:LOG_FILE_PATH=syslog:" Local/Makefile
	fi
	if ! use dkim; then
		# DKIM is enabled by default. We have to explicitly disable it.
		echo "DISABLE_DKIM=yes">> Local/Makefile
	fi
	if use dcc; then
		echo "EXPERIMENTAL_DCC=yes">> Local/Makefile
	fi
	if use dsn; then
		sed -i -e "s:#define SUPPORT_DSN:define SUPPORT_DSN:" Local/Makefile
	fi

	# use the "native" interface to the DBM library
	echo "USE_DB=yes" >> "${S}"/Local/Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" FULLECHO='' || die "make failed"
}

src_install () {
	cd "${S}"/build-exim-gentoo
	exeinto /usr/sbin
	doexe exim
	if use X; then
		doexe eximon.bin
		doexe eximon
	fi
	fperms 4755 /usr/sbin/exim

	dodir /usr/bin /usr/sbin /usr/lib

	dosym exim /usr/sbin/sendmail
	dosym exim /usr/sbin/rsmtp
	dosym exim /usr/sbin/rmail
	dosym /usr/sbin/exim /usr/bin/mailq
	dosym /usr/sbin/exim /usr/bin/newaliases
	dosym /usr/sbin/sendmail /usr/lib/sendmail

	exeinto /usr/sbin
	for i in exicyclog exim_dbmbuild exim_dumpdb exim_fixdb exim_lock \
		exim_tidydb exinext exiwhat exigrep eximstats exiqsumm exiqgrep \
		convert4r3 convert4r4 exipick
	do
		doexe $i
	done

	dodoc "${S}"/doc/*
	doman "${S}"/doc/exim.8
	use dsn && dodoc "${S}"/README.DSN

	# conf files
	insinto /etc/exim
	newins "${S}"/src/configure.default.orig exim.conf.dist
	if use exiscan-acl; then
		newins "${S}"/src/configure.default exim.conf.exiscan-acl
	fi
	doins "${WORKDIR}"/system_filter.exim
	doins "${FILESDIR}"/auth_conf.sub

	pamd_mimic system-auth exim auth account

	insinto /etc/logrotate.d
	newins "${FILESDIR}/exim.logrotate" exim

	newinitd "${FILESDIR}"/exim.rc6 exim

	newconfd "${FILESDIR}"/exim.confd exim

	DIROPTIONS="--mode=0750 --owner=mail --group=mail"
	dodir /var/log/${PN}
}

pkg_postinst() {
	einfo "${EROOT}etc/exim/system_filter.exim is a sample system_filter."
	einfo "${EROOT}etc/exim/auth_conf.sub contains the configuration sub for using smtp auth."
	einfo "Please create ${EROOT}etc/exim/exim.conf from ${EROOT}etc/exim/exim.conf.dist."
	if use dcc ; then
		einfo "DCC support is experimental, you can find some limited"
		einfo "documentation at the bottom of this prerelease message:"
		einfo "http://article.gmane.org/gmane.mail.exim.devel/3579"
	fi
}
