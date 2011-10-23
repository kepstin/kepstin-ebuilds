# Copyright © 2011 Calvin Walton
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit cmake-utils

DESCRIPTION="A cross-platform GUI application that uses Chromaprint to submit audio fingerprints from your music collection to the Acoustid database."
HOMEPAGE="http://acoustid.org/fingerprinter"
SRC_URI="http://github.com/downloads/lalinsky/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"

RDEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	virtual/ffmpeg
	media-libs/taglib
	media-libs/chromaprint
"
DEPEND="${RDEPEND}"
