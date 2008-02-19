# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/alloy/alloy-0.5.2.ebuild,v 1.14 2008/02/19 02:06:30 ingmar Exp $

inherit kde eutils

DESCRIPTION="A neat KDE style based on the Java Alloy Look&Feel from Incors (http://www.incors.com)."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=10605"
SRC_URI="http://www.kde-look.org/content/files/10605-${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="|| ( =kde-base/kwin-3.5* =kde-base/kdebase-3.5 )
	$(qt_min_version 3.3)"
need-kde 3.2

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/remove-extra-semicolon.patch
}
