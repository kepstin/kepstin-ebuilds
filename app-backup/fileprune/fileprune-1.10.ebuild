# Copyright (c) 2013 Calvin Walton
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Delete files from a backup set maintaining a time distribution"
HOMEPAGE="http://www.spinellis.gr/sw/unix/fileprune/"
SRC_URI="http://www.spinellis.gr/sw/unix/${PN}/${PNV}.tar.gz"

# Note that the fileprune license is non-free; modification is not permitted
LICENSE="fileprune"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin fileprune || die
	doman fileprune.1 || die
}
