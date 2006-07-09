# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doxygen/doxygen-1.4.7.ebuild,v 1.2 2006/07/09 22:56:19 nerdboy Exp $

inherit eutils toolchain-funcs qt3

DESCRIPTION="Doxygen is a documentation system for C++, C, Java, Objective-C,
	Python, IDL , and other C-like languages."
HOMEPAGE="http://www.doxygen.org/"
SRC_URI="ftp://ftp.stack.nl/pub/users/dimitri/${P}.src.tar.gz"
#		unicode? ( mirror://gentoo/${PN}-utf8-ru.patch.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc qt3 tetex"

RDEPEND=">=media-gfx/graphviz-2.6
	qt? ( $(qt_min_version 3.3) )
	tetex? ( virtual/tetex )
	virtual/ghostscript"
DEPEND=">=sys-apps/sed-4
	${RDEPEND}"

EPATCH_SUFFIX="patch"

src_unpack() {
	unpack ${A}
	cd ${S}
	# use CFLAGS, CXXFLAGS, LDFLAGS
	sed -i.orig -e 's:^\(TMAKE_CFLAGS_RELEASE\t*\)= .*$:\1= $(ECFLAGS):' \
		-e 's:^\(TMAKE_CXXFLAGS_RELEASE\t*\)= .*$:\1= $(ECXXFLAGS):' \
		-e 's:^\(TMAKE_LFLAGS_RELEASE\s*\)=.*$:\1= $(ELDFLAGS):' \
		tmake/lib/{{linux,freebsd,netbsd,openbsd,solaris}-g++,macosx-c++}/tmake.conf

	# Consolidate patches, apply FreeBSD configure patch, codepage patch,
	# qtools stuff, and patches for bugs 129142, 121770, and 129560.
	epatch ${FILESDIR}/${PV}
}

src_compile() {
	export ECFLAGS="${CFLAGS}" ECXXFLAGS="${CXXFLAGS}" ELDFLAGS="${LDFLAGS}"
	# set ./configure options (prefix, Qt based wizard, docdir)
	local my_conf="--prefix ${D}usr"
	if use qt; then
	    einfo "using QTDIR: '$QTDIR'."
	    export LD_LIBRARY_PATH=${QTDIR}/$(get_libdir):${LD_LIBRARY_PATH}
	    export LIBRARY_PATH=${QTDIR}/$(get_libdir):${LIBRARY_PATH}
	    einfo "using QT LIBRARY_PATH: '$LIBRARY_PATH'."
	    einfo "using QT LD_LIBRARY_PATH: '$LD_LIBRARY_PATH'."
	    ./configure ${my_conf} $(use_with qt doxywizard) || die 'configure failed'
	else
	    ./configure ${my_conf} || die 'configure failed'
	fi

	# and compile
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINK="$(tc-getCXX)" \
	    LINK_SHLIB="$(tc-getCXX)" all || die 'emake failed'

	# generate html and pdf (if tetex in use) documents.
	# errors here are not considered fatal, hence the ewarn message
	# TeX's font caching in /var/cache/fonts causes sandbox warnings,
	# so we allow it.
	if use doc; then
		if use tetex; then
			addwrite /var/cache/fonts
			addwrite /usr/share/texmf/fonts/pk
			addwrite /usr/share/texmf/ls-R
			make pdf || ewarn '"make pdf docs" failed.'
		else
			cp doc/Doxyfile doc/Doxyfile.orig
			cp doc/Makefile doc/Makefile.orig
			sed -i.orig -e "s/GENERATE_LATEX    = YES/GENERATE_LATEX    = NO/" doc/Doxyfile
			sed -i.orig -e "s/@epstopdf/# @epstopdf/" \
				-e "s/@cp Makefile.latex/# @cp Makefile.latex/" \
				-e "s/@sed/# @sed/" doc/Makefile
			make docs || ewarn '"make html docs" failed.'
		fi
	fi
}

src_install() {
	make DESTDIR=${D} MAN1DIR=share/man/man1 \
		install || die '"make install" failed.'

	dodoc INSTALL LANGUAGE.HOWTO README

	# pdf and html manuals
	if use doc; then
		insinto /usr/share/doc/${PF}
		if use tetex; then
			doins latex/doxygen_manual.pdf
		fi
		dohtml -r html/*
	fi
}

pkg_postinst() {

	einfo
	einfo "The USE flags qt, doc, and tetex will enable doxywizard, or"
	einfo "the html and pdf documentation, respectively.  For examples"
	einfo "and other goodies, see the source tarball.  For some example"
	einfo "output, run doxygen on the doxygen source using the Doxyfile"
	einfo "provided in the top-level source dir."
	einfo
	einfo "See the Doxygen homepage for additional language support tools."
	einfo
}
