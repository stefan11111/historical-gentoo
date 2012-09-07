# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/tribler/tribler-5.9.22.ebuild,v 1.4 2012/09/07 22:04:50 johu Exp $

EAPI="4"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"

inherit eutils python

MY_PV="${PN}_${PV}-1ubuntu1_all"

DESCRIPTION="Bittorrent client that does not require a website to discover content"
HOMEPAGE="http://www.tribler.org/"
SRC_URI="
	http://dl.tribler.org/${MY_PV}.deb
	x86?   ( http://dl.tribler.org/tribler-swift_5.9.22-27598_i386.deb )
	amd64? ( http://dl.tribler.org/tribler-swift_5.9.22-27598_amd64.deb )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="vlc"

RDEPEND="
	dev-python/apsw
	dev-python/m2crypto
	dev-python/netifaces
	dev-libs/openssl
	dev-python/wxpython
	vlc? (
			media-video/vlc
			media-video/ffmpeg
		)"

DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

QA_PREBUILT="/usr/share/tribler/swift"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	for i in ${A}; do
		unpack ${i}
		unpack ./data.tar.gz
	done
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-5.9.12-fix-global-declarations.patch"
	epatch "${FILESDIR}/${PN}-log2homedir.patch"

	python_convert_shebangs -r 2 .
}

src_compile() { :; }

src_install() {
	#Rename the doc dir properly
	mv usr/share/doc/${PN} usr/share/doc/${P}

	#Move the readme to the doc dir
	mv usr/share/${PN}/Tribler/readme.txt usr/share/doc/${P}

	#Remove the licenses scattered throughout
	rm usr/share/doc/${P}/copyright
	rm usr/share/${PN}/Tribler/*.txt
	rm usr/share/${PN}/Tribler/Core/DecentralizedTracking/pymdht/{LGPL-2.1.txt,LICENSE.txt}

	#Copy the rest over
	cp -pPR usr/ "${ED}"/
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"usr/share/${PN}
}
