# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-ContextualFetch/DBIx-ContextualFetch-1.01.ebuild,v 1.3 2004/06/08 12:13:51 dholm Exp $

inherit perl-module

DESCRIPTION="Add contextual fetches to DBI"
HOMEPAGE="http://search.cpan.org/~tmtm/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc"
SRC_TEST="do"

DEPEND=">=dev-perl/DBI-1.37
		dev-perl/DBD-SQLite
		dev-perl/Test-Simple"
