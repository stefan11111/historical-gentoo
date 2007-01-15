# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Geography-Countries/Geography-Countries-1.4.ebuild,v 1.15 2007/01/15 22:25:27 mcummings Exp $

inherit perl-module

DESCRIPTION="2-letter, 3-letter, and numerical codes for countries."
SRC_URI="mirror://cpan/authors/id/A/AB/ABIGAIL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~abigail/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 hppa ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
