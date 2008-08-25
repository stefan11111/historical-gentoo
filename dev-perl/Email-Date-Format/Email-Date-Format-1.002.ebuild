# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Date-Format/Email-Date-Format-1.002.ebuild,v 1.5 2008/08/25 14:53:18 armin76 Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Produce RFC 822 date strings"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		>=dev-perl/Test-Pod-Coverage-1.0.8 )"

SRC_TEST=do
