# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/sphinx2/sphinx2-0.6.ebuild,v 1.6 2009/08/21 19:28:36 ssuominen Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="CMU Speech Recognition-engine"
HOMEPAGE="http://fife.speech.cs.cmu.edu/sphinx/"
SRC_URI="mirror://sourceforge/cmusphinx/${P}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README doc/README.bin doc/README.lib doc/SCHMM_format doc/filler.dict doc/phoneset doc/phoneset-old
	dohtml doc/phoneset_s2.html doc/sphinx2.html
}
