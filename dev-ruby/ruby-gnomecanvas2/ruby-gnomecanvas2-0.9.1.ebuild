# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomecanvas2/ruby-gnomecanvas2-0.9.1.ebuild,v 1.4 2004/06/30 19:59:49 fmccor Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GnomeCanvas2 bindings"
KEYWORDS="~alpha ~x86 ~ppc ~ia64 ~sparc"
USE_RUBY="ruby18 ruby19"	# ruby16 is not supported
DEPEND="${DEPEND} >=gnome-base/libgnomecanvas-2.2"
RDEPEND="${RDEPEND} >=gnome-base/libgnomecanvas-2.2
	>=dev-ruby/ruby-gtk2-${PV}
	>=dev-ruby/ruby-libart2-${PV}"
