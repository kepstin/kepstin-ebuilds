# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany-extensions/epiphany-extensions-3.2.0-r1.ebuild,v 1.1 2011/11/19 06:20:52 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2 gnome2-live

DESCRIPTION="Extensions for the Epiphany web browser"
HOMEPAGE="http://www.gnome.org/projects/epiphany/extensions.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus examples pcre"

RDEPEND=">=www-client/epiphany-3.3
	app-text/opensp
	>=dev-libs/glib-2.26.0:2
	>=dev-libs/libxml2-2.6:2
	>=x11-libs/gtk+-2.90.4:3
	net-libs/webkit-gtk:3

	dbus? (
		>=dev-libs/dbus-glib-0.34
		sys-apps/dbus )
	pcre? ( >=dev-libs/libpcre-3.9-r2 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=dev-util/pkgconfig-0.20
	>=app-text/gnome-doc-utils-0.3.2

	gnome-base/gnome-common"
# eautoreconf dependencies:
#	  gnome-base/gnome-common

pkg_setup() {
	local extensions=""
	# XXX: Only enable default/useful extensions?
	extensions="actions adblock auto-reload certificates \
			   error-viewer extensions-manager-ui gestures html5tube \
			   java-console livehttpheaders page-info \
			   push-scroller select-stylesheet \
			   smart-bookmarks soup-fly tab-states"
	use dbus && extensions="${extensions} rss"
	use pcre && extensions="${extensions} greasemonkey"
	use examples && extensions="${extensions} sample"

	G2CONF="${G2CONF}
		--disable-schemas-compile
		--with-extensions=$(echo "${extensions}" | sed -e 's/[[:space:]]\+/,/g')"
	DOCS="AUTHORS ChangeLog HACKING NEWS README"
}

src_prepare() {
	# https://bugzilla.gnome.org/show_bug.cgi?id=664369; needs eautoreconf
	epatch "${FILESDIR}/${PN}-3.2.0-dbus-libs.patch"
	gnome2_src_prepare
}