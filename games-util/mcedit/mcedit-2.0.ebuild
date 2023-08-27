# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="World Editor for Minecraft"
HOMEPAGE="https://github.com/mcedit/mcedit2"
#SRC_URI="https://github.com/mcedit/mcedit2/archive/refs/tags/v2.0-alpha.tar.gz"
#SRC_URI="https://github.com/mcedit/mcedit2/archive/refs/heads/master.zip"
SRC_URI="https://github.com/mcedit/mcedit2/archive/refs/tags/2.0.0-beta14.tar.gz"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/python:2.7
        dev-python/virtualenv
        dev-python/pyside2
        dev-python/pyopengl
        dev-python/ipython
        dev-libs/libxslt
        dev-lang/python
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/mcedit2-2.0.0-beta14"
#mcedit2-2.0-alpha"

src_prepare() {
    default
}

src_compile() {
    virtualenv ENV || die "Creating virtualenv failed"
    source ENV/bin/activate || die "Activating virtualenv failed"
    pip install -r requirements.txt || die "Installing pip requirements failed"
    python setup.py develop || die "Python setup.py failed"
}

src_install() {
    dodoc README.md
    dobin mcedit2
}
