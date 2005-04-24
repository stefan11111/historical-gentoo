# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-glib2/ruby-glib2-0.10.1.ebuild,v 1.4 2005/04/24 10:15:35 blubb Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Glib2 bindings"
KEYWORDS="alpha x86 ppc ia64 ~sparc amd64"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="${DEPEND} >=dev-libs/glib-2"
RDEPEND="${RDEPEND} >=dev-libs/glib-2"
