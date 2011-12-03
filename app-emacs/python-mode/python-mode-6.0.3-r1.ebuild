# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/python-mode/python-mode-6.0.3-r1.ebuild,v 1.2 2011/12/03 23:47:54 ulm Exp $

EAPI=4

inherit elisp

MY_P="${PN}.el-${PV}"
DESCRIPTION="An Emacs major mode for editing Python source"
HOMEPAGE="https://launchpad.net/python-mode"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

S="${WORKDIR}/${MY_P}"
ELISP_PATCHES="${P}-obsolete-vars.patch"
# remove XEmacs specific file
ELISP_REMOVE="highlight-indentation.el"
SITEFILE="50${PN}-gentoo.el"
DOCS="NEWS"

pkg_postinst() {
	elisp-site-regen
	elog "Note that doctest support is split out to app-emacs/doctest-mode."
}
