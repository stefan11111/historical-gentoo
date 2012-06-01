# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/build/build-0.3.9.ebuild,v 1.1 2012/06/01 07:02:44 dev-zero Exp $

EAPI="4"

inherit versionator

DESCRIPTION="A massively-parallel software build system implemented on top of GNU make."
HOMEPAGE="http://kolpackov.net/projects/build/"
SLOT="$(get_version_component_range 1-2)"
SRC_URI="http://www.codesynthesis.com/download/${PN}/${SLOT}/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

src_install() {
	emake install_prefix="${D}/usr" install

	dodoc documentation/[[:upper:]]*
	dohtml -A xhtml documentation/*.{css,xhtml}

	if use examples ; then
		# preserving symlinks in the examples
		cp -dpR examples "${D}/usr/share/doc/${PF}"
	fi
}
