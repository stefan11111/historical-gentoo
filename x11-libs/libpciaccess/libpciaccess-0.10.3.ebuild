# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libpciaccess/libpciaccess-0.10.3.ebuild,v 1.4 2008/09/24 08:18:43 aballier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Library providing generic access to the PCI bus and devices"
LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

CONFIGURE_OPTIONS="--with-pciids-path=/usr/share/misc"
