# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkworkspace/libkworkspace-4.1.2-r1.ebuild,v 1.1 2008/11/09 13:40:34 scarabeus Exp $

EAPI="2"

KMNAME=kdebase-workspace
KMMODULE=libs/kworkspace
KMSAVELIBS="true"
inherit kde4-meta

DESCRIPTION="A library for KDE desktop applications"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

KMEXTRA="cmake"
KMEXTRACTONLY="ksmserver/org.kde.KSMServerInterface.xml
	kwin/org.kde.KWin.xml"
KMSAVELIBS="true"

src_prepare() {
	# install cmake modules here
	sed -i \
		-e "s/^#DONOTINSTALL //" \
		cmake/modules/CMakeLists.txt || die "sed failed"
}
