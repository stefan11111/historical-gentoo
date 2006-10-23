# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/vim-core-7.0.146.ebuild,v 1.1 2006/10/23 02:52:48 pioto Exp $

inherit vim

VIM_VERSION="7.0"
VIM_SNAPSHOT="vim-7.0-r1.tar.bz2"
VIM_GENTOO_PATCHES="vim-7.0-gentoo-patches-r1.tar.bz2"
VIM_ORG_PATCHES="vim-patches-${PV}.tar.gz"
VIMRC_FILE_SUFFIX="-r3"

SRC_URI="${SRC_URI}
	mirror://gentoo/${VIM_SNAPSHOT}
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}"

S=${WORKDIR}/vim${VIM_VERSION/.*}
DESCRIPTION="vim and gvim shared files"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""
DEPEND="${DEPEND}"
PDEPEND="!livecd? ( app-vim/gentoo-syntax )"
