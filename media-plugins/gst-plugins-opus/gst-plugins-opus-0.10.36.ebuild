# Copyright 2012 Calvin Walton <calvin.walton@kepstin.ca>
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit gst-plugins-bad gst-plugins10

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x64-macos"
IUSE=""

RDEPEND=">=media-libs/opus-0.9.4"
DEPEND="${RDEPEND}"
