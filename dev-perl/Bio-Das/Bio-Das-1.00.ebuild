# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Das/Bio-Das-1.00.ebuild,v 1.3 2005/05/25 14:08:47 mcummings Exp $

inherit perl-module


DESCRIPTION="Interface to Distributed Annotation System"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~lds/${P}/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~ppc ~sparc"

SRC_TEST="do"

DEPEND=">=dev-perl/Compress-Zlib-1.0
	sci-biology/bioperl
	>=dev-perl/HTML-Parser-3
	>=dev-perl/libwww-perl-5
	>=perl-core/MIME-Base64-2.12"
