# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE/POE-0.30.09.ebuild,v 1.2 2005/05/22 02:17:52 mcummings Exp $

IUSE="gtk ipv6 libwww ncurses tcltk"

inherit perl-module
MY_PV=${PV/30.09/3009}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A framework for creating multitasking programs in Perl"
HOMEPAGE="http://poe.perl.org"
HOMEPAGE="http://search.cpan.org/~rcaputo/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/R/RC/RCAPUTO/${MY_P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~sparc"

DEPEND="${DEPEND}
	dev-perl/ExtUtils-AutoInstall
	>=dev-perl/Event-1.00
	>=dev-perl/Time-HiRes-1.59
	>=dev-perl/Compress-Zlib-1.33
	>=dev-perl/Storable-2.12
	>=dev-perl/IO-Tty-1.02
	dev-perl/Filter
	dev-perl/FreezeThaw
	>=dev-perl/Test-Simple-0.54
	>=dev-perl/TermReadKey-2.21
	ipv6? ( >=dev-perl/Socket6-0.14 )
	tcltk? ( >=dev-perl/perl-tk-800.027 )
	gtk? ( >=dev-perl/gtk-perl-0.7009 )
	libwww? ( >=dev-perl/libwww-perl-5.79
		>=dev-perl/URI-1.30)
	ncurses? ( >=dev-perl/Curses-1.08 )"

mymake="/usr"

src_compile() {
	echo "n" | perl-module_src_compile
}
