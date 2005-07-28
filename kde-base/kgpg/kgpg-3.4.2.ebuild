# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgpg/kgpg-3.4.2.ebuild,v 1.1 2005/07/28 21:16:17 danarmak Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE gpg keyring manager"
KEYWORDS=" ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="$DEPEND
	app-crypt/gnupg"
