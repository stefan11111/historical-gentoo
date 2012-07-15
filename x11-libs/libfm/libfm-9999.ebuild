# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libfm/libfm-9999.ebuild,v 1.24 2012/07/15 17:29:26 hwoarang Exp $

EAPI=3

EGIT_REPO_URI="git://pcmanfm.git.sourceforge.net/gitroot/pcmanfm/${PN}"

inherit autotools git-2 fdo-mime

DESCRIPTION="A library for file management"
HOMEPAGE="http://pcmanfm.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug doc examples"
KEYWORDS=""

COMMON_DEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.16:2
	>=lxde-base/menu-cache-0.3.2"
RDEPEND="${COMMON_DEPEND}
	x11-misc/shared-mime-info"
DEPEND="${COMMON_DEPEND}
	>=dev-lang/vala-0.14.0
	dev-util/gtk-doc-am
	doc? (
		dev-util/gtk-doc
	)
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	if ! use doc; then
		sed -ie '/SUBDIRS=/s#docs##' "${S}"/Makefile.am || die "sed failed"
		sed -ie '/^[[:space:]]*docs/d' configure.ac || die "sed failed"
	else
		gtkdocize --copy || die
	fi
	intltoolize --force --copy --automake || die
	#disable unused translations. Bug #356029
	for trans in app-chooser ask-rename exec-file file-prop preferred-apps \
		progress;do
		echo "data/ui/"${trans}.ui >> po/POTFILES.in
	done
	sed -i -e "s:-O0::" -e "/-DG_ENABLE_DEBUG/s: -g::" "${S}"/configure.ac || die
	myvalaver="$(best_version dev-lang/vala | sed -e's@dev-lang/vala-\([0-9]*\.[0-9]*\)\..*@\1@g')"
	myvalac="$(type -p valac-${myvalaver})"
	[[ -x "${myvalac}" ]] || die "Vala compiler ${myvalac} not found"
	export VALAC=${myvalac}
	#Remove -Werror for automake-1.12. Bug #421101
	sed -i "s:-Werror::" configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}/etc" \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable examples demo) \
		$(use_enable debug) \
		# Documentation fails to build at the moment
		# $(use_enable doc gtk-doc) \
		# $(use_enable doc gtk-doc-html) \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS TODO

	find "${D}" -name '*.la' -exec rm -f '{}' +
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}
