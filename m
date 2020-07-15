From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 00/20] Add support for [H]SCIF/TMU/CMT/THS/SDHI/MSIOF/CAN[FD]/I2C/IIC/RWDT on R8A774E1
Date: Wed, 15 Jul 2020 12:08:50 +0100
Message-ID: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, Niklas <niklas.soderlund@ragnatech.se>, Zhang Rui <rui.zhang@intel.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Magnus Damm <magnus.damm@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, Thomas Gleixner <tglx@linutronix.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: linux-can.vger.kernel.org

Hi All,

This patch series enables support for following on RZ/G2H SoC,
* CPU OPP
* THS
* CMT/TMU
* I2C/IIC
* MSIOF
* RWDT
* SDHI
* SCIF/HSCIF
* CAN/CANFD

Cheers,
Prabhakar

Lad Prabhakar (14):
  dt-bindings: thermal: rcar-gen3-thermal: Add r8a774e1 support
  dt-bindings: timer: renesas,cmt: Document r8a774e1 CMT support
  arm64: dts: renesas: r8a774e1: Add SCIF and HSCIF nodes
  arm64: dts: renesas: r8a774e1: Add SDHI nodes
  dt-bindings: i2c: renesas,i2c: Document r8a774e1 support
  dt-bindings: i2c: renesas,iic: Document r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add I2C and IIC-DVFS support
  dt-bindings: spi: renesas,sh-msiof: Add r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add MSIOF nodes
  dt-bindings: watchdog: renesas,wdt: Document r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add RWDT node
  dt-bindings: can: rcar_can: Document r8a774e1 support
  dt-bindings: can: rcar_canfd: Document r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add CAN[FD] support

Marian-Cristian Rotariu (6):
  arm64: dts: renesas: r8a774e1: Add operating points
  thermal: rcar_gen3_thermal: Add r8a774e1 support
  arm64: dts: renesas: r8a774e1: Add RZ/G2H thermal support
  arm64: dts: renesas: r8a774e1: Add CMT device nodes
  dt-bindings: timer: renesas,tmu: Document r8a774e1 bindings
  arm64: dts: renesas: r8a774e1: Add TMU device nodes

 .../devicetree/bindings/i2c/renesas,i2c.txt   |   1 +
 .../devicetree/bindings/i2c/renesas,iic.txt   |   1 +
 .../devicetree/bindings/net/can/rcar_can.txt  |   1 +
 .../bindings/net/can/rcar_canfd.txt           |   1 +
 .../bindings/spi/renesas,sh-msiof.yaml        |   1 +
 .../bindings/thermal/rcar-gen3-thermal.yaml   |   1 +
 .../bindings/timer/renesas,cmt.yaml           |   2 +
 .../devicetree/bindings/timer/renesas,tmu.txt |   1 +
 .../bindings/watchdog/renesas,wdt.yaml        |   1 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi     | 713 +++++++++++++++++-
 drivers/thermal/rcar_gen3_thermal.c           |   4 +
 11 files changed, 715 insertions(+), 12 deletions(-)

-- 
2.17.1
