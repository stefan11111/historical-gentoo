# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dahdi-tools/dahdi-tools-2.2.0-r1.ebuild,v 1.3 2009/12/22 13:58:06 chainsaw Exp $

EAPI=1
inherit eutils

DESCRIPTION="Userspace tools to configure the kernel modules from net-misc/dahdi"
HOMEPAGE="http://www.asterisk.org"
SRC_URI="http://downloads.digium.com/pub/telephony/dahdi-tools/releases/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/dahdi
	!net-misc/zaptel
	virtual/libusb:0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Work around broken 07_all_pull-libc-headers-linux.patch
	# that seemingly nobody wants to fix.
	if ! has_version "=sys-kernel/linux-headers-2.6.29"; then
		epatch "${FILESDIR}/${P}-ifreq.patch"
	fi
	epatch "${FILESDIR}/${P}-modprobe-suffix.patch"
	epatch "${FILESDIR}/${P}-vendorlib.patch"
	epatch "${FILESDIR}/${P}-no-hardware-fiddling.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "Failed to install binaries"
	emake DESTDIR="${D}" config || die "Failed to install configuration files"

	# install init script
	newinitd "${FILESDIR}"/dahdi.init2 dahdi
}
