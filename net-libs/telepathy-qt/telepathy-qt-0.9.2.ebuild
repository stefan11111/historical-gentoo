# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-qt/telepathy-qt-0.9.2.ebuild,v 1.2 2012/07/31 07:08:47 scarabeus Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"
inherit python base cmake-utils

DESCRIPTION="Qt4 bindings for the Telepathy D-Bus protocol"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug farsight farstream test"

RDEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	farsight? (
		net-libs/telepathy-farsight
	)
	farstream? (
		>=net-libs/telepathy-farstream-0.2.2
		>=net-libs/telepathy-glib-0.17.5
	)
	!net-libs/telepathy-qt4
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? (
		dev-libs/dbus-glib
		dev-libs/glib
		dev-python/dbus-python
		x11-libs/qt-test:4
	)
"

REQUIRED_USE="farsight? ( !farstream )"

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable farsight)
		$(cmake-utils_use_enable farstream)
		$(cmake-utils_use_enable debug DEBUG_OUTPUT)
		$(cmake-utils_use_enable test TESTS)
		-DENABLE_EXAMPLES=OFF
	)
	cmake-utils_src_configure
}
