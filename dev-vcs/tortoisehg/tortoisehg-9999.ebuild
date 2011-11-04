# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/tortoisehg/tortoisehg-9999.ebuild,v 1.1 2011/11/04 19:17:08 floppym Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils eutils mercurial multilib

DESCRIPTION="Set of graphical tools for Mercurial"
HOMEPAGE="http://tortoisehg.bitbucket.org"
SRC_URI=""
EHG_REPO_URI="https://bitbucket.org/tortoisehg/thg"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc nautilus"

RDEPEND="dev-python/iniparse
	dev-python/pygments
	dev-python/PyQt4
	dev-python/qscintilla-python
	>=dev-vcs/mercurial-1.9
	nautilus? ( dev-python/nautilus-python )"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-1.0.3 )"

src_prepare() {
	# make the install respect multilib.
	sed -i -e "s:lib/nautilus:$(get_libdir)/nautilus:" setup.py || die

	distutils_src_prepare
}

src_compile() {
	distutils_src_compile

	if use doc ; then
		emake -C doc html
	fi
}

src_install() {
	distutils_src_install
	dodoc doc/ReadMe*.txt doc/TODO

	if use doc ; then
		dohtml -r doc/build/html || die
	fi

	insinto /usr/share/icons/hicolor/scalable/apps
	newins icons/scalable/apps/thg-logo.svg tortoisehg_logo.svg
	domenu contrib/${PN}.desktop

	if ! use nautilus; then
		rm -r "${ED}usr/$(get_libdir)/nautilus" || die
	fi
}
