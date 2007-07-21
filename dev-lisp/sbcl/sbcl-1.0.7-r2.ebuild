# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-1.0.7-r2.ebuild,v 1.2 2007/07/21 10:32:56 hkbst Exp $

inherit common-lisp-common-3 eutils flag-o-matic

#same order as http://www.sbcl.org/platform-table.html
BV_X86=1.0.7
BV_AMD64=1.0.7
BV_PPC=1.0
BV_SPARC=0.9.17
BV_ALPHA=0.9.12
BV_MIPS=0.9.12
BV_MIPSEL=0.9.12

DESCRIPTION="Steel Bank Common Lisp (SBCL) is an implementation of ANSI Common Lisp."
HOMEPAGE="http://sbcl.sourceforge.net/"
SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
	x86? ( mirror://sourceforge/sbcl/${PN}-${BV_X86}-x86-linux-binary.tar.bz2 )
	amd64? ( mirror://sourceforge/sbcl/${PN}-${BV_AMD64}-x86-64-linux-binary.tar.bz2 )
	ppc? ( mirror://sourceforge/sbcl/${PN}-${BV_PPC}-powerpc-linux-binary.tar.bz2 )
	sparc? ( mirror://sourceforge/sbcl/${PN}-${BV_SPARC}-sparc-linux-binary.tar.bz2 )
	alpha? ( mirror://sourceforge/sbcl/${PN}-${BV_ALPHA}-alpha-linux-binary.tar.bz2 )
	mips? ( !cobalt? ( mirror://sourceforge/sbcl/${PN}-${BV_MIPS}-mips-linux-binary.tar.bz2 ) )
	mips? ( cobalt? ( mirror://sourceforge/sbcl/${PN}-${BV_MIPSEL}-mipsel-linux-binary.tar.bz2 ) )
"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE="ldb source threads unicode doc"

DEPEND="doc? ( sys-apps/texinfo )"

PROVIDE="virtual/commonlisp"

pkg_setup() {
	if built_with_use sys-devel/gcc hardened && gcc-config -c | grep -qv vanilla; then
		eerror "So-called \"hardened\" compiler features are incompatible with SBCL. You"
		eerror "must use gcc-config to select a profile with non-hardened features"
		eerror "(the \"vanilla\" profile) and \"source /etc/profile\" before continuing."
		die
	fi
	if (use x86 || use amd64) && has_version "<sys-libs/glibc-2.6" \
		&& ! built_with_use sys-libs/glibc nptl; then
		eerror "Building SBCL without NPTL support on at least x86 and amd64"
		eerror "architectures is not a supported configuration in Gentoo.  Please"
		eerror "refer to Bug #119016 for more information."
		die
	fi
	if use ppc && use ldb; then
		ewarn "Building SBCL on PPC with LDB support is not a supported configuration"
		ewarn "in Gentoo.	Please refer to Bug #121830 for more information."
		ewarn "Continuing with LDB support disabled."
	fi
}

enable_sbcl_feature() {
	echo "(enable $1)" >> "${S}/customize-target-features.lisp"
}

disable_sbcl_feature() {
	echo "(disable $1)" >> "${S}/customize-target-features.lisp"
}

sbcl_apply_features() {
	cat > "${S}/customize-target-features.lisp" <<'EOF'
(lambda (list)
  (flet ((enable (x)
		   (pushnew x list))
		 (disable (x)
		   (setf list (remove x list))))
EOF
	if use x86 || use amd64; then
		use threads && enable_sbcl_feature ":sb-thread"
	fi
	if use ppc && use ldb; then
		ewarn "Excluding LDB support for ppc."
	else
		use ldb && enable_sbcl_feature ":sb-ldb"
	fi
	disable_sbcl_feature ":sb-test"
	! use unicode && disable_sbcl_feature ":sb-unicode"
	cat >> "${S}/customize-target-features.lisp" <<'EOF'
	)
  list)
EOF
}

src_unpack() {
	unpack ${A}
	mv sbcl-*-linux sbcl-binary
	cd "${S}"

#	epatch "${FILESDIR}/disable-tests-gentoo-${PV}.patch"
	use source && sed 's%"$(BUILD_ROOT)%$(MODULE).lisp "$(BUILD_ROOT)%' -i contrib/vanilla-module.mk

	sed "s,/lib,/$(get_libdir),g" -i "${S}/install.sh"
	sed "s,/usr/local/lib,/usr/$(get_libdir),g" -i "${S}/src/runtime/runtime.c" # #define SBCL_HOME ...

	# customizing SBCL version as per
	# http://sbcl.cvs.sourceforge.net/sbcl/sbcl/doc/PACKAGING-SBCL.txt?view=markup
	echo -e ";;; Auto-generated by Gentoo\n\"${PV}-gentoo-${PR}\"" > "${S}/version.lisp-expr"

	# applying customizations
	sbcl_apply_features

	find "${S}" -type f -name .cvsignore -print0 | xargs -0 rm -f
	find "${S}" -depth -type d -name CVS -print0 | xargs -0 rm -rf
	find "${S}" -type f -name \*.c -print0 | xargs -0 chmod 644
}

src_compile() {
	local bindir="${WORKDIR}/sbcl-binary"

	filter-ldflags -Wl,--as-needed --as-needed # see Bug #132992

	# clear the environment to get rid of non-ASCII strings, see bug 174702
	# set HOME for paludis
	env - HOME="${T}" PATH="${bindir}/src/runtime:${PATH}" SBCL_HOME="${bindir}/output" GNUMAKE=make ./make.sh \
		"sbcl --sysinit /dev/null --userinit /dev/null	--disable-debugger --core ${bindir}/output/sbcl.core" \
		|| die "make failed"

	if use doc; then
		cd "${S}/doc/manual"
		make info html || die "make info html failed"
		cd "${S}/doc/internals"
		make html || die "make html failed"
	fi
}

src_test() {
	FILES="exhaust.impure.lisp"
	cd tests
	sh run-tests.sh
#	sh run-tests.sh ${FILES}
#	sh run-tests.sh --break-on-failure ${FILES}
}

src_install() {
	unset SBCL_HOME
	dodir /etc/
	cat > "${D}/etc/sbclrc" <<EOF
;;; The following is required if you want source location functions to
;;; work in SLIME, for example.

(setf (logical-pathname-translations "SYS")
	'(("SYS:SRC;**;*.*.*" #p"/usr/$(get_libdir)/sbcl/src/**/*.*")
	  ("SYS:CONTRIB;**;*.*.*" #p"/usr/$(get_libdir)/sbcl/**/*.*")))
EOF
	dodir /usr/share/man
	dodir /usr/share/doc/${PF}
	INSTALL_ROOT="${D}/usr" DOC_DIR="${D}/usr/share/doc/${PF}" sh install.sh || die "install.sh failed"

	doman doc/sbcl-asdf-install.1

	dodoc BUGS CREDITS INSTALL NEWS OPTIMIZATIONS PRINCIPLES README STYLE SUPPORT TLA TODO

	if use doc; then
		dohtml doc/html/*
		doinfo "${S}/doc/manual/"*.info*
		dohtml -r "${S}/doc/internals/sbcl-internals"
	fi

	if use source; then
		# install the SBCL source
		cp -pPR "${S}/src" "${D}/usr/$(get_libdir)/sbcl"
		find "${D}/usr/$(get_libdir)/sbcl/src" -type f -name \*.fasl -print0 | xargs -0 rm -f
	fi

	impl-save-timestamp-hack sbcl
}

pkg_postinst() {
	standard-impl-postinst sbcl
}

pkg_postrm() {
	standard-impl-postrm sbcl /usr/bin/sbcl
}
