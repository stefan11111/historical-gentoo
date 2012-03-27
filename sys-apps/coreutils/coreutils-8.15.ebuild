# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/coreutils/coreutils-8.15.ebuild,v 1.2 2012/03/27 17:49:13 vapier Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

PATCH_VER="1"
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls...), text utilities (sort, tr, head, wc..), and shell utilities (whoami, who,...)"
HOMEPAGE="http://www.gnu.org/software/coreutils/"
SRC_URI="mirror://gnu-alpha/coreutils/${P}.tar.xz
	mirror://gnu/${PN}/${P}.tar.xz
	mirror://gentoo/${P}.tar.xz
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.xz
	http://dev.gentoo.org/~vapier/dist/${P}-patches-${PATCH_VER}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="acl caps gmp nls selinux static unicode vanilla xattr"

RDEPEND="caps? ( sys-libs/libcap )
	gmp? ( dev-libs/gmp )
	selinux? ( sys-libs/libselinux )
	acl? ( sys-apps/acl )
	xattr? ( sys-apps/attr )
	nls? ( >=sys-devel/gettext-0.15 )
	!app-misc/realpath
	!<sys-apps/util-linux-2.13
	!sys-apps/stat
	!net-mail/base64
	!sys-apps/mktemp
	!<app-forensics/tct-1.18-r1
	!<net-fs/netatalk-2.0.3-r4
	!<sci-chemistry/ccp4-6.1.1"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_prepare() {
	if ! use vanilla ; then
		use unicode || rm -f "${WORKDIR}"/patch/000_all_coreutils-i18n.patch
		EPATCH_SUFFIX="patch" \
		PATCHDIR="${WORKDIR}/patch" \
		EPATCH_EXCLUDE="001_all_coreutils-gen-progress-bar.patch" \
		epatch
	fi

	# Since we've patched many .c files, the make process will try to
	# re-build the manpages by running `./bin --help`.  When doing a
	# cross-compile, we can't do that since 'bin' isn't a native bin.
	# Also, it's not like we changed the usage on any of these things,
	# so let's just update the timestamps and skip the help2man step.
	set -- man/*.x
	tc-is-cross-compiler && touch ${@/%x/1}

	# Avoid perl dep for compiled in dircolors default #348642
	if ! has_version dev-lang/perl ; then
		touch src/dircolors.h
		touch ${@/%x/1}
	fi
}

src_configure() {
	tc-is-cross-compiler && [[ ${CHOST} == *linux* ]] && export fu_cv_sys_stat_statfs2_bsize=yes #311569

	use static && append-ldflags -static && sed -i '/elf_sys=yes/s:yes:no:' configure #321821
	use selinux || export ac_cv_{header_selinux_{context,flash,selinux}_h,search_setfilecon}=no #301782
	# kill/uptime - procps
	# groups/su   - shadow
	# hostname    - net-tools
	econf \
		--with-packager="Gentoo" \
		--with-packager-version="${PVR} (p${PATCH_VER:-0})" \
		--with-packager-bug-reports="http://bugs.gentoo.org/" \
		--enable-install-program="arch" \
		--enable-no-install-program="groups,hostname,kill,su,uptime" \
		--enable-largefile \
		$(use caps || echo --disable-libcap) \
		$(use_enable nls) \
		$(use_enable acl) \
		$(use_enable xattr) \
		$(use_with gmp)
}

src_test() {
	# Non-root tests will fail if the full path isnt
	# accessible to non-root users
	chmod -R go-w "${WORKDIR}"
	chmod a+rx "${WORKDIR}"

	# coreutils tests like to do `mount` and such with temp dirs
	# so make sure /etc/mtab is writable #265725
	# make sure /dev/loop* can be mounted #269758
	mkdir -p "${T}"/mount-wrappers
	mkwrap() {
		local w ww
		for w in "$@" ; do
			ww="${T}/mount-wrappers/${w}"
			cat <<-EOF > "${ww}"
				#!/bin/sh
				exec env SANDBOX_WRITE="\${SANDBOX_WRITE}:/etc/mtab:/dev/loop" $(type -P $w) "\$@"
			EOF
			chmod a+rx "${ww}"
		done
	}
	mkwrap mount umount

	addwrite /dev/full
	#export RUN_EXPENSIVE_TESTS="yes"
	#export FETISH_GROUPS="portage wheel"
	env PATH="${T}/mount-wrappers:${PATH}" \
	emake -j1 -k check || die "make check failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog* NEWS README* THANKS TODO

	insinto /etc
	newins src/dircolors.hin DIR_COLORS || die

	if [[ ${USERLAND} == "GNU" ]] ; then
		cd "${D}"/usr/bin
		dodir /bin
		# move critical binaries into /bin (required by FHS)
		local fhs="cat chgrp chmod chown cp date dd df echo false ln ls
		           mkdir mknod mv pwd rm rmdir stty sync true uname"
		mv ${fhs} ../../bin/ || die "could not move fhs bins"
		# move critical binaries into /bin (common scripts)
		local com="basename chroot cut dir dirname du env expr head mkfifo
		           mktemp readlink seq sleep sort tail touch tr tty vdir wc yes"
		mv ${com} ../../bin/ || die "could not move common bins"
		# create a symlink for uname in /usr/bin/ since autotools require it
		local x
		for x in ${com} uname ; do
			dosym /bin/${x} /usr/bin/${x} || die
		done
	else
		# For now, drop the man pages, collides with the ones of the system.
		rm -rf "${D}"/usr/share/man
	fi
}

pkg_postinst() {
	ewarn "Make sure you run 'hash -r' in your active shells."
	ewarn "You should also re-source your shell settings for LS_COLORS"
	ewarn "  changes, such as: source /etc/profile"

	# /bin/dircolors sometimes sticks around #224823
	if [ -e "${ROOT}/usr/bin/dircolors" ] && [ -e "${ROOT}/bin/dircolors" ] ; then
		if strings "${ROOT}/bin/dircolors" | grep -qs "GNU coreutils" ; then
			einfo "Deleting orphaned GNU /bin/dircolors for you"
			rm -f "${ROOT}/bin/dircolors"
		fi
	fi

	# Help out users using experimental filesystems
	if grep -qs btrfs "${ROOT}"/etc/fstab /proc/mounts ; then
		case $(uname -r) in
		2.6.[12][0-9]|2.6.3[0-7]*)
			ewarn "You are running a system with a buggy btrfs driver."
			ewarn "Please upgrade your kernel to avoid silent corruption."
			ewarn "See: https://bugs.gentoo.org/353907"
			;;
		esac
	fi
}
