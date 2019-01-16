From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 00/11] Add basic EK874 support
Date: Wed, 16 Jan 2019 18:37:43 +0000
Message-ID: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben Whitten <ben.whitten@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.orglinux-
List-Id: linux-can.vger.kernel.org

Dear All,

The EK874 is an evaluation kit for the RZ/G2E SoC (a.k.a. r8a774c0)
from Silicon Linux Corporation. It is made of two boards: cat874
(the main board) and cat875 (the sub board).

This series adds the device trees to describe the HW configuration
of the EK874, with some basic support.

This applies onto next-20190116

Thanks,
Fab

Biju Das (6):
  dt-bindings: Add vendor prefix for Silicon Linux.
  arm64: dts: renesas: Add Si-Linux CAT874 board support
  arm64: dts: renesas: Add Si-Linux EK874 board support
  arm64: dts: renesas: r8a774c0-cat874: Add pincontrol support to scif2
  arm64: dts: renesas: r8a774c0-cat874: Add uSD support
  arm64: dts: renesas: cat875: Add ethernet support

Fabrizio Castro (5):
  dt-bindings: arm: renesas: Add si-linux cat87[45] boards
  clk: renesas: r8a774c0: Add missing CANFD clock
  dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
  arm64: dts: renesas: r8a774c0: Add clkp2 clock to CAN nodes
  dt-bindings: can: rcar_canfd: document r8a774c0 support

 Documentation/devicetree/bindings/arm/renesas.yaml |  8 ++
 .../devicetree/bindings/net/can/rcar_can.txt       | 12 +--
 .../devicetree/bindings/net/can/rcar_canfd.txt     | 16 ++--
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm64/boot/dts/renesas/Makefile               |  1 +
 arch/arm64/boot/dts/renesas/cat875.dtsi            | 40 +++++++++
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    | 97 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts     | 14 ++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 12 ++-
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |  4 +
 include/dt-bindings/clock/r8a774c0-cpg-mssr.h      | 17 ++--
 11 files changed, 194 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/cat875.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts

-- 
2.7.4
