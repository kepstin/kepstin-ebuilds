# Copyright © 2011 Calvin Walton
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

# The build system runs a built executable to generate source files...
CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils

DESCRIPTION="A library to add MusicBrainz lookup capabilities to an application."
HOMEPAGE="http://musicbrainz.org/doc/libmusicbrainz"
MY_P="lib${P/_/}"
S="${WORKDIR}/${MY_P}"
SRC_URI="ftp://ftp.musicbrainz.org/pub/musicbrainz/${MY_P}.tar.gz"
SLOT="4"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64"

RDEPEND="
    >=net-libs/neon-0.25
"
DEPEND="${RDEPEND}"