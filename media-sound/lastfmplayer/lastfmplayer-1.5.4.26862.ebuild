# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lastfmplayer/lastfmplayer-1.5.4.26862.ebuild,v 1.1 2010/05/24 22:24:42 hwoarang Exp $

EAPI=2
inherit eutils multilib toolchain-funcs qt4-r2

MY_P="${P/lastfmplayer/lastfm}+dfsg"

DESCRIPTION="A player for last.fm radio streams"
HOMEPAGE="http://www.last.fm/help/player"
SRC_URI="mirror://debian/pool/main/l/lastfm/lastfm_${PV}+dfsg.orig.tar.gz
	mirror://debian/pool/main/l/lastfm/lastfm_${PV}+dfsg-3.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ipod"
RESTRICT="mirror"

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4
	media-libs/libsamplerate
	sci-libs/fftw
	media-libs/libmad
	ipod? ( >=media-libs/libgpod-0.5.2 )
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	app-arch/sharutils"

S=${WORKDIR}/${MY_P}

src_prepare() {
	qt4-r2_src_prepare
	epatch "${FILESDIR}"/fix_plugin_path.patch
	einfo "Applying Debian patchset"
	ebegin "Disabling tray-icon-size patch"
	sed -i "/^tray-icon-size.diff/d" "${WORKDIR}"/debian/patches/series
	eend $?
	cd "${S}"
	for i in $( < "${WORKDIR}"/debian/patches/series); do
		epatch "${WORKDIR}"/debian/patches/$i
	done
	if ! use ipod ; then
		sed -i '/src\/mediadevices\/ipod/d' LastFM.pro || die "sed failed"
	fi
	#don't install plugins into generic location
	sed -i "s:\$\$BIN_DIR/services:\$\$BIN_DIR/lastfm_services:" \
		"${S}"/definitions.pro.inc
	#fix plugin search path
	sed -i "s:/usr/lib/services:/usr/$(get_libdir)/lastfm_services:" \
		"${S}"/src/libMoose/MooseCommon.cpp
}

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die "emake failed"
	cd i18n; lrelease *.ts
}

src_install() {
	cd "${WORKDIR}"
	# Docs
	dodoc "${S}"/ChangeLog "${S}"/README debian/README.source \
		|| die "dodoc failed"
	doman debian/lastfm.1 || die "doman failed"

	# Copied from debian/rules
	insinto /usr/share
	doins -r debian/package-files/share/icons || die "failed to install icons"
	insinto /usr/share/lastfm/icons
	doins "${S}"/bin/data/icons/*.png \
		|| die "failed to install application icons"
	insinto /usr/share/lastfm
	doins "${S}"/bin/data/*.png || die "failed to install icons"
	dodir /usr/$(get_libdir)/lastfm_services/
	insinto /usr/$(get_libdir)/lastfm_services/
	insopts -m0755
	doins -r "${S}"/bin/lastfm_services/*.so || die "failed to install plugins"
	insinto /usr/$(get_libdir)
	insopts -m0755
	doins "${S}"/bin/libLastFmTools.so.1* || die "failed to install library"
	doins "${S}"/bin/libMoose.so.1* || die "failed to install library"
	#fix symlinks
	cd "${D}"/usr/$(get_libdir)/
	ln -sfn libLastFmTools.so.1.0.0 libLastFmTools.so.1
	ln -sfn libLastFmTools.so.1.0.0 libLastFmTools.so.1.0
	ln -sfn libMoose.so.1.0.0 libMoose.so.1
	ln -sfn libMoose.so.1.0.0 libMoose.so.1.0
	cd "${WORKDIR}"
	newbin "${S}"/bin/last.fm lastfm || die "newbin failed"
	insinto /usr/share/lastfm/i18n
	doins "${S}"/i18n/*.qm || die "failed to install translations"
	fperms 755 /usr/bin/lastfm
	rm -f "${D}"/usr/share/lastfm/icons/{*profile24,systray_mac}.png
	# create desktop entry
	doicon "${WORKDIR}"/debian/package-files/share/icons/hicolor/48x48/apps/lastfm.png
	make_desktop_entry lastfm "Last.fm Player" lastfm
}

pkg_postinst() {
	elog "To use the Last.fm player with a mozilla based browser:"
	elog " 1. Go to about:config in the browser"
	elog " 2. Right-click on the page"
	elog " 3. Select New and then String"
	elog " 4. For the name: network.protocol-handler.app.lastfm"
	elog " 5. For the value: /usr/bin/lastfm"
	elog
	elog "If you experience awkward fonts or widgets, try running qtconfig."
}
