# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgphoto2/libgphoto2-2.1.4.ebuild,v 1.14 2004/07/31 02:50:26 tgall Exp $

inherit libtool eutils

DESCRIPTION="Library that implements support for numerous digital cameras"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64 ~ia64 ppc64"
IUSE="nls doc jpeg"

# needs >usbutils-0.11-r2 to avoid /usr/lib/libusb*
# conflicts with dev-libs/libusb
RDEPEND=">=dev-libs/libusb-0.1.6
	>=sys-apps/usbutils-0.11-r2
	sys-apps/hotplug
	jpeg? ( >=media-libs/libexif-0.5.9 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

# By default, drivers for all supported cards will be compiled.
# If you want to only compile for specific card(s), set CAMERAS
# environment to a comma-separated list (no spaces) of drivers that
# you want to build.
IUSE_CAMERAS="agfa-cl20 barbie canon casio digita dimera directory fuji gsmart300 jamcam jd11
kodak konica mustek largan minolta panasonic pccam300 pccam600 polaroid ptp2 ricoh samsung
smal sierra sipix sonydscf1 sonydscf55 soundvision spca50x sq905 stv0680 sx330z"

pkg_setup() {
	if [ -z "${CAMERAS}" ] ; then
		ewarn "All camera drivers will be built since you did not specify"
		ewarn "via the CAMERAS variable what camera you use."
		einfo "libgphoto2 supports: all ${IUSE_CAMERAS}"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.1.2-norpm.patch
	# add stylcam snap support (#52932)
	epatch ${FILESDIR}/${PN}-2.1.4-blink2.patch
	# Fix compilation under gcc-2.
	epatch ${FILESDIR}/${P}-gcc2_fixes.patch
}

src_compile() {
	local cameras
	local cam
	for cam in ${CAMERAS} ; do
		has ${cam} ${IUSE_CAMERAS} && cameras="${cameras},${cam}"
	done
	[ -z "${cameras}" ] \
		&& cameras="all" \
		|| cameras="${cameras:1}"
	einfo $cameras

	elibtoolize

	local myconf

	myconf="--with-rpmbuild=/bin/false"
	myconf="--with-drivers=${cameras}"
	use jpeg \
		&& myconf="${myconf} --with-exif-prefix=/usr" \
		|| myconf="${myconf} --without-exif"
	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_enable doc docs`"
	econf ${myconf} || die "econf failed"
	# or the documentation fails.
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} \
		gphotodocdir=/usr/share/doc/${PF} \
		HTML_DIR=/usr/share/doc/${PF}/sgml \
		hotplugdocdir=/usr/share/doc/${PF}/linux-hotplug \
		install || die "install failed"

	# manually move apidocs
	if use doc; then
		dodir /usr/share/doc/${PF}/api
		mv ${D}/usr/share/doc/libgphoto2/html/api/* ${D}/usr/share/doc/${PF}/api/
		mv ${D}/usr/share/doc/libgphoto2_port/html/api/* ${D}/usr/share/doc/${PF}/api/
	fi
	rm -rf ${D}/usr/share/doc/libgphoto2
	rm -rf ${D}/usr/share/doc/libgphoto2_port

	dodoc ChangeLog NEWS* README AUTHORS TESTERS MAINTAINERS HACKING CHANGES

	# install hotplug support
	insinto /etc/hotplug/usb
	newins ${S}/packaging/linux-hotplug/usbcam.console usbcam
	chmod +x ${D}/etc/hotplug/usb/usbcam
}

pkg_postinst() {
	einfo "Generating usbcam-gphoto2.usermap .."
	HOTPLUG_USERMAP="/etc/hotplug/usb/usbcam-gphoto2.usermap"
	if [ -x ${ROOT}/usr/lib/libgphoto2/print-usb-usermap ]; then
		echo "# !!! DO NOT EDIT THIS FILE !!! This file is automatically generated." > ${ROOT}/${HOTPLUG_USERMAP}
		echo "# Put your custom entries in /etc/hotplug/usb/usbcam.usermap" >> ${ROOT}/${HOTPLUG_USERMAP}
		${ROOT}/usr/lib/libgphoto2/print-usb-usermap >> ${ROOT}/${HOTPLUG_USERMAP}
	else
		eerror "Unable to find ${ROOT}/usr/lib/libgphoto2/print-usb-usermap"
		eerror "and therefore unable to generate hotplug usermap."
		eerror "You will have to manually generate it by running:"
		eerror " /usr/lib/libgphoto2/print-usb-usermap > ${HOTPLUG_USERMAP}"
	fi
}
