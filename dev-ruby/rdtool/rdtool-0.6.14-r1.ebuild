# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdtool/rdtool-0.6.14-r1.ebuild,v 1.13 2005/04/24 10:13:14 blubb Exp $

IUSE="emacs"

inherit ruby elisp-common

DESCRIPTION="A multipurpose documentation format for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=rdtool"
SRC_URI="http://www2.pos.to/~tosh/ruby/rdtool/archive/${P}.tar.gz"
LICENSE="Ruby GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc alpha ppc amd64 ppc64"

USE_RUBY="any"

DEPEND="|| ( >=dev-lang/ruby-1.8.0
	( ~dev-lang/ruby-1.6.8 dev-ruby/shim-ruby18 )
		dev-lang/ruby-cvs )
	dev-ruby/amstd
	emacs? ( virtual/emacs )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:^BIN_DIR = :&$(DESTDIR):' \
	       -e 's:^SITE_RUBY = :&$(DESTDIR):' rdtoolconf.rb \
		|| die "sed failed"
	mv rdtoolconf.rb extconf.rb
}

src_install() {
	dodir /usr/bin
	ruby_src_install

	if use emacs ; then
		elisp-install . utils/rd-mode.el
		elisp-site-file-install ${FILESDIR}/50rdtool-gentoo.el
	fi
}

pkg_postinst() {

	use emacs && elisp-site-regen
}

pkg_postrm() {

	use emacs && elisp-site-regen
}
