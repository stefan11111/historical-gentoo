# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmerlin/kmerlin-1.3_beta3.ebuild,v 1.4 2003/09/06 00:00:56 msterret Exp $
inherit kde-base

need-kde 3.1 # uses kpassivepopup.h

IUSE=""
MY_P=${P/_b/B}
DESCRIPTION="KDE MSN Messenger"
SRC_URI="mirror://sourceforge/kmerlin/${MY_P}.tar.bz2"
HOMEPAGE="http://kmerlin.olsd.de"
S=${WORKDIR}/${MY_P}
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

PATCHES="${FILESDIR}/${P}-docbook.diff" # close bug #14285
