# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: William McArthur <sandymac@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mkl/mkl-5.1.ebuild,v 1.1 2002/04/27 01:19:07 sandymac Exp $

S=${WORKDIR}

DESCRIPTION="Intel(R) Math Kernel Library"

# No need to, there aren't any executables and it takes a long time.
RESTRICT="nostrip"

LICENSE="imkl-5.1"

SRC_URI="http://developer.intel.com/software/products/mkl/downloads/mkleval-514.tar"

HOMEPAGE="http://developer.intel.com/software/products/mkl/mkl52/index.htm"

DEPEND=">=sys-libs/glibc-2.2.2
		sys-apps/cpio
		app-arch/rpm"

RDEPEND=">=sys-kernel/linux-sources-2.4
		>=sys-libs/glibc-2.2.2"

src_compile() {
	mkdir opt

	for x in intel-*.i386.rpm
	do
		einfo "Extracting: ${x}"
		rpm2cpio ${x} | cpio --extract --make-directories --unconditional
	done

	sed s@\<INSTALLTIMECOMBOPACKAGEID\>@mkl_eval-5.1-4@g \
		< opt/intel/mkl/mklsupport \
		> opt/intel/mkl/mklsupport.abs
	mv opt/intel/mkl/mklsupport.abs opt/intel/mkl/mklsupport 
}

src_install () {
	dodoc mkllicense
	cp -a opt ${D}

	# mkl enviroment
	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/35mkl
}
