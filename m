From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 0/8] Add CAN support to iwg2[02]d
Date: Tue,  7 Nov 2017 15:10:41 +0000
Message-ID: <1510067449-17017-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
List-Id: linux-can.vger.kernel.org

Hello,

this series delivers all of the changes necessary to add CAN bus
support to the:
* iW-RainboW-G22D SODIMM, and
* iW-RainboW-G20M-Qseven-RZG1M
development platforms, including documentation, pinctrl driver, SoC
specific device trees, and board specific device trees.

This work has been based and tested on top of:
renesas-devel-20171106-v4.14-rc8

Best regards,

Fabrizio Castro (8):
  dt-bindings: can: rcar_can: document r8a774[35] can support
  pinctrl: sh-pfc: r8a7745: Add CAN[01] support
  ARM: dts: r8a7745: Add CAN[01] SoC support
  ARM: dts: iwg22d-sodimm: Add can0 support to carrier board
  ARM: dts: iwg22d-sodimm-dbhd-ca: Add can1 support to HDMI DB
  ARM: dts: r8a7743: Add CAN[01] SoC support
  ARM: dts: iwg20d-q7-common: Add can0 support to carrier board
  ARM: dts: iwg20d-q7-dbcm-ca: Add can1 support to camera DB

 .../devicetree/bindings/net/can/rcar_can.txt       |   7 +-
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |  12 ++
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi           |  12 ++
 arch/arm/boot/dts/r8a7743.dtsi                     |  36 +++++
 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts |  12 ++
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts        |  12 ++
 arch/arm/boot/dts/r8a7745.dtsi                     |  36 +++++
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c               | 146 +++++++++++++++++++++
 8 files changed, 271 insertions(+), 2 deletions(-)

-- 
2.7.4
