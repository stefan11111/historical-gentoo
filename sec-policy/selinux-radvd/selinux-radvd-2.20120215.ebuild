# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-radvd/selinux-radvd-2.20120215.ebuild,v 1.1 2012/03/31 12:29:13 swift Exp $
EAPI="4"

IUSE=""
MODS="radvd"
BASEPOL="2.20120215-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for radvd"

KEYWORDS="~amd64 ~x86"
