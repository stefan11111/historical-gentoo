# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/yap/yap-6.2.0-r1.ebuild,v 1.11 2010/12/21 05:35:00 keri Exp $

inherit autotools eutils flag-o-matic java-pkg-opt-2

PATCHSET_VER="4"

DESCRIPTION="YAP is a high-performance Prolog compiler."
HOMEPAGE="http://www.ncc.up.pt/~vsc/Yap/"
SRC_URI="http://www.ncc.up.pt/~vsc/Yap/${P}.tar.gz
	mirror://gentoo/${P}-gentoo-patchset-${PATCHSET_VER}.tar.gz"

LICENSE="Artistic LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="debug doc examples gmp java mpi mysql odbc readline static threads"

RDEPEND="sys-libs/zlib
	gmp? ( dev-libs/gmp )
	java? ( >=virtual/jdk-1.4 )
	mpi? ( virtual/mpi )
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	readline? ( sys-libs/readline )"

DEPEND="${RDEPEND}
	doc? ( app-text/texi2html )"

S="${WORKDIR}"/${PN}-6

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_FORCE=yes
	EPATCH_SUFFIX=patch
	epatch "${WORKDIR}"/${PV}

	eautoconf
}

src_compile() {
	append-flags -fno-strict-aliasing

	local myddas_conf
	if use mysql || use odbc; then
		myddas_conf="--enable-myddas \
				--enable-myddas-stats \
				--enable-myddas-top-level"
	else
		myddas_conf="--disable-myddas"
	fi

	econf \
		--libdir=/usr/$(get_libdir) \
		$(use_enable !static dynamic-loading) \
		$(use_enable threads) \
		$(use_enable threads pthread-locking) \
		$(use_enable debug debug-yap) \
		$(use_enable debug low-level-tracer) \
		$(use_with gmp) \
		$(use_with readline) \
		$(use_with mpi) \
		$(use_with mpi mpe) \
		$(use_with java) \
		${myddas_conf}

	emake || die "emake failed"

	if use doc ; then
		emake html || die "emake html failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed."

	dodoc changes*.html README || die

	if use doc ; then
		dodoc yap.html || die
	fi

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples/chr
		doins packages/chr/Examples/* || die
		insinto /usr/share/doc/${PF}/examples/clib
		doins packages/clib/demo/* || die
		insinto /usr/share/doc/${PF}/examples/http
		doins -r packages/http/examples/* || die
		insinto /usr/share/doc/${PF}/examples/plunit
		doins packages/plunit/examples/* || die
		if use java ; then
			insinto /usr/share/doc/${PF}/examples/jpl/prolog
			doins packages/jpl/examples/prolog/* || die
			insinto /usr/share/doc/${PF}/examples/jpl/java
			doins packages/jpl/examples/java/README || die
			doins -r packages/jpl/examples/java/*/*.{java,pl} || die
		fi
		if use mpi ; then
			insinto /usr/share/doc/${PF}/examples/mpi
			doins library/mpi/examples/*.pl || die
		fi
	fi
}
