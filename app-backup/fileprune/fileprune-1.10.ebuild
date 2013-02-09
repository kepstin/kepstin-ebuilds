# Copyright (c) 2013 Calvin Walton
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Delete files from a backup set maintaining a time distribution"
HOMEPAGE="http://www.spinellis.gr/sw/unix/fileprune/"
SRC_URI="http://www.spinellis.gr/sw/unix/${PN}/${P}.tar.gz"

# Note that the fileprune license is non-free; modification is not permitted
LICENSE="fileprune"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	# Easier to just build it manually than patch the Makefile
	echo "$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o fileprune fileprune.c -lm"
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o fileprune fileprune.c -lm || die
}

src_install() {
	dobin fileprune
	doman fileprune.1
}
