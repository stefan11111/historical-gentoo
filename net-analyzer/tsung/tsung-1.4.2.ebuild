# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tsung/tsung-1.4.2.ebuild,v 1.1 2012/03/06 08:54:31 patrick Exp $

EAPI="3"

# Seems to be misconfigured
RESTRICT="test"

inherit eutils

DESCRIPTION="Erlang's multi-protocol distributed load testing tool"
HOMEPAGE="http://tsung.erlang-projects.org/"
SRC_URI="http://tsung.erlang-projects.org/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/erlang"
RDEPEND=${DEPEND}

src_configure() {
	./configure --prefix="/usr" || die "econf failed"
}

src_compile() {
	emake || die "Failed building"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "Failed installing"
}
