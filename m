From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v3 net-next] dt-bindings: can: rcar_can: document r8a77965 support
Date: Mon, 20 Aug 2018 16:49:10 +0200
Message-ID: <20180820144910.13210-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, linux-renesas-soc@vger.kernel.org
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <rosca.eugeniu@gmail.com>
List-Id: linux-can.vger.kernel.org

From: Eugeniu Rosca <rosca.eugeniu@gmail.com>

Document the support for rcar_can on R8A77965 SoC devices.
Add R8A77965 to the list of SoCs which require the "assigned-clocks" and
"assigned-clock-rates" properties (thanks, Sergei).

Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
Changes in v3:
 - [Simon Horman] Added more recipients.
 - [Simon Horman] Dropped redundant "can" word in summary line.
 - [Simon Horman] Added Reviewed-by.
 - [Kieran Bingham] Added Reviewed-by.
Changes in v2:
 - [Kieran Bingham] Simplified commit description. Rewrapped text.
 - [Sergei Shtylyov] Replaced footnotes with inline text.
 - Pushed all dt-bindings patches to the beginning of the series.
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index 94a7f33ac5e9..60daa878c9a2 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -13,6 +13,7 @@ Required properties:
 	      "renesas,can-r8a7794" if CAN controller is a part of R8A7794 SoC.
 	      "renesas,can-r8a7795" if CAN controller is a part of R8A7795 SoC.
 	      "renesas,can-r8a7796" if CAN controller is a part of R8A7796 SoC.
+	      "renesas,can-r8a77965" if CAN controller is a part of R8A77965 SoC.
 	      "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device.
 	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
 	      compatible device.
@@ -28,11 +29,10 @@ Required properties:
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must be "default".
 
-Required properties for "renesas,can-r8a7795" and "renesas,can-r8a7796"
-compatible:
-In R8A7795 and R8A7796 SoCs, "clkp2" can be CANFD clock. This is a div6 clock
-and can be used by both CAN and CAN FD controller at the same time. It needs to
-be scaled to maximum frequency if any of these controllers use it. This is done
+Required properties for R8A7795, R8A7796 and R8A77965:
+For the denoted SoCs, "clkp2" can be CANFD clock. This is a div6 clock and can
+be used by both CAN and CAN FD controller at the same time. It needs to be
+scaled to maximum frequency if any of these controllers use it. This is done
 using the below properties:
 
 - assigned-clocks: phandle of clkp2(CANFD) clock.
-- 
2.18.0
