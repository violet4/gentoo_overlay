EAPI=7

DESCRIPTION="Powerful all-in-one bot for Twitch streamers"
HOMEPAGE="https://github.com/crowbartools/Firebot"
# don't try to use mirrors.. just use SRC_URI
RESTRICT="mirror"
SRC_URI="https://github.com/crowbartools/Firebot/archive/refs/tags/v5.58.1.tar.gz"
LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
# portage wants lowercase but firebot uses title case Firebot
S="${WORKDIR}/Firebot-5.58.1"


RDEPEND="
    dev-vcs/git
    net-libs/nodejs
    dev-lang/python:3.9
    x11-libs/libX11
    x11-libs/libXtst
    media-libs/libpng
"
DEPEND="${RDEPEND}"

src_compile() {
    # Clone the specific tag from the repository
    git clone --branch "v5.58.1" "git@github.com:crowbartools/Firebot.git" || die "git clone failed"
    cd Firebot || die "cd to Firebot failed"

    # https://stackoverflow.com/a/73829204
    # "[node] is trying to resolve by ipv6 first"
    export NODE_OPTIONS="--dns-result-order=ipv4first"
    npm install --omit=dev node-gyp grunt-cli || die "npm install failed"

    # Run npm setup
    npm run setup || die "npm run setup failed"

    cp src/secrets.template.json secrets.json || die "failed to copy src/secrets.template.json to secrets.json"
}

src_install() {
    # Install the Firebot files into the appropriate directory
    insinto /usr/share/firebot
    doins -r "${S}"/* || die "doins failed"
    doins "${FILESDIR}"/instructions.txt instructions.txt || die "instructions.txt failed"

    # Install your start.sh script
    newbin "${FILESDIR}"/start.sh firebot || die "newbin failed"

    # Ensure the start.sh script is executable
    fperms +x /usr/bin/firebot
}

pkg_postinst() {
    elog "To complete the setup of Firebot, please follow these steps:"
    elog "1. Navigate to /usr/share/firebot"
    elog "2. Follow the instructions in /usr/share/firebot/instructions.txt to update /usr/share/firebot/secrets.json"
    elog "You can run Firebot using the 'firebot' command"
}
