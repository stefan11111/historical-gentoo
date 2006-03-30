# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Memory-Cycle/Test-Memory-Cycle-1.02.ebuild,v 1.7 2006/03/30 23:24:48 agriffis Exp $

inherit perl-module

DESCRIPTION="Check for memory leaks and circular memory references"
HOMEPAGE="http://search.cpan.org/~petdance/${P}/"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Devel-Cycle
	|| ( 	>=virtual/perl-Test-Simple-0.62
		( <virtual/perl-Test-Simple-0.62 dev-perl/Test-Builder-Tester ) )"
