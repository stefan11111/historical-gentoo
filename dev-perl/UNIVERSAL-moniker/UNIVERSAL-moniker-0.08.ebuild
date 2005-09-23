# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/UNIVERSAL-moniker/UNIVERSAL-moniker-0.08.ebuild,v 1.7 2005/09/23 16:32:33 corsair Exp $

inherit perl-module

DESCRIPTION="adds a moniker to every class or module"
HOMEPAGE="http://search.cpan.org/~kasei/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KA/KASEI/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

#Funny...no longer a dep, but needed for tests
DEPEND="dev-perl/Lingua-EN-Inflect"
