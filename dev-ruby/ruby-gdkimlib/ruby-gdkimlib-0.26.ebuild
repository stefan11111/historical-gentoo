# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdkimlib/ruby-gdkimlib-0.26.ebuild,v 1.1 2002/01/21 14:50:40 agriffis Exp $

S=${WORKDIR}/ruby-gnome-${PV}/gdkimlib
DESCRIPTION="Ruby GdkImlib bindings"
SRC_URI="http://prdownloads.sourceforge.net/ruby-gnome/ruby-gnome-${PV}.tar.gz"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"

DEPEND=">=dev-lang/ruby-1.6.4-r1
		>=x11-libs/gtk+-1.2.10-r4
		>=dev-ruby/ruby-gtk-${PV}"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	emake || die "emake failed"
}

src_install () {
	make site-install DESTDIR=${D}
	dodoc [A-Z]*
	cp -dr sample ${D}/usr/share/doc/${PF}
}
