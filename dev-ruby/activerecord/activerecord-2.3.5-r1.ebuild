# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activerecord/activerecord-2.3.5-r1.ebuild,v 1.2 2010/01/04 11:00:38 fauli Exp $

EAPI=2
USE_RUBY="ruby18"

# this is not null so that the dependencies will actually be filled
RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="Implements the ActiveRecord pattern (Fowler, PoEAA) for ORM"
HOMEPAGE="http://rubyforge.org/projects/activerecord/"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="~amd64 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="mysql postgres sqlite3" #sqlite

ruby_add_rdepend "~dev-ruby/activesupport-${PV}"
#ruby_add_rdepend sqlite ">=dev-ruby/sqlite-ruby-2.2.2"
ruby_add_rdepend sqlite3 "dev-ruby/sqlite3-ruby"
ruby_add_rdepend mysql ">=dev-ruby/mysql-ruby-2.7"
ruby_add_rdepend postgres "dev-ruby/pg"
ruby_add_bdepend test ">=dev-ruby/mocha-0.9.5 virtual/ruby-test-unit"

all_ruby_prepare() {
	# Custom template not found in package
	sed -i -e '/horo/d' Rakefile || die
}

each_ruby_test() {
	if use sqlite3; then
		${RUBY} -S rake test_sqlite3 || die "sqlite3 tests failed"
	fi
#
#	if use sqlite; then
#		${RUBY} -S rake test_sqlite || die "sqlite3 tests failed"
#	fi
}
