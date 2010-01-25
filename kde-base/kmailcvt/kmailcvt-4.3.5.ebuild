# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmailcvt/kmailcvt-4.3.5.ebuild,v 1.1 2010/01/25 16:13:58 scarabeus Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KMail Import Filters"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="
	kmail/
"
