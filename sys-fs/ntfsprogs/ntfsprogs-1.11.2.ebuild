# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfsprogs/ntfsprogs-1.11.2.ebuild,v 1.4 2005/10/18 11:36:23 wolf31o2 Exp $

DESCRIPTION="User tools for NTFS filesystems"
HOMEPAGE="http://linux-ntfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-ntfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="gnome fuse debug"

DEPEND="fuse? ( >=sys-fs/fuse-2.3.0 )
	gnome? (
		>=dev-libs/glib-2.0
		>=gnome-base/gnome-vfs-2.0
	)"

src_compile() {
	sed -i -e 's:-ggdb3::' configure
	econf \
		$(use_enable gnome gnome-vfs) \
		$(use_enable debug) \
		$(use_enable fuse fuse-module) \
		|| die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dosym mkntfs /usr/sbin/mkfs.ntfs
	dodoc AUTHORS CREDITS ChangeLog NEWS README TODO.* \
		doc/attribute_definitions doc/*.txt doc/tunable_settings
}
