# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-apache-bsf/ant-apache-bsf-1.7.0.ebuild,v 1.8 2007/05/03 19:53:12 corsair Exp $

ANT_TASK_DEPNAME="bsf-2.3"

inherit ant-tasks

KEYWORDS="~amd64 ~ia64 ~ppc ppc64 ~x86 ~x86-fbsd"

DEPEND=">=dev-java/bsf-2.3.0-r3"
RDEPEND="${DEPEND}"

JAVA_PKG_FILTER_COMPILER="jikes"
