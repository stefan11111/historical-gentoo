# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/fusepod/fusepod-0.5.2.ebuild,v 1.1 2011/03/30 15:42:33 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="A userspace filesystem which mounts your iPod into a directory"
HOMEPAGE="http://sourceforge.net/projects/fusepod/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libgpod
	media-libs/taglib
	sys-fs/fuse"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS NEWS README README.fuse THANKS TODO"

src_prepare() {
	epatch "${FILESDIR}"/${P}-missing_include.patch
}
