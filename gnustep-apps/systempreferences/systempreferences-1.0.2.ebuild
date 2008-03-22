# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/systempreferences/systempreferences-1.0.2.ebuild,v 1.3 2008/03/22 18:28:29 coldwind Exp $

inherit gnustep-2

MY_P=SystemPreferences-${PV}
DESCRIPTION="System Preferences is a clone of Apple OS X' System Preferences"
HOMEPAGE="http://www.gnustep.it/enrico/system-preferences/"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/usr-apps/${MY_P}.tar.gz"

KEYWORDS="amd64 ~ppc x86"
LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${MY_P}
