# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-file/libopensync-plugin-file-9999.ebuild,v 1.2 2009/11/15 22:34:30 eva Exp $

EAPI="2"

inherit cmake-utils subversion

DESCRIPTION="OpenSync File Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/plugins/file-sync"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

RDEPEND="=app-pda/libopensync-${PV}*
	dev-libs/glib:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}"