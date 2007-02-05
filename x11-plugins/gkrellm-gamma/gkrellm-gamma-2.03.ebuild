# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-gamma/gkrellm-gamma-2.03.ebuild,v 1.6 2007/02/05 15:55:39 gustavoz Exp $

IUSE=""
DESCRIPTION="A gamma control plugin for gkrellm"
HOMEPAGE="http://sweb.cz/tripie/gkrellm/gamma/"
SRC_URI="http://sweb.cz/tripie/gkrellm/gamma/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~sparc ppc x86"

DEPEND="=app-admin/gkrellm-2*"

src_install() {
	insinto /usr/lib/gkrellm2/plugins
	doins gamma.so
	dodoc AUTHORS COPYING README
}
