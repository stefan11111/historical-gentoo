# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/udev-syntax/udev-syntax-20051016.ebuild,v 1.1 2005/10/16 01:54:53 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: syntax highlighting for udev rules files"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1381"
LICENSE="vim"
KEYWORDS="~sparc ~mips"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for udev.rules files. These files
are automatically detected by filename; manual loading is also possible,
via :set filetype=udev"

