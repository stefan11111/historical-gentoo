# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/timezone-data/timezone-data-2006n.ebuild,v 1.11 2006/11/04 23:42:33 vapier Exp $

inherit eutils toolchain-funcs flag-o-matic

code_ver=${PV}
data_ver=${PV}
DESCRIPTION="Timezone data (/usr/share/zoneinfo) and utilities (tzselect/zic/zdump)"
HOMEPAGE="ftp://elsie.nci.nih.gov/pub/"
SRC_URI="ftp://elsie.nci.nih.gov/pub/tzdata${data_ver}.tar.gz
	ftp://elsie.nci.nih.gov/pub/tzcode${code_ver}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="nls"

DEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-2005n-makefile.patch
	tc-is-cross-compiler && cp -pR "${S}" "${S}"-native
}

src_compile() {
	tc-export CC
	use elibc_FreeBSD && append-flags -DSTD_INSPIRED #138251
	use nls && export NLS=1 || export NLS=0
	emake || die "emake failed"
	if tc-is-cross-compiler ; then
		make -C "${S}"-native CC=$(tc-getBUILD_CC) zic || die
	fi
}

src_install() {
	local zic=""
	tc-is-cross-compiler && zic="zic=${S}-native/zic"
	make install ${zic} DESTDIR="${D}" || die
	rm -rf "${D}"/usr/share/zoneinfo-leaps
	dodoc README Theory
	dohtml *.htm *.jpg
}

pkg_postinst() {
	if [[ ! -e ${ROOT}/etc/localtime ]] ; then
		ewarn "Please remember to set your timezone using the zic command."
		rm -f "${ROOT}"/etc/localtime
		ln -s ../usr/share/zoneinfo/Factory "${ROOT}"/etc/localtime
	fi
}
