# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/ecb/ecb-1.01.ebuild,v 1.1 2003/02/22 12:46:39 rendhalver Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs source code browser."
PKG_CAT="standard"

DEPEND="app-xemacs/xemacs-base
app-xemacs/semantic
app-xemacs/eieio
app-xemacs/fsf-compat
app-xemacs/edit-utils
app-xemacs/jde
app-xemacs/mail-lib
app-xemacs/eshell
app-xemacs/ediff
app-xemacs/xemacs-devel
app-xemacs/speedbar
"
KEYWORDS="x86 ~ppc ~alpha sparc"

inherit xemacs-packages

