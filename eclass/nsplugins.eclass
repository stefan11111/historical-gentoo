# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/nsplugins.eclass,v 1.3 2002/11/20 17:26:27 azarah Exp $
# Just some re-usable functions for the netscape/moz plugins sharing

ECLASS=nsplugins
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="Based on the ${ECLASS} eclass"

PLUGINS_DIR="nsbrowser/plugins"

# This function move the plugin dir in src_install() to
# ${D}/usr/lib/${PLUGIN_DIR}.  First argument should be
# the full path (without $D) to old plugin dir.
src_mv_plugins() {

	# Move plugins dir
	dodir /usr/lib/${PLUGINS_DIR}
	cp -a ${D}/$1/* ${D}/usr/lib/${PLUGINS_DIR}
	rm -rf ${D}/$1
	dosym ../${PLUGINS_DIR} $1
}

# This function move plugins in pkg_preinst() in old dir to 
# ${ROOT}//usr/lib/${PLUGIN_DIR}.  First argument should be
# the full path (without $ROOT) to old plugin dir.
pkg_mv_plugins() {

	# Move old plugins dir
	if [ -d ${ROOT}/$1 ]
	then
		mkdir -p ${ROOT}/usr/lib/${PLUGINS_DIR}
		cp -a ${ROOT}/$1/* ${ROOT}/usr/lib/${PLUGINS_DIR}
		rm -rf ${ROOT}/$1
	fi
}

