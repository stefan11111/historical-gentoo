# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MethodMaker/Class-MethodMaker-1.11.ebuild,v 1.13 2006/08/04 23:29:44 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl module for Class::MethodMaker"
HOMEPAGE="http://search.cpan.org/author/FLUFFY/${P}"
SRC_URI="mirror://cpan/authors/id/F/FL/FLUFFY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa ia64 amd64"
IUSE=""

DEPEND=">=dev-perl/module-build-0.28
	dev-lang/perl"
RDEPEND="${DEPEND}"
