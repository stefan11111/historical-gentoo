# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tkabber/tkabber-0.9.3b-r1.ebuild,v 1.9 2004/05/24 02:39:10 rizzo Exp $

DESCRIPTION="Featurefull Jabber client for tcl/tk."
HOMEPAGE="http://tkabber.jabber.ru/"
IUSE="crypt ssl"

DEPEND=">=dev-lang/tcl-8.3*
	>=dev-lang/tk-8.3*
	dev-tcltk/tclxml-expat
	crypt? ( >=dev-tcltk/tclgpgme-1.0 )
	>=dev-tcltk/tcllib-1.3
	>=dev-tcltk/bwidget-1.3
	ssl? ( >=dev-tcltk/tls-1.4.1 )
	>=dev-tcltk/tkXwin-1.0
	>=dev-tcltk/tkTheme-1.0"

LICENSE="GPL-2"
KEYWORDS="x86"

SLOT="0"

MY_P="$(echo ${P}|sed 's/b$/beta/')"
SRC_URI="http://www.jabber.ru/projects/tkabber/tkabber-0.9beta/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

src_install() {
	make DESTDIR=${D} PREFIX=/usr install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README
	dohtml README.html
}
