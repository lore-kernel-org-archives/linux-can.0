From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 0/3] Add CAN and CAN-FD support to RZ/G2N SoC
Date: Thu, 10 Oct 2019 13:37:26 +0100
Message-ID: <1570711049-5691-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>
List-Id: linux-can.vger.kernel.org

Dear All,

this series adds CAN and CAN FD support to the RZ/G2N SoC specific dtsi.

Thanks,
Fab

Fabrizio Castro (3):
  dt-bindings: can: rcar_can: Add r8a774b1 support
  dt-bindings: can: rcar_canfd: document r8a774b1 support
  arm64: dts: renesas: r8a774b1: Add CAN and CAN FD support

 .../devicetree/bindings/net/can/rcar_can.txt       |  5 ++-
 .../devicetree/bindings/net/can/rcar_canfd.txt     |  1 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          | 48 ++++++++++++++++++++--
 3 files changed, 49 insertions(+), 5 deletions(-)

-- 
2.7.4
