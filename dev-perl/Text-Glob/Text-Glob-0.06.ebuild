# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Glob/Text-Glob-0.06.ebuild,v 1.2 2004/03/20 10:17:44 kumba Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Match globbing patterns against text"
SRC_URI="http://www.cpan.org/modules/by-authors/id/R/RC/RCLAMP/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RC/RCLAMP/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~alpha ~hppa ~ppc ~sparc ~mips"

DEPEND="dev-perl/Test-Simple"

