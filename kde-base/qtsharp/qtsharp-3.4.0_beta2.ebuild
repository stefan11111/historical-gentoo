# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qtsharp/qtsharp-3.4.0_beta2.ebuild,v 1.2 2005/02/27 20:21:43 danarmak Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="C# bindings for QT"
KEYWORDS="-*" # broken according to upstream - 3.4a1 README; see also note below
IUSE=""
DEPEND="dev-dotnet/pnet"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

pkg_setup() {
	ewarn "This package is outdated and should be replaced by dev-dotnet/qtsharp,"
	ewarn "except that dev-dotnet/qtsharp doesn't fully work yet (?), so this is still here."
}
