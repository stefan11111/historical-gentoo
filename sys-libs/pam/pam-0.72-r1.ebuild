# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.72-r1.ebuild,v 1.5 2000/11/07 11:16:08 achim Exp $

P=pam-0.72
A=Linux-PAM-0.72.tar.gz
S=${WORKDIR}/Linux-PAM-0.72
DESCRIPTION="PAM"
SRC_URI="http://openrock.net/pub/linux/libs/pam/pre/library/${A}"
HOMEPAGE="http://www.redhat.com/linux-info/pam/"

DEPEND=">=sys-libs/cracklib-2.7
	>=sys-libs/pam-0.72"
RDEPEND=$DEPEND

src_unpack() {                           
  unpack ${A}
  cd ${S}
  touch .freezemake
  rm default.defs
  sed -e "s/CFLAGS=.*/CFLAGS=${CFLAGS} -pipe -D_REENTRANT/" \
      -e "s:FAKEROOT=.*:FAKEROOT=${WORKDIR}/../image:" defs/linux.defs > default.defs
  echo "EXTRALS=-lcrypt" >> default.defs
  cp Makefile Makefile.orig
  sed -e "s/DIRS = modules libpam/DIRS = libpam modules/" Makefile.orig > Makefile
  cd modules/pam_mkhomedir
  cp Makefile Makefile.orig
  sed -e "s:-lpam:-L../../libpam -lpam:" Makefile.orig > Makefile
  
}
src_compile() {
  try make
  try make
}

src_install() {                               
 cd ${S}
 touch conf/.ignore_age
 try make install
 dosbin bin/pam_conv1
 dodoc CHANGELOG Copyright README 
 dodoc 
 cd ${D}/usr/lib
 ln -sf libpamc.so.0.72 libpamc.so.0
 ln -sf libpam.so.0.72 libpam.so.0
 ln -sf libpam_misc.so.0.72 libpam_misc.so.0
}



