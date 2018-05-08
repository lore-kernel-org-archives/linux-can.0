From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/7] dt-bindings: can: rcar_can: Fix R8A7796 SoC name
Date: Tue,  8 May 2018 11:28:29 +0200
Message-ID: <20180508092831.28247-6-mkl@pengutronix.de>
References: <20180508092831.28247-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180508092831.28247-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Geert Uytterhoeven <geert+renesas@glider.be>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

R8A7796 is R-Car M3-W.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index 93c3a6ae32f9..1a4ee1d2506d 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -5,7 +5,7 @@ Required properties:
 - compatible: Must contain one or more of the following:
   - "renesas,rcar-gen3-canfd" for R-Car Gen3 compatible controller.
   - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
-  - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3) compatible controller.
+  - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
 
   When compatible with the generic version, nodes must list the
   SoC-specific version corresponding to the platform first, followed by the
-- 
2.17.0
