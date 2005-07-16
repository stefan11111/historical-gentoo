#!/bin/bash
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf-wrapper/files/ac-wrapper-3.1.sh,v 1.1 2005/07/16 20:28:42 azarah Exp $

# Based on the ac-wrapper.pl script provided by MandrakeSoft
# Rewritten in bash by Gregorio Guidi
#
# Executes the correct autoconf version.
#
# - defaults to latest version (2.5x)
# - runs autoconf 2.13 only if:
#   - envvar WANT_AUTOCONF is set to `2.1'
#     -or-
#   - `configure' is already present and was generated by autoconf 2.13

if [[ ${0##*/} == "ac-wrapper.sh" ]] ; then
	echo "Don't call this script directly" >&2
	exit 1
fi

if [[ ${WANT_AUTOCONF} == "2.1" && ${0##*/} == "autom4te" ]] ; then
	echo "ac-wrapper: Autoconf 2.13 doesn't contain autom4te." >&2
	echo "            Either unset WANT_AUTOCONF or don't execute anything" >&2
	echo "            that would use autom4te." >&2
	exit 1
fi

binary_new="${0}-2.59"
binary_old="${0}-2.13"
binary=${binary_new}

acprereq_version() {
	# Add --posix to below awk to make sure it will run on macosx, etc
	awk \
	'($0 !~ /^[[:space:]]*(#|dnl)/) {
		# The following is replaced by below, as we cannot use match()
		# with a third argument with non-gawk (posix) versions of awk:
		#
		#if (match($0, "AC_PREREQ\\(\\[?([0-9]\\.[0-9])", res))
		#	VERSIONS[COUNT++] = res[1]
		#
		sindex = match($0, /AC_PREREQ\(\[?([0-9]\.[0-9])/)
		if (sindex > 0) {
			sindex += length("AC_PREREQ(")
			if (substr($0, sindex, 1) == "[")
				sindex++
			VERSIONS[COUNT++] = substr($0, sindex, 3)
		}
	}

	END {
		# The following is replaced by below, as we cannot use asort()
		# with non-gawk (posix) versions of awk:
		#
		#asort(VERSIONS)
		#
		VERSION = VERSIONS[0]
		for (x = 0; x <= COUNT;x++)
			if (VERSIONS[x] > VERSION)
				VERSION=VERSIONS[x]
		
		print VERSION
	}' "$@"
}

generated_version() {
	# Add --posix to below awk to make sure it will run on macosx, etc
	awk \
	'{
		# The following is replaced by below, as we cannot use match()
		# with a third argument with non-gawk (posix) versions of awk:
		#
		#if (match($0,
		#	  "^# Generated (by (GNU )?Autoconf|automatically using autoconf version) ([0-9].[0-9])",
		#	  res))
		#	{ print res[3]; exit }
		#
		# First try for newer versions of autoconf
		sindex = match($0, /Generated by GNU Autoconf ([0-9]\.[0-9])/)
		if (sindex > 0)
			# Now chop the first part before the version
			sindex += length("Generated by GNU Autoconf ")
		# No version, so try older versions of autoconf
		if (sindex <= 0) {
			sindex = match($0, /Generated automatically using autoconf version ([0-9]\.[0-9])/)
			if (sindex > 0)
				sindex += length("Generated automatically using autoconf version ")
		}

		# Ok, we got a version
		if (sindex > 0) {
			print substr($0, sindex, 3)
			exit
		}
	}' "$@"
}

#
# autodetect routine
#
if [[ ${WANT_AUTOCONF} != "2.5" ]] ; then 
	if [[ ${WANT_AUTOCONF} == "2.1" ]] ; then
		if [[ ! -f "configure.ac" ]] ; then
			binary=${binary_old}
		else
			echo "ac-wrapper: Since configure.ac is present, aclocal always use" >&2
			echo "            autoconf 2.59, which conflicts with your choice and" >&2
			echo "            causes error. You have two options:" >&2
			echo "            1. Try execute command again after removing configure.ac" >&2
			echo "            2. Don't set WANT_AUTOCONF" >&2
			exit 1
		fi
	else
		# Automake-1.7 and better requie autoconf-2.5x
		case "${WANT_AUTOMAKE}" in
		1.[7-9]) ;;
		*)
			acfiles=$(ls ac{local,include}.m4 configure.{in,ac} 2>/dev/null)
			[[ -n ${acfiles} ]] && confversion=$(acprereq_version ${acfiles})
			
			[[ -z ${confversion} && -r "configure" ]] && \
				confversion=$(generated_version configure)

			if [[ ${confversion} == "2.1" && ! -f "configure.ac" ]] ; then
				binary="${binary_old}"
			fi
		esac
	fi
fi

if [[ -n ${WANT_ACWRAPPER_DEBUG} ]] ; then
	if [[ -n ${WANT_AUTOCONF} ]] ; then
		echo "ac-wrapper: DEBUG: WANT_AUTOCONF is set to ${WANT_AUTOCONF}" >&2
	fi
	echo "ac-wrapper: DEBUG: will execute <${binary}>" >&2
fi

#
# for further consistency
#
if [[ ${binary} == "${binary_new}" ]] ; then
	export WANT_AUTOCONF="2.5"
elif [[ ${binary} == "${binary_old}" ]] ; then
	export WANT_AUTOCONF="2.1"
fi

if [[ ! -x ${binary} ]] ; then
	# this shouldn't happen
	echo "ac-wrapper: ${binary} is missing or not executable." >&2
	echo "            Please try emerging the correct version of autoconf." >&2
	exit 1
fi

exec "${binary}" "$@"

echo "ac-wrapper: was unable to exec ${binary} !?" >&2
exit 1
