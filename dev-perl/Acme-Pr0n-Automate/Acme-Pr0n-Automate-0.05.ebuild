# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Acme-Pr0n-Automate/Acme-Pr0n-Automate-0.05.ebuild,v 1.1 2002/11/21 01:16:45 mkennedy Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Acme-Pr0n-Automate module for perl"
SRC_URI="http://cpan.org/modules/by-module/Acme/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Acme/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="${DEPEND}"

export OPTIMIZE="$CFLAGS"
