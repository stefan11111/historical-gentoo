# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gnupg/selinux-gnupg-20040703.ebuild,v 1.1 2004/07/03 20:51:12 pebenito Exp $

TEFILES="gpg.te"
FCFILES="gpg.fc"
MACROS="gpg_macros.te"
IUSE=""

inherit selinux-policy

DESCRIPTION="SELinux policy for GNU privacy guard"

KEYWORDS="x86 ppc sparc"

