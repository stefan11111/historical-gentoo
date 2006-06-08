# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-chdir/File-chdir-0.06.ebuild,v 1.6 2006/06/08 21:17:09 dertobi123 Exp $

inherit perl-module

DESCRIPTION="An alternative to File::Spec and CWD"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"
