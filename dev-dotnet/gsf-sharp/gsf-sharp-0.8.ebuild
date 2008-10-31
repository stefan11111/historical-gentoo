# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gsf-sharp/gsf-sharp-0.8.ebuild,v 1.6 2008/10/31 20:18:32 dsd Exp $

inherit eutils mono autotools

DESCRIPTION="C# bindings for libgsf"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://primates.ximian.com/~joe/${P}.tar.gz"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RDEPEND="dev-lang/mono
	>=gnome-extra/libgsf-1.14
	>=dev-dotnet/gtk-sharp-2.3.90"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README
}
