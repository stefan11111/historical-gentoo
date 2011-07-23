# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nvidia-cuda-toolkit/nvidia-cuda-toolkit-2.2-r3.ebuild,v 1.3 2011/07/23 20:41:24 spock Exp $

EAPI=2

inherit eutils

DESCRIPTION="NVIDIA CUDA Toolkit"
HOMEPAGE="http://developer.nvidia.com/cuda"

CUDA_V=${PV//./_}

BASE_URI="http://developer.download.nvidia.com/compute/cuda/${CUDA_V}/toolkit"
SRC_URI="amd64? ( ${BASE_URI}/cudatoolkit_${PV}_linux_64_rhel4.7.run
		debugger? ( ${BASE_URI}/cudagdb_2.2_linux_64_rhel5.3.run ) )
	x86? ( ${BASE_URI}/cudatoolkit_${PV}_linux_32_rhel4.7.run
		debugger? ( ${BASE_URI}/cudagdb_2.2_linux_32_rhel5.3.run ) )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debugger doc profiler"

RDEPEND="${DEPEND}
	profiler? ( x86? (
		x11-libs/qt-gui
		x11-libs/qt-core
		x11-libs/qt-assistant
		x11-libs/qt-sql[sqlite] )
	)
	debugger? ( >=sys-libs/libtermcap-compat-2.0.8-r2 )"

S="${WORKDIR}"

src_unpack() {
	for f in ${A} ; do
		unpack_makeself ${f}
	done
}

src_prepare() {
	epatch "${FILESDIR}/${P}-enum_fix.patch"
}

src_install() {
	local DEST=/opt/cuda
	export CONF_LIBDIR_OVERRIDE="lib"

	# HACK: temporary workaround until CONF_LIBDIR_OVERRIDE is respected.
	export LIBDIR_amd64="lib"

	into ${DEST}
	dobin bin/*
	dolib lib/*

	chmod a-x "${D}/${DEST}/bin/nvcc.profile"

	# doman does not respect DESTTREE
	insinto ${DEST}/man/man1
	doins man/man1/*
	insinto ${DEST}/man/man3
	doins man/man3/*
	prepman ${DEST}

	insinto ${DEST}/include
	doins include/*.h
	insinto ${DEST}/include/crt
	doins include/crt/*.h

	insinto ${DEST}/src
	doins src/*

	into ${DEST}/open64
	dobin open64/bin/*
	libopts -m0755
	dolib open64/lib/*

	if use doc ; then
		insinto ${DEST}/doc
		doins -r doc/*
	fi

	cat > "${T}/env" << EOF
PATH=${DEST}/bin
ROOTPATH=${DEST}/bin
LDPATH=${DEST}/lib
MANPATH=${DEST}/man
EOF
	newenvd "${T}/env" 99cuda

	if use profiler; then
		into ${DEST}/cudaprof
		dobin cudaprof/bin/cudaprof

		cat > "${T}/env" << EOF
PATH=${DEST}/cudaprof/bin
ROOTPATH=${DEST}/cudaprof/bin
EOF
		if use x86 ; then
			dosym /usr/bin/assistant ${DEST}/cudaprof/bin
		else
			dobin cudaprof/bin/assistant
			insinto ${DEST}/cudaprof/bin
			doins cudaprof/bin/*.so*
			insinto ${DEST}/cudaprof/bin/sqldrivers
			doins cudaprof/bin/sqldrivers/*

			cat >> "${T}/env" << EOF
LDPATH=${DEST}/cudaprof/bin
EOF
		fi

		newenvd "${T}/env" 99cudaprof

		if use doc; then
			insinto ${DEST}/cudaprof/doc
			doins cudaprof/doc/*
			insinto ${DEST}/cudaprof/projects
			doins cudaprof/projects/*
		fi
	fi
}

pkg_postinst() {
	elog "If you want to natively run the code generated by CUDA, you will need"
	elog ">=x11-drivers/nvidia-drivers-185.18.08."
	elog ""
	elog "This CUDA toolkit release does not support gcc-4.4.  Please make sure"
	elog "to switch to a lower GCC version before using nvcc."
	elog ""
	elog "Run '. /etc/profile' before using the CUDA toolkit. "
}
