From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/7] DT: net: can: rcar_canfd: document R8A77980 bindings
Date: Tue,  8 May 2018 11:28:31 +0200
Message-ID: <20180508092831.28247-8-mkl@pengutronix.de>
References: <20180508092831.28247-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180508092831.28247-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Document the R-Car V3H (R8A77980) SoC support in the R-Car CAN-FD bindings.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index 59dd13aab97f..ac71daa46195 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -7,6 +7,7 @@ Required properties:
   - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
   - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
   - "renesas,r8a77970-canfd" for R8A77970 (R-Car V3M) compatible controller.
+  - "renesas,r8a77980-canfd" for R8A77980 (R-Car V3H) compatible controller.
 
   When compatible with the generic version, nodes must list the
   SoC-specific version corresponding to the platform first, followed by the
-- 
2.17.0
