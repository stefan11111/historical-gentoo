# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lame/lame-3.96.1.ebuild,v 1.1 2004/07/26 04:55:07 eradicator Exp $

IUSE="gtk debug"

inherit flag-o-matic gcc eutils

DESCRIPTION="LAME Ain't an Mp3 Encoder"
HOMEPAGE="http://lame.sourceforge.net"
SRC_URI="mirror://sourceforge/lame/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips"

RDEPEND=">=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_compile() {
	# take out -fomit-frame-pointer from CFLAGS if k6-2
	is-flag "-march=k6-3" && filter-flags "-fomit-frame-pointer"
	is-flag "-march=k6-2" && filter-flags "-fomit-frame-pointer"
	is-flag "-march=k6" && filter-flags "-fomit-frame-pointer"

	[ "`gcc-fullversion`" == "3.3.2" ] && replace-flags -march=2.0 -march=1.0

	local myconf=""
	if use gtk; then
		myconf="${myconf} --enable-mp3x"
	fi

	# as of 3.95.1 changed from "yes" to "norm" ("alot" is also accepted)
	use debug \
		&& myconf="${myconf} --enable-debug=norm" \
		|| myconf="${myconf} --enable-debug=no"

	# The user sets compiler optimizations... But if you'd like
	# lame to choose it's own... uncomment one of these (experiMENTAL)
	# myconf="${myconf} --enable-expopt=full \
	# myconf="${myconf} --enable-expopt=norm \

	econf \
		--enable-shared \
		`use_enable x86 nasm` \
		--enable-mp3rtp \
		${myconf} || die

	# Parallel make isn't happy
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" pkghtmldir="/usr/share/doc/${PF}/html" install || die

	dodoc API ChangeLog HACKING PRESETS.draft README* STYLEGUIDE TODO USAGE
	dohtml misc/lameGUI.html Dll/LameDLLInterface.htm

	dobin ${S}/misc/mlame
}
