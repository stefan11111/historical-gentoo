# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/gnupg/gnupg-2.1.ebuild,v 1.1 2011/08/11 07:25:35 radhermit Exp $

EAPI=4

inherit vim-plugin

MY_PN="${PN}.vim"
DESCRIPTION="vim plugin: transparent editing of gpg encrypted files"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3645"
SRC_URI="https://github.com/vim-scripts/${MY_PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-crypt/gnupg"

VIM_PLUGIN_HELPFILES="${PN}.txt"

src_unpack() {
	unpack ${A}
	mv *-${MY_PN}-* "${S}"
}

src_prepare() {
	# There's good documentation included with the script, but it's not
	# in a helpfile. Since there's rather too much information to include
	# in a VIM_PLUGIN_HELPTEXT, we'll sed ourselves a help doc.
	mkdir doc
	sed -e '/" Section: Plugin header.\+$/,9999d' -e 's/^" \?//' \
		-e 's/\(Name:\s\+\)\([^.]\+\)\.vim/\1*\2.txt*/' \
		plugin/${PN}.vim \
		> doc/${PN}.txt

	rm -f README
}
