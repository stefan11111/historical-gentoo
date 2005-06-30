# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man/man-1.6.ebuild,v 1.2 2005/06/30 09:50:53 lu_zero Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Standard commands to read man pages"
HOMEPAGE="http://primates.ximian.com/~flucifredi/man/"
SRC_URI="http://primates.ximian.com/~flucifredi/man/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="nls"

DEPEND=""
RDEPEND="sys-process/cronbase
	>=sys-apps/groff-1.18
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Make sure we can build with -j :)
	epatch ${FILESDIR}/man-1.5p-parallel-make.patch

	# Fix search order in man.conf so that system installed manpages
	# will be found first ...
	epatch ${FILESDIR}/man-1.5p-search-order.patch

	# For groff-1.18 or later we need to call nroff with '-c'
	epatch ${FILESDIR}/man-1.5m-groff-1.18.patch

	# makewhatis traverses manpages twice, as default manpath
	# contains two directories that are symlinked together
	epatch ${FILESDIR}/man-1.5p-defmanpath-symlinks.patch

	# use non-lazy binds for man. And let portage handling stripping.
	append-ldflags -Wl,-z,now
	sed -i \
		-e "/^LDFLAGS = -s/s:=.*:=${LDFLAGS}:" \
		src/Makefile.in \
		|| die "failed to edit default LDLFAGS"
}

src_compile() {
	tc-export CC BUILD_CC

	local myconf=
	use nls && myconf="+lang all" || myconf="+lang none"
	./configure \
		-confdir=/etc \
		+sgid +fhs \
		${myconf} || die "configure failed"

	#Ugly workaround
	emake -j1 || die "emake failed"
}

src_install() {
	make PREFIX="${D}" install || die "make install failed"
	dosym man /usr/bin/manpath

	dodoc LSM README* TODO

	exeinto /etc/cron.weekly
	newexe "${FILESDIR}"/makewhatis.cron makewhatis

	keepdir /var/cache/man
	diropts -m0775 -g man
	local mansects=$(grep ^MANSECT "${D}"/etc/man.conf | cut -f2-)
	for x in ${mansects//:/ } ; do
		keepdir /var/cache/man/cat${x}
	done
}

pkg_postinst() {
	einfo "Forcing sane permissions onto ${ROOT}/var/cache/man (Bug #40322)"
	chown -R root:man "${ROOT}"/var/cache/man
	chmod -R g+w "${ROOT}"/var/cache/man
	[[ -e ${ROOT}/var/cache/man/whatis ]] \
		&& chown root:root "${ROOT}"/var/cache/man/whatis

	echo

	local files=$(ls "${ROOT}"/etc/cron.{daily,weekly}/makewhatis{,.cron} 2>/dev/null)
	if [[ ${files/$'\n'} != ${files} ]] ; then
		ewarn "You have multiple makewhatis cron files installed."
		ewarn "You might want to delete all but one of these:"
		echo ${files}
	fi
}
