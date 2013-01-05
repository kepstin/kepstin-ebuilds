# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/picard/picard-0.15.1-r1.ebuild,v 1.1 2011/09/29 08:54:46 radhermit Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit eutils distutils git

MY_P="${P/_/}"
DESCRIPTION="An improved rewrite/port of the Picard Tagger using Qt"
HOMEPAGE="http://musicbrainz.org/doc/PicardQt"
SRC_URI=""
EGIT_REPO_URI="git://github.com/musicbrainz/picard.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="acoustid cdda nls"

DEPEND="
	dev-python/PyQt4[X]
	media-libs/mutagen
	cdda? ( >=media-libs/libdiscid-0.1.1 )
"
RDEPEND="${DEPEND}
	acoustid? ( media-libs/chromaprint[tools] )
"

# doesn't work with ebuilds
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS.txt INSTALL.txt NEWS.txt"

pkg_setup() {
	if ! use cdda; then
		ewarn "The 'cdda' USE flag is disabled. CD index lookup and"
		ewarn "identification will not be available. You can get audio CD support"
		ewarn "by installing media-libs/libdiscid."
	fi
}

src_compile() {
	distutils_src_compile $(use nls || echo "--disable-locales")
}

src_install() {
	distutils_src_install --disable-autoupdate --skip-build \
		$(use nls || echo "--disable-locales")

	doicon picard.ico || die 'doicon failed'
	domenu picard.desktop || die 'domenu failed'
}

pkg_postinst() {
	distutils_pkg_postinst
	echo
	ewarn "If you are upgrading Picard and it does not start"
	ewarn "try removing Picard's settings:"
	ewarn "	rm ~/.config/MusicBrainz/Picard.conf"
	if use acoustid; then
		ewarn "To enable acoustid support in Picard, go to Advanced->Fingerprinting"
		ewarn "in the options menu, select 'Use AcoustID'. You will have to obtain your"
		ewarn "own API key, follow the instructions in the dialog."
		ewarn "You can leave the 'Fingerprint calculator' field blank."
	fi
}
