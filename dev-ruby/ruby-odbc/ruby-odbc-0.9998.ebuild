# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-odbc/ruby-odbc-0.9998.ebuild,v 1.2 2010/01/29 12:50:03 flameeyes Exp $

EAPI=2

# ruby19 → fails to build
# jruby → uses C extensions
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README ChangeLog"

inherit ruby-fakegem

DESCRIPTION="RubyODBC - For accessing ODBC data sources from the Ruby language"
HOMEPAGE="http://www.ch-werner.de/rubyodbc/"
SRC_URI="http://www.ch-werner.de/rubyodbc/${P}.tar.gz"

LICENSE="|| ( GPL-2 Ruby )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-db/unixODBC-2.0.6"
RDEPEND="${DEPEND}"

# tests require to have an ODBC service enabled, so we can't run them
# for now :(
RESTRICT=test

all_ruby_prepare() {
	# Make sure that it doesn't try to use the absolute-local path for
	# the extension as we'd be unable to run it properly otherwise.
	sed -i -e 's:\./odbc:odbc:' test/{,utf8/}test.rb || die

	# Since lib should not get installed avoid it entirely…
	mv lib contrib || die
}

each_ruby_configure() {
	for dir in ext ext/utf8; do
		${RUBY} -C${dir} extconf.rb || die "extconf (${dir}) failed"
	done
}

each_ruby_compile() {
	for dir in ext ext/utf8; do
		emake -C${dir} || die "emake (${dir}) failed"
	done
}

each_ruby_install() {
	each_fakegem_install

	ruby_fakegem_newins ext/odbc.so lib/odbc.so
	ruby_fakegem_newins ext/utf8/odbc_utf8.so lib/odbc_utf8.so
}

all_ruby_install() {
	all_fakegem_install
	dohtml doc/*.html || die
}
