# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtksourceview-sharp/gtksourceview-sharp-0.3.ebuild,v 1.3 2004/06/24 22:03:25 agriffis Exp $

inherit mono

DESCRIPTION="A C# Binding to gtksourceview"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/beta2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND=">=dev-dotnet/mono-0.95
		>=x11-libs/gtk-sharp-0.93
		>=x11-libs/gtksourceview-0.7.0"

src_unpack() {
	unpack ${A}
	sed -i "s:\`monodoc:${D}\`monodoc:" ${S}/doc/Makefile.in
}

src_compile() {
	econf || die "./configure failed!"
	MAKEOPTS="-j1" make || die "make failed"
}

src_install() {
	dodir $(monodoc --get-sourcesdir)
	make DESTDIR=${D} install || die
}

