# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-4.4.2-r1.ebuild,v 1.1 2010/04/09 04:00:09 tampakrap Exp $

EAPI="3"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug pam"

DEPEND="
	pam? (
		>=kde-base/kdebase-pam-7
		virtual/pam
	)
"
RDEPEND="${DEPEND}"

PATCHES=(
		"${FILESDIR}/kdebase-4.0.2-pam-optional.patch"
		"${FILESDIR}/${P}-no-SUID-no-GUID.patch"
		)

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with pam)
	)

	kde4-meta_src_configure
}
