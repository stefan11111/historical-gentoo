# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr/vdr-1.3.27.ebuild,v 1.5 2005/08/21 21:37:33 zzam Exp $

inherit eutils

IUSE="lirc vfat rcu
	lnbsharing sourcecaps aio bigpatch jumpplay"

# Names of patches
FNAME_AIO="vdr-1.3.27-enAIO-2.4.diff"
FNAME_BIGPATCH="vdr-1.3.27-bigpatch-test4.diff"
FNAME_JUMPPLAY="vdr-jumpplay-0.6-1.3.24.diff"
FNAME_LNBSHARING="BETA-configurableLNBshare-VDR_1.3.26.patch"
FNAME_SOURCECAPS_NORMAL="vdr-1.3.27-SourceCaps.diff"
FNAME_SOURCECAPS_LNBSHARING="vdr-1.3.27-SourceCaps-lnb-sharing.diff"

DESCRIPTION="The Video Disk Recorder"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="ftp://ftp.cadsoft.de/vdr/Developer/${P}.tar.bz2
	lnbsharing? ( http://xn--ltzke-jua.de/dvb/VDR_LNB_sharing_patch/${FNAME_LNBSHARING} )
	aio? ( http://www.saunalahti.fi/~rahrenbe/vdr/patches/${FNAME_AIO}.gz )
	bigpatch? ( http://bigpatch.vdr-developer.org/1.3.27/BETA/${FNAME_BIGPATCH}.bz2 )
	jumpplay? ( http://www.toms-cafe.de/vdr/download/${FNAME_JUMPPLAY} )"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"


_DEPEND="media-libs/jpeg
	lirc? ( app-misc/lirc )
	sys-apps/gawk"

RDEPEND="${_DEPEND}
	dev-lang/perl
	media-tv/vdrplugin-rebuild
	media-tv/gentoo-vdr-scripts"

DEPEND="${_DEPEND}
	|| (
		>=sys-kernel/linux-headers-2.6.11-r2
		media-tv/linuxtv-dvb
	)"

# Relevant Pathes for vdr on gentoo
DVB_DIR=/usr/include
VDR_INCLUDE_DIR=/usr/include/vdr
PLUGIN_DIR=/usr/lib/vdr/plugins
CONF_DIR=/etc/vdr
RC_DIR=/usr/lib/vdr/rcscript
CAP_FILE=${S}/vdr-capabilities.sh
VDR_HOME=/var/vdr

pkg_setup() {
	enewgroup vdr
	enewuser vdr -1 /bin/bash ${VDR_HOME} vdr,video
}

src_unpack() {
	unpack ${A}
	cd ${S}

	ebegin "Changing pathes for gentoo"
	sed -e 's-$(DVBDIR)/include-$(DVBDIR)-' -i Makefile

	sed \
	  -e 's-ConfigDirectory = VideoDirectory;-ConfigDirectory = CONFIGDIR;-' \
	  -i vdr.c

	cat > Make.config <<-EOT
		#
		# Generated by ebuild ${PF}
		#
		DVBDIR       = ${DVB_DIR}
		PLUGINLIBDIR = ${PLUGIN_DIR}
		CONFIGDIR    = ${CONF_DIR}

		DEFINES     += -DCONFIGDIR=\"\$(CONFIGDIR)\"
	EOT
	eend 0


	# apply standard patches
	local PATCHDIR=${FILESDIR}/${PV}
	local MY_SOURCECAPS="${PATCHDIR}/${FNAME_SOURCECAPS_NORMAL}"

	if use bigpatch; then
		epatch "../${FNAME_BIGPATCH}"
	else
		# All these patches are included in bigpatch
		if use aio; then
			if use lnbsharing; then
				ewarn "At the moment lnbsharing can not be combined with aio, dropping aio patch!"
			else
				epatch "../${FNAME_AIO}"
			fi
		fi

		if use lnbsharing; then
			epatch "${DISTDIR}/${FNAME_LNBSHARING}"
			MY_SOURCECAPS="${PATCHDIR}/${FNAME_SOURCECAPS_LNBSHARING}"
		fi

		use sourcecaps && epatch "${MY_SOURCECAPS}"

		if use jumpplay; then
			if use sourcecaps; then
				ewarn "At the moment sourcecaps can not be combined with jumpplay, dropping jumpplay patch."
			else
				epatch "${DISTDIR}/${FNAME_JUMPPLAY}"
			fi
		fi
	fi



	# apply local patches defined by variable VDR_LOCAL_PATCHES_DIR
	if test -n "${VDR_LOCAL_PATCHES_DIR}"; then
		echo
		einfo "Applying local patches"
		for LOCALPATCH in ${VDR_LOCAL_PATCHES_DIR}/${PV}/*.{diff,patch}; do
			test -f "${LOCALPATCH}" && epatch "${LOCALPATCH}"
		done
	fi
}


src_compile() {
	local myconf=""
	if use rcu; then
		myconf="${myconf} REMOTE=RCU"
		use lirc && ewarn "Only one remotes can be used: dropping lirc and keeping rcu"
	else
		use lirc && myconf="${myconf} REMOTE=LIRC"
	fi
	use vfat && myconf="${myconf} VFAT=1"

	test -n "${myconf}" && einfo "Compiling with: ${myconf}"
	emake ${myconf} || die "compilation failed"

	touch ${CAP_FILE}
}

src_install() {
	exeinto /usr/bin
	doexe vdr
	doexe svdrpsend.pl

	insinto ${VDR_INCLUDE_DIR}
	doins *.h
	doins Make.config

	diropts -m755 -ovdr -gvdr
	keepdir ${CONF_DIR}
	keepdir ${CONF_DIR}/plugins
	keepdir ${VDR_HOME}

	insinto ${CONF_DIR}
	insopts -m0644 -ovdr -gvdr
	doins *.conf channels.conf.*
	insopts -m0644
	diropts -m755


	keepdir "${PLUGIN_DIR}"

	doman vdr.1 vdr.5

	insinto ${RC_DIR}
	doins ${CAP_FILE}
}

pkg_postinst() {
	einfo "It is a good idea to run vdrplugin-rebuild now"
}
