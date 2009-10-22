# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mouse/Mouse-0.40.ebuild,v 1.1 2009/10/22 13:26:33 tove Exp $

EAPI=2

MODULE_AUTHOR=GFUJI
inherit perl-module

DESCRIPTION="Moose minus the antlers"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~x86"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Sub-Uplevel
	dev-perl/Test-Exception
	>=virtual/perl-Test-Simple-0.88 )"

SRC_TEST=do
