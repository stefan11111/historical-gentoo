# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-SSL/IO-Socket-SSL-1.32.ebuild,v 1.1 2010/02/23 15:43:21 tove Exp $

EAPI=2

MODULE_AUTHOR=SULLR
inherit perl-module

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="idn"

DEPEND=">=dev-perl/Net-SSLeay-1.33
	virtual/perl-Scalar-List-Utils
	idn? ( dev-perl/Net-LibIDN )"
RDEPEND="${DEPEND}"

SRC_TEST="do"
