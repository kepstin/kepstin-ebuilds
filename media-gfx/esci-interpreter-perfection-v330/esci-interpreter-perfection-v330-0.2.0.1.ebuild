# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/iscan-plugin-perfection-v370/iscan-plugin-perfection-v370-1.0.0.2.ebuild,v 1.1 2013/02/26 16:13:06 flameeyes Exp $

EAPI=5

inherit rpm versionator multilib

MY_PV="$(get_version_component_range 1-3)"
MY_PVR="$(replace_version_separator 3 -)"

SCANNER="Perfection V330"
FIRMWARE="esfwad.bin"

DESCRIPTION="Epson ${SCANNER} and similar scanner plugin for SANE 'epkowa' backend."
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="amd64? ( http://dev.gentoo.org/~flameeyes/avasys/${PN}-${MY_PVR}.x86_64.rpm )
	x86? ( http://dev.gentoo.org/~flameeyes/avasys/${PN}-${MY_PVR}.i386.rpm )"

LICENSE="AVASYS"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE=""

DEPEND=">=media-gfx/iscan-2.21.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PREBUILT="/opt/iscan/lib/*"

src_configure() { :; }
src_compile() { :; }

src_install() {
	# install scanner firmware
	insinto /usr/share/esci
	doins "${WORKDIR}"/usr/share/esci/*

	dodoc usr/share/doc/*/*

	# install scanner plugins
	exeinto /opt/iscan/lib
	doexe "${WORKDIR}/usr/$(get_libdir)/esci/"*
}

pkg_setup() {
	basecmds=(
		"iscan-registry --COMMAND interpreter usb 0x04b8 0x0142 /opt/iscan/lib/libesci-interpreter-perfection-v330 /usr/share/esci/${FIRMWARE}"
	)
}

pkg_postinst() {
	elog
	elog "Firmware file ${FIRMWARE} for ${SCANNER}"
	elog "has been installed in /usr/share/esci."
	elog

	# Only register scanner on new installs
	[[ -n ${REPLACING_VERSIONS} ]] && return

	# Needed for scanner to work properly.
	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/add}
		done
		elog "New firmware has been registered automatically."
		elog
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/add}"
		done
	fi
}

pkg_prerm() {
	# Only unregister on on uninstall
	[[ -n ${REPLACED_BY_VERSION} ]] && return

	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/remove}
		done
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/remove}"
		done
	fi
}
