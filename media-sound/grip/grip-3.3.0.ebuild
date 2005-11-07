# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/grip/grip-3.3.0.ebuild,v 1.9 2005/11/07 10:33:00 flameeyes Exp $

inherit gnuconfig flag-o-matic eutils toolchain-funcs

IUSE="nls oggvorbis"

DESCRIPTION="GTK+ based Audio CD Player/Ripper."
HOMEPAGE="http://www.nostatic.org/grip"
SRC_URI="mirror://sourceforge/grip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"

RDEPEND=">=x11-libs/gtk+-2.2
	x11-libs/vte
	media-sound/lame
	media-sound/cdparanoia
	>=media-libs/id3lib-3.8.3
	>=gnome-base/libgnomeui-2.2.0
	>=gnome-base/orbit-2
	gnome-base/libghttp
	net-misc/curl
	oggvorbis? ( media-sound/vorbis-tools )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# see #84704
	epatch ${FILESDIR}/${PV}-crashfix.patch

	gnuconfig_update
}

src_compile() {
	# Bug #69536
	[[ $(tc-arch) == "x86" ]] && append-flags "-mno-sse"

	econf \
		--disable-dependency-tracking \
		$(use_enable nls) || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CREDITS ChangeLog README TODO
}
