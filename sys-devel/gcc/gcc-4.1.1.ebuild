# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.1.1.ebuild,v 1.1 2006/05/25 18:33:17 halcy0n Exp $

PATCH_VER="1.1"
UCLIBC_GCC_VER="4.1.0"
UCLIBC_VER="1.1"

ETYPE="gcc-compiler"

# whether we should split out specs files for multiple {PIE,SSP}-by-default
# and vanilla configurations.
SPLIT_SPECS=no #${SPLIT_SPECS-true} hard disable until #106690 is fixed

inherit toolchain

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++, java compilers, pie+ssp extensions, Haj Ten Brugge runtime bounds checking"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="-* ~amd64 ~hppa ~ppc ~s390 ~x86"

RDEPEND=">=sys-libs/zlib-1.1.4
	|| ( app-admin/eselect-compiler >=sys-devel/gcc-config-1.3.12-r4 )
	virtual/libiconv
	fortran? (
	  dev-libs/gmp
	  dev-libs/mpfr
	)
	!build? (
		gcj? (
			gtk? (
				|| ( ( x11-libs/libXt x11-libs/libX11 x11-libs/libXtst x11-proto/xproto x11-proto/xextproto ) virtual/x11 )
				>=x11-libs/gtk+-2.2
				x11-libs/pango
			)
			>=media-libs/libart_lgpl-2.1
		)
		>=sys-libs/ncurses-5.2-r2
		nls? ( sys-devel/gettext )
	)"
if [[ ${CATEGORY} != cross-* ]] ; then
	RDEPEND="${RDEPEND} elibc_glibc? (
	hppa? ( >=sys-libs/glibc-2.3.4 ) !hppa? ( >=sys-libs/glibc-2.3.6 )
	)"
fi
DEPEND="${RDEPEND}
	test? ( sys-devel/autogen )
	>=sys-apps/texinfo-4.2-r4
	>=sys-devel/bison-1.875
	>=${CATEGORY}/binutils-2.15.94"

PDEPEND="|| ( app-admin/eselect-compiler sys-devel/gcc-config )
	x86? ( !nocxx? ( !elibc_uclibc? ( !build? ( =virtual/libstdc++-3.3 ) ) ) )"

src_unpack() {
	gcc_src_unpack

	[[ ${CHOST} == ${CTARGET} ]] && epatch "${FILESDIR}"/gcc-spec-env.patch

	# Fix cross-compiling
	epatch "${FILESDIR}"/4.1.0/gcc-4.1.0-cross-compile.patch

	[[ ${CTARGET} == *-softfloat-* ]] && epatch "${FILESDIR}"/4.0.2/gcc-4.0.2-softfloat.patch
}
