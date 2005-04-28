# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Locale-gettext/Locale-gettext-1.04.ebuild,v 1.2 2005/04/28 21:53:48 mcummings Exp $

inherit perl-module

MY_P="gettext-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Perl module for accessing the GNU locale utilities"
HOMEPAGE="http://search.cpan.org/~pvandry/${P}/"
SRC_URI="mirror://cpan/authors/id/P/PV/PVANDRY/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND="sys-devel/gettext
		>=dev-perl/Test-Simple-0.54"

# Disabling the tests - not ready for prime time - mcummings
#SRC_TEST="do"
