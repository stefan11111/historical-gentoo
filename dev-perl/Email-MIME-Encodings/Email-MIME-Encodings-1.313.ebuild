# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Encodings/Email-MIME-Encodings-1.313.ebuild,v 1.5 2009/09/19 16:12:37 nixnut Exp $

EAPI=2

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="A unified interface to MIME encoding and decoding"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 ~sparc x86"
IUSE="test"

RDEPEND=">=virtual/perl-MIME-Base64-3.07"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
