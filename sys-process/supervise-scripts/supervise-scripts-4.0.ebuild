# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/supervise-scripts/supervise-scripts-4.0.ebuild,v 1.7 2011/02/27 13:51:48 ranger Exp $

EAPI="2"

DESCRIPTION="Starting and stopping daemontools managed services"
HOMEPAGE="http://untroubled.org/supervise-scripts/"
SRC_URI="http://untroubled.org/supervise-scripts/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="doc"

RDEPEND="virtual/daemontools"
DEPEND="${RDEPEND}"

src_prepare() {
	echo "/usr/bin" > conf-bin
	echo "/usr/share/man" > conf-man
}

src_install() {
	emake PREFIX="${D}" install || die "Install failed"
	use doc && dohtml *.html
}
