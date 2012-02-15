# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bustle/bustle-0.4.0.ebuild,v 1.2 2012/02/15 18:16:40 slyfox Exp $

# ebuild generated by hackport 0.2.14

EAPI=4

CABAL_FEATURES="bin"
inherit haskell-cabal toolchain-funcs

DESCRIPTION="Draw pretty sequence diagrams of D-Bus traffic"
HOMEPAGE="http://hackage.haskell.org/package/bustle"
SRC_URI="http://willthompson.co.uk/${PN}/releases/${PV}/${P}.tar.gz http://dev.gentoo.org/~slyfox/bustle-0.4.0-tests.tar.gz"

LICENSE="LGPL-2 GPL-2" # bustle-dbus-monitor.c is GPL-2, rest is LGPL-2
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/libpcap
		sys-apps/dbus
		x11-libs/cairo
		x11-libs/pango
		gnome-base/libglade:2.0"
DEPEND="${RDEPEND}
		dev-haskell/binary
		>=dev-haskell/cabal-1.8
		dev-haskell/cairo
		=dev-haskell/dbus-core-0.9*
		dev-haskell/glade
		dev-haskell/glib
		>dev-haskell/gtk-0.11
		dev-haskell/mtl
		dev-haskell/pango
		dev-haskell/parsec
		dev-haskell/pcap
		dev-haskell/text
		>=dev-lang/ghc-6.10.1
		test? (
			dev-haskell/gtk
			dev-haskell/hunit
			dev-haskell/quickcheck
			dev-haskell/test-framework
			dev-haskell/test-framework-hunit
		)
"

src_configure() {
	cabal_src_configure $(use test && use_enable test tests) #395351
}

src_compile() {
	# compile haskell part
	cabal_src_compile || die "could not build haskell parts"

	# compile C part
	emake \
		"CC=$(tc-getCC)" \
		"CFLAGS=${CFLAGS}" \
		"CPPFLAGS=${CPPFLAGS}" \
		"LDFLAGS=${LDFLAGS}"
}

src_install() {
	# install haskell part
	cabal_src_install || die "could not install haskell parts"

	dobin "${S}"/dist/build/bustle-pcap

	dodoc README HACKING NEWS
}
