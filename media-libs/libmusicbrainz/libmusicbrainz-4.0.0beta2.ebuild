# Copyright © 2011 Calvin Walton
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit cmake-utils

DESCRIPTION="A library to add MusicBrainz lookup capabilities to an application."
HOMEPAGE="http://musicbrainz.org/doc/libmusicbrainz"
MY_P="${P/_/}"
SRC_URI="ftp://ftp.musicbrainz.org/pub/musicbrainz/${MY_P}.tar.gz"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
IUSE="examples tools"

RDEPEND="
    >=net-misc/neon-0.25
"
DEPEND="${RDEPEND}"