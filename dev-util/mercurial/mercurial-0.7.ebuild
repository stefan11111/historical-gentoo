# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mercurial/mercurial-0.7.ebuild,v 1.4 2005/10/12 14:35:44 agriffis Exp $

inherit distutils

MY_PV=${PV//_p/.}

DESCRIPTION="scalable distributed SCM"
HOMEPAGE="http://www.selenic.com/mercurial/"
SRC_URI="http://www.selenic.com/mercurial/release/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	app-text/asciidoc
	app-text/xmlto"

if [[ ${PV} == *_p* ]]; then
	S=${WORKDIR}/mercurial-snapshot
else
	S=${WORKDIR}/${PN}-${MY_PV}
fi

src_compile() {
	distutils_src_compile

	cd doc
	local x
	for x in *.?.txt; do
		asciidoc -d manpage -b docbook $x || die
		xmlto man ${x%txt}xml || die
		sed -nie '/./p' ${x%.*} || die
	done
}

src_install() {
	distutils_src_install

	dodoc CONTRIBUTORS PKG-INFO README *.txt
	cp hgweb*.cgi ${D}/usr/share/doc/${PF}/
	cp -r contrib ${D}/usr/share/doc/${PF}/
	doman doc/*.?
}
