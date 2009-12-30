# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mocha/mocha-0.9.8.ebuild,v 1.2 2009/12/30 13:26:43 armin76 Exp $

inherit gems

USE_RUBY="ruby18"

DESCRIPTION="A Ruby library for mocking and stubbing using a syntax like that of JMock, and SchMock"
HOMEPAGE="http://mocha.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

DEPEND="dev-ruby/rake"
RDEPEND="${DEPEND}"
