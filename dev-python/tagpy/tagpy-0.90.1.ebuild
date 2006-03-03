# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tagpy/tagpy-0.90.1.ebuild,v 1.2 2006/03/03 18:52:49 sbriesen Exp $

inherit distutils

DESCRIPTION="Python bindings for media-libs/taglib"
HOMEPAGE="http://news.tiker.net/software/tagpy"
SRC_URI="http://news.tiker.net/news.tiker.net/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples"

DEPEND="virtual/python
	>=media-libs/taglib-1.4
	>=dev-libs/boost-1.33.0"

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins test/*
	fi
}
