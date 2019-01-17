From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 0/3] Correct CAN clocks definition
Date: Thu, 17 Jan 2019 14:54:13 +0000
Message-ID: <1547736856-16539-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Dear All,

since we now know that the r8a774a1 is similar to the r8a7796
from a CAN and CANFD perspective, changes to the clocks are in
order.

Thanks,
Fab

Fabrizio Castro (3):
  clk: renesas: r8a774a1: Add missing CANFD clock
  arm64: dts: renesas: r8a774a1: Add clkp2 clock to CAN nodes
  dt-bindings: can: rcar_canfd: Document r8a774a1 support

 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 15 ++++++++-------
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi                | 12 ++++++++----
 drivers/clk/renesas/r8a774a1-cpg-mssr.c                  |  2 ++
 include/dt-bindings/clock/r8a774a1-cpg-mssr.h            |  1 +
 4 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.7.4
