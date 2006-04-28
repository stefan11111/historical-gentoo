# Copyright 1999-2006 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/documancer/documancer-0.2.6.ebuild,v 1.1 2006/04/28 22:23:17 halcy0n Exp $

inherit eutils

IUSE=""
DESCRIPTION="Programmer's documentation reader with very fast fulltext searching"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://documancer.sourceforge.net"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
RDEPEND=">=x11-libs/wxmozilla-0.5.6
	>=virtual/python-2.3
	>=dev-python/wxpython-2.6.3
	|| ( dev-python/pylucene virtual/jre )
	dev-lang/perl"

pkg_setup () {
	# Note: can't use "python_mod_exists wxPython.mozilla" here because
	#       it doesn't work (some strange import stuff in wxPython)
	if ! built_with_use wxmozilla python; then
		eerror "you need wxmozilla compiled with Python module:"
		eerror "echo \"x11-libs/wxmozilla python\" >> /etc/portage/package.use"
		eerror "and then emerge wxmozilla"
		die "Need wxMozilla compiled with Python module!"
	fi
}

src_install () {
	make install DESTDIR=${D} || die

	dodoc AUTHORS FAQ NEWS README TODO
}
