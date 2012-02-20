# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfsprogs/ntfsprogs-2.0.0-r3.ebuild,v 1.2 2012/02/20 11:52:58 scarabeus Exp $

EAPI=4

inherit eutils flag-o-matic autotools

DESCRIPTION="User tools for NTFS filesystems"
HOMEPAGE="http://www.linux-ntfs.org/"
SRC_URI="mirror://sourceforge/linux-ntfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt debug fuse gnome minimal static-libs"

RDEPEND="
	fuse? ( >=sys-fs/fuse-2.7.0 )
	crypt? (
		>=dev-libs/libgcrypt-1.2.0
		>=net-libs/gnutls-1.2.8
		>=dev-libs/libconfig-1.0.1
	)
	gnome? (
		>=dev-libs/glib-2.0
		>=gnome-base/gnome-vfs-2.0
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	#epatch "${FILESDIR}"/${P}-extras.patch #218601
	epatch "${FILESDIR}"/${P}-erange.patch #329445
	epatch "${FILESDIR}"/${P}-cryptolink.patch #361307

	use minimal || sed -i 's:^EXTRA_PROGRAMS.*+\?=:bin_PROGRAMS +=:' ntfsprogs/Makefile.am #218601

	eautoreconf
}

src_configure() {
	# Avoid --enable-debug as that will set -O0 -ggdb3
	use debug && append-flags -DDEBUG

	econf \
		$(use_enable static-libs static) \
		$(use_enable crypt crypto) \
		$(use_enable fuse ntfsmount) \
		$(use_enable gnome gnome-vfs)
}

src_install() {
	default

	use static-libs || find "${ED}" -name '*.la' -exec rm -f {} +

	mv "${ED}"/sbin/mkfs.ntfs "${ED}"/usr/sbin/ || die
	if ! use minimal ; then
		mv "${ED}"/usr/bin/ntfsck "${ED}"/sbin/ || die
		dosym ntfsck /sbin/fsck.ntfs
	fi
	if use fuse ; then
		mv "${ED}"/sbin/mount.{fuse.ntfs,ntfs-fuse} "${ED}"/usr/bin/ || die
	fi

	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO.* \
		doc/attribute_definitions doc/*.txt doc/tunable_settings
}
