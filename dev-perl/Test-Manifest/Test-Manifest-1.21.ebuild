# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Manifest/Test-Manifest-1.21.ebuild,v 1.7 2012/03/25 17:10:23 armin76 Exp $

inherit perl-module

DESCRIPTION="Interact with a t/test_manifest file"
SRC_URI="mirror://cpan/authors/id/B/BD/BDFOY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~bdfoy/${P}/"

IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~arm ppc ppc64 x86 ~x86-fbsd"

SRC_TEST="do"

DEPEND="dev-lang/perl"
