# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-5.1-r2.ebuild,v 1.5 2005/12/24 17:31:32 solar Exp $

inherit eutils multilib toolchain-funcs

# Official patches
# See ftp://ftp.cwru.edu/pub/bash/readline-5.1-patches/
PLEVEL=1

DESCRIPTION="Another cute console display library"
HOMEPAGE="http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html"
SRC_URI="mirror://gnu/readline/${P}.tar.gz
	$(for ((i=1; i<=PLEVEL; i++)); do
		printf 'ftp://ftp.cwru.edu/pub/bash/readline-%s-patches/readline%s-%03d\n' \
			${PV} ${PV/\.} ${i}
		printf 'mirror://gnu/bash/readline-%s-patches/readline%s-%03d\n' \
			${PV} ${PV/\.} ${i}
	done)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

# We must be certain that we have a bash that is linked
# to its internal readline, else we may get problems.
RDEPEND=">=sys-libs/ncurses-5.2-r2"
DEPEND="${RDEPEND}
	>=app-shells/bash-2.05b-r2"

src_unpack() {
	unpack ${P}.tar.gz

	cd "${S}"
	# Official patches
	local i
	for ((i=1; i<=PLEVEL; i++)); do
		epatch "${DISTDIR}"/${PN}${PV/\.}-$(printf '%03d' ${i})
	done
	epatch "${FILESDIR}"/bash-3.0-etc-inputrc.patch
	epatch "${FILESDIR}"/${PN}-5.0-no_rpath.patch
	epatch "${FILESDIR}"/${P}-cleanups.patch
	epatch "${FILESDIR}"/${P}-rlfe-build.patch #116483
	epatch "${FILESDIR}"/${P}-rlfe-uclibc.patch

	ln -s ../.. examples/rlfe/readline

	# force ncurses linking #71420
	sed -i -e 's:^SHLIB_LIBS=:SHLIB_LIBS=-lncurses:' support/shobj-conf || die "sed"
}

src_compile() {
	# the --libdir= is needed because if lib64 is a directory, it will default
	# to using that... even if CONF_LIBDIR isnt set or we're using a version
	# of portage without CONF_LIBDIR support.
	econf --with-curses --libdir=/usr/$(get_libdir) || die
	emake || die

	cd examples/rlfe
	econf || die
	emake || die "make rlfe failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodir /$(get_libdir)

	if ! use userland_Darwin ; then
		mv "${D}"/usr/$(get_libdir)/*.so* "${D}"/$(get_libdir)
		chmod a+rx "${D}"/$(get_libdir)/*.so*

		# Bug #4411
		gen_usr_ldscript libreadline.so
		gen_usr_ldscript libhistory.so
	fi

	if ! tc-is-cross-compiler; then
		dobin examples/rlfe/rlfe || die
	fi

	dodoc CHANGELOG CHANGES README USAGE NEWS
	docinto ps
	dodoc doc/*.ps
	dohtml -r doc
}

pkg_preinst() {
	# Backwards compatibility #29865
	if [[ -e ${ROOT}/$(get_libdir)/libreadline.so.4 ]] ; then
		cp -pPR "${ROOT}"/$(get_libdir)/libreadline.so.4* "${D}"/$(get_libdir)/
		touch "${D}"/$(get_libdir)/libreadline.so.4*
	fi
}

pkg_postinst() {
	if [[ -e ${ROOT}/$(get_libdir)/libreadline.so.4 ]] ; then
		ewarn "Your old readline libraries have been copied over."
		ewarn "You should run 'revdep-rebuild --soname libreadline.so.4' asap."
		ewarn "Once you have, you can safely delete /$(get_libdir)/libreadline.so.4*"
	fi
}
