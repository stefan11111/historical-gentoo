# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Size/Devel-Size-0.69.ebuild,v 1.1 2008/04/08 10:04:31 tove Exp $

inherit perl-module

DESCRIPTION="Perl extension for finding the memory usage of Perl variables"
HOMEPAGE="http://search.cpan.org/~tels/"
SRC_URI="mirror://cpan/authors/id/T/TE/TELS/devel/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""
PREFER_BUILDPL="no"

SRC_TEST="do"

DEPEND="dev-lang/perl"
