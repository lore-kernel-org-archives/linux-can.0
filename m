From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH] dt-bindings: can: rcar_can: Add r8a7744 support
Date: Thu, 27 Sep 2018 13:08:48 +0100
Message-ID: <1538050128-47356-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Biju Das <biju.das@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Document RZ/G1N (r8a7744) SoC specific bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
This patch is tested against linux-next next-20180927
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index 94a7f33..cc43728 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -3,6 +3,7 @@ Renesas R-Car CAN controller Device Tree Bindings
 
 Required properties:
 - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
+	      "renesas,can-r8a7744" if CAN controller is a part of R8A7744 SoC.
 	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
 	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
 	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
-- 
2.7.4
