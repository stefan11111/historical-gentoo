# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Address/Email-Address-1.895.0.ebuild,v 1.5 2012/05/06 20:24:56 ranger Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.895
inherit perl-module

DESCRIPTION="RFC 2822 Address Parsing and Creation"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Simple
		>=dev-perl/Test-Pod-1.14
		>=dev-perl/Test-Pod-Coverage-1.08
	)"

SRC_TEST="do"
