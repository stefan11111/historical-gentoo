# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dd-rescue/dd-rescue-1.24.ebuild,v 1.1 2011/12/05 10:22:04 radhermit Exp $

EAPI=4

inherit base toolchain-funcs

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Similar to dd but can copy from source with errors"
HOMEPAGE="http://www.garloff.de/kurt/linux/ddrescue/"
SRC_URI="http://www.garloff.de/kurt/linux/ddrescue/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86 ~arm ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="static kernel_linux elibc_glibc"

S=${WORKDIR}/${MY_PN}

src_compile() {
	use static && append-flags -static

	# Passing LDFLAGS together with CFLAGS is not often a good idea, but
	# in this case it makes it possible to avoid patching; after all it
	# only builds the progrma whole, not with object files.
	#
	# The falloc target creates a dd_rescue binary that uses the
	# fallocate() function, present in Kernel 2.6.23 and later and GLIBC
	# 2.10 and later. If somebody can think of a better way to
	# optionally use it, suggestions are welcome.
	emake RPM_OPT_FLAGS="${CFLAGS} ${LDFLAGS}" CC="$(tc-getCC)" \
		$(use kernel_linux && use elibc_glibc && echo "falloc")
}

src_install() {
	# easier to install by hand than trying to make sense of the
	# Makefile.
	into /
	dobin dd_rescue

	dodoc README.dd_rescue
}
