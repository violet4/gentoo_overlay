# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="MCA Selector: a graphical tool to work with Minecraft's Anvil file format"
HOMEPAGE="https://github.com/Querz/mcaselector"
SRC_URI="https://github.com/Querz/mcaselector/archive/refs/tags/2.2.2.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-java/openjdk:17
	dev-java/gradle-bin
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/mcaselector-2.2.2"

src_prepare() {
    default
}

src_compile() {
    export GRADLE_USER_HOME="${WORKDIR}/.gradle"
	gradle assemble --stacktrace --debug || die "Build failed"
    unset GRADLE_USER_HOME
}

src_install() {
	dodoc README.md LICENSE
	insinto /usr/share/mcaselector
	doins -r .
	dobin java mcaselector-2.2.2.jar
}
