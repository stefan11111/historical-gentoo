# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-polish/texlive-documentation-polish-2011.ebuild,v 1.2 2011/12/28 05:31:01 jer Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="lshort-polish tex-virtual-academy-pl texlive-pl collection-documentation-polish
"
TEXLIVE_MODULE_DOC_CONTENTS="lshort-polish.doc tex-virtual-academy-pl.doc texlive-pl.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit  texlive-module
DESCRIPTION="TeXLive Polish documentation"

LICENSE="GPL-2 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2011
"
RDEPEND="${DEPEND} "
