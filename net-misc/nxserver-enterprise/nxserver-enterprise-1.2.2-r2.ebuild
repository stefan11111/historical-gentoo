# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-enterprise/nxserver-enterprise-1.2.2-r2.ebuild,v 1.2 2004/03/10 22:14:38 stuart Exp $

inherit nxserver

DEPEND="$DEPEND
	!net-misc/nxserver-business
	!net-misc/nxserver-personal
	=net-misc/nxssh-1.2.2-r1
	=net-misc/nxproxy-1.2.2-r1"

MY_PV="${PV}-86"

SRC_URI="http://www.nomachine.com/download/nxserver-EE-1.2.2/RedHat-9.0/nxserver-${MY_PV}.i386.rpm"
