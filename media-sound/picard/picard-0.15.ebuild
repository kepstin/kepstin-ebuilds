# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/picard/picard-0.14.ebuild,v 1.1 2011/05/26 04:33:52 aballier Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

MY_P="${P/_/}"
DESCRIPTION="An improved rewrite/port of the Picard Tagger using Qt"
HOMEPAGE="http://musicbrainz.org/doc/PicardQt"
SRC_URI="
	http://ftp.musicbrainz.org/pub/musicbrainz/picard/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cdda fingerprint nls"

DEPEND="
	dev-python/PyQt4[X]
	media-libs/mutagen
	cdda? ( >=media-libs/libdiscid-0.1.1 )
	fingerprint? (
		virtual/ffmpeg
		>=media-libs/libofa-0.9.2 )"
RDEPEND="${DEPEND}"

# doesn't work with ebuilds
RESTRICT="test"

RESTRICT_PYTHON_ABIS="2.4 3.*"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS.txt INSTALL.txt NEWS.txt"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.13-ffmpeg.patch"
	distutils_src_prepare
}

src_configure() {
	$(PYTHON -f) setup.py config || die "setup.py config failed"
	if ! use fingerprint; then
		sed -i -e "s:\(^with-avcodec\ =\ \).*:\1False:" \
			-e "s:\(^with-libofa\ =\ \).*:\1False:" \
			build.cfg || die "sed failed"
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
	elog
	elog "You should set the environment variable BROWSER to something like"
	elog "\"firefox '%s' &\" to let python know which browser to use."
	if use coverart; then
		ewarn "You have downloaded and installed the coverart downloader plugin."
		ewarn "If you expect it to work please enable it in Options->Plugins."
	fi
}
