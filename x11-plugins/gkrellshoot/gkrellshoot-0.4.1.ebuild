# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellshoot/gkrellshoot-0.4.1.ebuild,v 1.19 2005/09/17 10:08:55 agriffis Exp $

S=${WORKDIR}/${P/s/S}
DESCRIPTION="GKrellm2 plugin to take screen shots and lock screen"
HOMEPAGE="http://gkrellshoot.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkrellshoot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*
	>=app-admin/gkrellm-2"
RDEPEND="${DEPEND}
	media-gfx/imagemagick"

src_compile() {
	export CFLAGS="${CFLAGS/-O?/}"
	emake || die "emake failed"
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins gkrellshoot.so
	dodoc README ChangeLog
}
