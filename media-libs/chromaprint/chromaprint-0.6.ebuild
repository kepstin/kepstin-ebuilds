# Copyright © 2011 Calvin Walton
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit cmake-utils

DESCRIPTION="A library that implements an algorithm for extracting fingerprints from any audio source."
HOMEPAGE="http://acoustid.org/chromaprint"
SRC_URI="http://github.com/downloads/lalinsky/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
IUSE="examples tools"

RDEPEND="
    virtual/ffmpeg
    tools? ( media-libs/taglib )
"
DEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_AVFFT=ON
		$(cmake-utils_use_build examples EXAMPLES)
		$(cmake-utils_use_build tools TOOLS)
	)
	cmake-utils_src_configure
}
