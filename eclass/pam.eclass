# Copyright 2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Diego Pettenò <flameeyes@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/pam.eclass,v 1.2 2005/05/20 12:38:56 flameeyes Exp $
#
# This eclass contains functions to install pamd configuration files and
# pam modules.

inherit multilib
ECLASS="pam"
INHERITED="$INHERITED $ECLASS"

# dopamd <file> [more files]
#
# Install pam auth config file in /etc/pam.d
dopamd() {
	[[ -z $1 ]] && die "dopamd requires at least one argument"

	if hasq pam ${IUSE} && ! use pam; then
		return 0;
	fi

	insinto /etc/pam.d
	doins "$@" || die "failed to install $@"
}

# newpamd <old name> <new name>
#
# Install pam file <old name> as <new name> in /etc/pam.d
newpamd() {
	[[ $# -ne 2 ]] && die "newpamd requires two arguments"

	if hasq pam ${IUSE} && ! use pam; then
		return 0;
	fi

	insinto /etc/pam.d
	newins "$1" "$2" || die "failed to install $1 as $2"
}

# dopamsecurity <section> <file> [more files]
#
# Installs the config files in /etc/security/<section>/
dopamsecurity() {
	[[ $# -lt 2 ]] && die "dopamsecurity requires at least two arguments"

	if hasq pam ${IUSE} && ! use pam; then
		return 0;
	fi

	insinto /etc/security/$1
	shift
	doins "$@" || die "failed to install $@"
}

# newpamsecurity <section> <old name> <new name>
#
# Installs the config file <old name> as <new name> in /etc/security/<section>/
newpamsecurity() {
	[[ $# -ne 3 ]] && die "newpamsecurity requires three arguments"

	if hasq pam ${IUSE} && ! use pam; then
		return 0;
	fi

	insinto /etc/security/$1
	newins "$2" "$3" || die "failed to install $2 as $3"
}

# getpam_mod_dir
#
# Returns the pam modules' directory for current implementation
getpam_mod_dir() {
	if has_version sys-libs/pam; then
		PAM_MOD_DIR=/$(get_libdir)/security
	elif has_version sys-libs/openpam; then
		PAM_MOD_DIR=/usr/$(get_libdir)
	else
		# Unable to find PAM implementation... defaulting
		PAM_MOD_DIR=/$(get_libdir)/security
	fi

	echo ${PAM_MOD_DIR}
}

# dopammod <file> [more files]
#
# Install pam module file in the pam modules' dir for current implementation
dopammod() {
	[[ -z $1 ]] && die "dopammod requires at least one argument"

	if hasq pam ${IUSE} && ! use pam; then
		return 0;
	fi

	exeinto $(getpam_mod_dir)
	doexe "$@" || die "failed to install $@"
}

# newpammod <old name> <new name>
#
# Install pam module file <old name> as <new name> in the pam
# modules' dir for current implementation
newpammod() {
	[[ $# -ne 2 ]] && die "newpammod requires two arguements"

	if hasq pam ${IUSE} && ! use pam; then
		return 0;
	fi

	exeinto $(getpam_mod_dir)
	newexe "$1" "$2" || die "failed to install $1 as $2"
}

# pamd_mimic_system <pamd file> [auth levels]
#
# This function creates a pamd file which mimics system-auth file
# for the given levels in the /etc/pam.d directory.
pamd_mimic_system() {
	[[ $# -lt 2 ]] && die "pamd_mimic_system requires at least two argments"

	if hasq pam ${IUSE} && ! use pam; then
		return 0;
	fi

	dodir /etc/pam.d
	pamdfile=${D}/etc/pam.d/$1
	echo -e "# File autogenerated by pamd_mimic_system in pam eclass\n\n" >> \
		$pamdfile
	
	authlevels="auth account password session"

	shift

	while [[ -n $1 ]]; do
		hasq $1 ${authlevels} || die "unknown level type"

		echo -e "$1\tinclude\t\tsystem-auth" >> ${pamdfile}

		shift
	done
}
