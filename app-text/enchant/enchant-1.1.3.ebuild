# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/enchant/enchant-1.1.3.ebuild,v 1.10 2004/07/13 23:02:59 agriffis Exp $

inherit gnome2 gnuconfig

DESCRIPTION="Spellchecker wrapping library"
HOMEPAGE="http://www.abisource.com/enchant/"

SRC_URI="mirror://sourceforge/abiword/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="x86 ~ppc sparc amd64 alpha ~ia64 mips hppa"

IUSE=""
# FIXME : some sort of proper spellchecker selection needed

# The || is meant to make sure there is a a default spell lib to work with
# 25 Aug 2003; foser <foser@gentoo.org>

RDEPEND=">=dev-libs/glib-2
	|| ( virtual/aspell-dict app-text/ispell app-text/hspell )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

#allow to build on mipslinux systems
gnuconfig_update

DOCS="AUTHORS BUGS COPYING.LIB ChangeLog HACKING MAINTAINERS NEWS README TODO"
