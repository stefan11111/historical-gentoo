# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PadWalker/PadWalker-1.5.ebuild,v 1.2 2007/04/09 15:38:51 mcummings Exp $

inherit perl-module

DESCRIPTION="play with other peoples' lexical variables"
HOMEPAGE="http://search.cpan.org/~robin/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RO/ROBIN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
