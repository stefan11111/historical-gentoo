# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/frescobaldi/frescobaldi-2.0.4.ebuild,v 1.1 2012/03/13 10:35:43 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A LilyPond sheet music text editor"
HOMEPAGE="http://www.frescobaldi.org/"
SRC_URI="mirror://github/wbsoft/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="portmidi"

RDEPEND="dev-python/python-poppler-qt4
	dev-python/PyQt4
	>=media-sound/lilypond-2.14.2
	portmidi? ( media-libs/portmidi )"
DEPEND=${RDEPEND}
