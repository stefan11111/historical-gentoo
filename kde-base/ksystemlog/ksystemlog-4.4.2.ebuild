# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystemlog/ksystemlog-4.4.2.ebuild,v 1.1 2010/03/30 21:39:19 spatz Exp $

EAPI="3"

KMNAME="kdeadmin"

inherit kde4-meta

DESCRIPTION="KDE system log viewer"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

# Tests hang, last checked in 4.3.3
RESTRICT="test"
