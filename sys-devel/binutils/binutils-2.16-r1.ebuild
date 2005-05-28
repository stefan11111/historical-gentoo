# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.16-r1.ebuild,v 1.1 2005/05/28 08:37:38 vapier Exp $

PATCHVER="1.5"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

# ARCH - packages to test before marking
KEYWORDS="-* ~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"

src_unpack() {
	tc-binutils_unpack

	# Patches
	cd "${WORKDIR}"/patch
	# FreeBSD patches are not safe
	[[ ${CTARGET} != *-freebsd* ]] \
		&& mv 00_all_freebsd* skip/ \
		|| rm -f "${WORKDIR}"/uclibc-patches/40*all-libcs*

	tc-binutils_apply_patches
}
