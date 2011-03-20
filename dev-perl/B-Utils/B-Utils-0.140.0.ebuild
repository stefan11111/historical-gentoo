# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Utils/B-Utils-0.140.0.ebuild,v 1.1 2011/03/20 07:36:02 tove Exp $

EAPI=3

MODULE_AUTHOR=JJORE
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION="Helper functions for op tree manipulation"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=">=dev-perl/extutils-depends-0.301"

SRC_TEST=do
