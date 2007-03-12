# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-reminder/gkrellm-reminder-2.0.0.ebuild,v 1.13 2007/03/12 14:30:05 lack Exp $

inherit gkrellm-plugin

IUSE=""
DESCRIPTION="a Reminder Plugin for GKrellM2"
SRC_URI="http://members.dslextreme.com/users/billw/gkrellm/Plugins/${P}.tar.gz"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha amd64"

PLUGIN_SO=reminder.so

