# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rest-client/rest-client-1.6.3.ebuild,v 1.1 2011/07/20 06:34:56 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_EXTRADOC="history.md README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Simple Simple HTTP and REST client for Ruby"
HOMEPAGE="http://github.com/archiloque/rest-client"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/jeweler )"
ruby_add_bdepend "test? ( dev-ruby/jeweler dev-ruby/rspec:0 dev-ruby/webmock )"

ruby_add_rdepend ">=dev-ruby/mime-types-1.16"

all_ruby_prepare() {
	# Remove spec that requires network access and is now invalid due to
	# changes in the live service. Also, the certificates needed for
	# this spec are not part of the gem.
	# https://github.com/archiloque/rest-client/issues/82
	rm spec/integration/request_spec.rb || die
}
