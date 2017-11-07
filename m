From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 1/8] dt-bindings: can: rcar_can: document r8a774[35] can support
Date: Tue,  7 Nov 2017 15:10:42 +0000
Message-ID: <1510067449-17017-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1510067449-17017-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1510067449-17017-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
List-Id: linux-can.vger.kernel.org

Document "renesas,can-r8a7743" and "renesas,can-r8a7745" compatible
strings. Since the fallback compatible string ("renesas,rcar-gen2-can")
activates the right code in the driver, no driver change is needed.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index 06bb7cc..94a7f33 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -2,7 +2,9 @@ Renesas R-Car CAN controller Device Tree Bindings
 -------------------------------------------------
 
 Required properties:
-- compatible: "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
+- compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
+	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
+	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
 	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
 	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
 	      "renesas,can-r8a7791" if CAN controller is a part of R8A7791 SoC.
@@ -12,7 +14,8 @@ Required properties:
 	      "renesas,can-r8a7795" if CAN controller is a part of R8A7795 SoC.
 	      "renesas,can-r8a7796" if CAN controller is a part of R8A7796 SoC.
 	      "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device.
-	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 compatible device.
+	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
+	      compatible device.
 	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
 	      When compatible with the generic version, nodes must list the
 	      SoC-specific version corresponding to the platform first
-- 
2.7.4
