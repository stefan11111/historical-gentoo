# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nautilus-cd-burner-python/nautilus-cd-burner-python-2.24.0.ebuild,v 1.2 2008/10/27 22:51:27 mr_bones_ Exp $

G_PY_PN="gnome-python-desktop"
G_PY_BINDINGS="nautilusburn"

inherit gnome-python-common

DESCRIPTION="Python bindings for Nautilus CD/DVD burning"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=gnome-extra/nautilus-cd-burner-2.15.3
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"

EXAMPLES="examples/nautilusburn/*"
