From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 0/6] More CAN support for RZ/G2 devices
Date: Fri, 14 Jun 2019 12:53:28 +0100
Message-ID: <1560513214-28031-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, xu_shunji@hoperun.com
List-Id: linux-can.vger.kernel.org

Dear All,

This series adds CAN and CANFD support to the HiHope RZ/G2M, and also
improves SoC support for the RZ/G2E.
Please note that I wasn't able to test CAN-FD mode but only classical
CAN mode with the CANFD IP, my unit unfortunately comes with CAN-FD
mode disabled in HW, but the CANFD IP is working and responding
correctly while in classical mode.

Please note that this work depends on:
https://patchwork.kernel.org/cover/10986911/
https://patchwork.kernel.org/cover/10990113/

Thanks,
Fab

Fabrizio Castro (6):
  dt-bindings: can: rcar_canfd: document r8a774a1 support
  dt-bindings: can: rcar_can: Complete documentation for RZ/G2[EM]
  arm64: dts: renesas: r8a774c0: Add missing assigned-clocks for CAN[01]
  arm64: dts: renesas: r8a774a1: Add missing assigned-clocks for CAN[01]
  arm64: dts: renesas: r8a774a1: Add CANFD support
  arm64: dts: renesas: hihope-rzg2-ex: Enable CAN interfaces

 .../devicetree/bindings/net/can/rcar_can.txt       |  2 +-
 .../devicetree/bindings/net/can/rcar_canfd.txt     |  9 ++++---
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi    | 22 ++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          | 29 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |  4 +++
 5 files changed, 61 insertions(+), 5 deletions(-)

-- 
2.7.4
