# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs-utils/nfs-utils-0.2.1-r3.ebuild,v 1.2 2001/04/23 17:29:38 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Kernel NFS-Server"
SRC_URI="ftp://ftp.linuxnfs.sourceforge.org/pub/nfs/"${A}
HOMEPAGE="http://nfs.sourceforge.net"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3"

src_unpack() {
    unpack ${A}
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
    try ./configure --mandir=${D}/usr/share/man --with-statedir=/var/lib/nfs \
	--prefix=${D} --exec-prefix=${D}
    try make
}

src_install() {                 
	cd ${S}
	try make install STATEDIR=${D}/var/lib/nfs
	dodir /etc/rc.d/init.d
	cp ${O}/files/nfs       ${D}/etc/rc.d/init.d
	cp ${O}/files/exports	${D}/etc
	dodoc ChangeLog COPYING README
	docinto linux-nfs
	dodoc linux-nfs/*
}
pkg_config() {

  . ${ROOT}/etc/rc.d/config/functions
  . ${ROOT}/var/db/pkg/install.config

  echo "Generating symlinks..."
  ${ROOT}/usr/sbin/rc-update add nfs
  if [ -n "${nfsserver_home}" ]
  then
    echo "Export Homedirs..."
    cp ${ROOT}/etc/exports ${ROOT}/etc/exports.orig
    sed -e "s:^#nfsserver_home:${nfsserver_home}:" \
	-e "s/eth0_net/${eth0_net}/" \
	-e "s/eth0_mask/${eth0_mask}/" \
	${ROOT}/etc/exports.orig > ${ROOT}/etc/exports
  fi
}




