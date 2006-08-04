# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Getopt-Long/Getopt-Long-2.35.ebuild,v 1.6 2006/08/04 13:26:19 mcummings Exp $

inherit perl-module

DESCRIPTION="Advanced handling of command line options"
SRC_URI="mirror://cpan/authors/id/J/JV/JV/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JV/JV/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ~ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND="virtual/perl-PodParser
		dev-lang/perl"
