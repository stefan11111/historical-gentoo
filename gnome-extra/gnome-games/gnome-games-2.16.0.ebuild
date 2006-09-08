# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.16.0.ebuild,v 1.1 2006/09/08 01:19:28 dang Exp $

inherit eutils gnome2

DESCRIPTION="Collection of games for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="artworkextra guile avahi"

RDEPEND=">=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnome-2
	>=x11-libs/gtk+-2.8
	>=gnome-base/librsvg-2
	>=gnome-base/libglade-2
	>=dev-libs/glib-2.6.3
	>=gnome-base/gnome-vfs-2
	>=x11-libs/cairo-1
	guile? ( >=dev-util/guile-1.6.5 )
	avahi? ( net-dns/avahi )
	artworkextra? ( gnome-extra/gnome-games-extra-data )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.10.40
	>=app-text/scrollkeeper-0.3.8"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"


pkg_setup() {
	GAMES_GROUP=${GAMES_GROUP:-games}
	enewgroup "${GAMES_GROUP}"

	G2CONF="--with-scores-group=${GAMES_GROUP} \
		$(use_enable guile) \
		$(use_enable avahi)"
}

src_unpack() {
	gnome2_src_unpack

	# Resolve symbols at execution time in setgid binaries
	epatch ${FILESDIR}/${PN}-2.14.0-no_lazy_bindings.patch

	# Implement --enable-guile switch
	epatch ${FILESDIR}/${PN}-2.13.1-guile_switch.patch

	autoconf || die "autoconf failed"
}

src_install() {
	gnome2_src_install

	# Documentation install for each of the games
	for game in \
	$(find . -maxdepth 1 -type d ! -name po ! -name libgames-support); do
		docinto ${game}
		for doc in AUTHORS ChangeLog NEWS README TODO; do
			[ -s ${game}/${doc} ] && dodoc ${game}/${doc}
		done
	done

	# Avoid overwriting previous .scores files
	local basefile
	for scorefile in ${D}/var/lib/games/*.scores; do
		basefile=$(basename $scorefile)
		if [ -s "${ROOT}/var/lib/games/${basefile}" ]; then
			rm ${scorefile}
		fi
	done
}
