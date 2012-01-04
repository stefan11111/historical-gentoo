# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kmod/kmod-9999.ebuild,v 1.4 2012/01/04 23:55:50 williamh Exp $

EAPI=4

EGIT_REPO_URI="git://git.profusion.mobi/${PN}.git"

[[ "${PV}" == "9999" ]] && vcs=git-2
inherit ${vcs}  autotools eutils toolchain-funcs
unset vcs

if [[ "${PV}" != "9999" ]] ; then
	SRC_URI="http://packages.profusion.mobi/kmod/${P}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
fi

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="http://git.profusion.mobi/cgit.cgi/kmod.git"

LICENSE="LGPL-2"
SLOT="0"
IUSE="debug lzma static-libs +tools zlib"

DEPEND="zlib? ( sys-libs/zlib )
	lzma? ( app-arch/xz-utils )"
RDEPEND="${DEPEND}"

src_prepare()
{
	if [ ! -e configure ]; then
		eautoreconf
	else
		elibtoolize
	fi
}

src_configure()
{
	econf \
		$(use_enable debug) \
		$(use_with lzma xz) \
		$(use_enable static-libs static) \
		$(use_enable tools) \
		$(use_with zlib)
}

src_install()
{
	default

	# we have a .pc file for people to use
	find "${D}" -name libkmod.la -delete

	# If the tools are installed, add compatibility symbolic links
	if use tools; then
		for cmd in depmod insmod lsmod modinfo modprobe rmmod; do
			dosym kmod /usr/bin/$cmd
		done
	fi
}
