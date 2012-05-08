# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-multimedia/qt-multimedia-4.8.1.ebuild,v 1.2 2012/05/08 18:26:10 hwoarang Exp $

EAPI=4

inherit qt4-build

DESCRIPTION="The Multimedia module for the Qt toolkit"
SLOT="4"
KEYWORDS="amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="alsa"

DEPEND="
	~x11-libs/qt-core-${PV}[aqua=,c++0x=,debug=,qpa=]
	~x11-libs/qt-gui-${PV}[aqua=,c++0x=,debug=,qpa=]
	alsa? ( media-libs/alsa-lib )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-4.8.0-alsa.patch"
)

pkg_setup() {
	QT4_TARGET_DIRECTORIES="
		src/multimedia"

	QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
		include/Qt
		include/QtCore
		include/QtGui
		include/QtMultimedia
		src/src.pro
		src/corelib
		src/gui"

	QCONFIG_ADD="multimedia"
	QCONFIG_DEFINE="QT_MULTIMEDIA"

	qt4-build_pkg_setup
}

src_configure() {
	myconf+="
		-multimedia -audio-backend
		$(qt_use alsa)
		-no-accessibility -no-qt3support -no-xmlpatterns -no-phonon -no-phonon-backend
		-no-svg -no-webkit -no-script -no-scripttools -no-declarative
		-system-zlib -no-gif -no-libtiff -no-libpng -no-libmng -no-libjpeg -no-openssl
		-no-cups -no-dbus -no-gtkstyle -no-nas-sound -no-opengl
		-no-sm -no-xshape -no-xvideo -no-xsync -no-xinerama -no-xcursor -no-xfixes
		-no-xrandr -no-xrender -no-mitshm -no-fontconfig -no-freetype -no-xinput -no-xkb"

	qt4-build_src_configure
}
