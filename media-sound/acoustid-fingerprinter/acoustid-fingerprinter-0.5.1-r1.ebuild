# Copyright © 2011 Calvin Walton
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit cmake-utils gnome2-utils

DESCRIPTION="A cross-platform GUI application that uses Chromaprint to submit audio fingerprints from your music collection to the Acoustid database."
HOMEPAGE="http://acoustid.org/fingerprinter"
SRC_URI="http://github.com/downloads/lalinsky/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	virtual/ffmpeg
	media-libs/taglib
	media-libs/chromaprint
"
DEPEND="${RDEPEND}"

src_install() {
	cmake-utils_src_install

	# Manually install the icons...
	insinto /usr/share/icons/hicolor/16x16/apps
	newins images/acoustid-fp-16.png acoustid-fingerprinter.png
	insinto /usr/share/icons/hicolor/24x24/apps
	newins images/acoustid-fp-24.png acoustid-fingerprinter.png
	insinto /usr/share/icons/hicolor/32x32/apps
	newins images/acoustid-fp-32.png acoustid-fingerprinter.png
	insinto /usr/share/icons/hicolor/48x48/apps
	newins images/acoustid-fp-48.png acoustid-fingerprinter.png
	insinto /usr/share/icons/hicolor/128x128/apps
	newins images/acoustid-fp-128.png acoustid-fingerprinter.png
	insinto /usr/share/icons/hicolor/256x256/apps
	newins images/acoustid-fp-256.png acoustid-fingerprinter.png
	insinto /usr/share/icons/hicolor/scalable/apps
	doins images/acoustid-fingerprinter.svg
}

pkg_postinst() {
	GNOME2_ECLASS_ICONS=/usr/share/icons/hicolor
	gnome2_icon_cache_update
}

pkg_postrm() {
	GNOME2_ECLASS_ICONS=/usr/share/icons/hicolor
	gnome2_icon_cache_update
}
