From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH repost 0/5] Repost CAN and CANFD dt-bindings
Date: Thu,  9 May 2019 20:20:17 +0100
Message-ID: <1557429622-31676-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Dear All,

I am reposting some CAN and CANFD related dt-bindings changes for
Renesas' R-Car and RZ/G devices that have been originally sent
end of last year and beginning of this year.

Thanks,
Fab

Fabrizio Castro (3):
  dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
  dt-bindings: can: rcar_can: Add r8a774c0 support
  dt-bindings: can: rcar_canfd: document r8a774c0 support

Marek Vasut (2):
  dt-bindings: can: rcar_canfd: document r8a77965 support
  dt-bindings: can: rcar_canfd: document r8a77990 support

 Documentation/devicetree/bindings/net/can/rcar_can.txt   | 13 ++++---------
 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 16 ++++++++++------
 2 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.7.4
