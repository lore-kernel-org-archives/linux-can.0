From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 3/3] dt-bindings: can: rcar_canfd: Document r8a774a1 support
Date: Thu, 17 Jan 2019 14:54:16 +0000
Message-ID: <1547736856-16539-4-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1547736856-16539-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1547736856-16539-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Document support for rcar_canfd on R8A774A1 SoC devices.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
This patch depends on:
https://patchwork.kernel.org/patch/10766781/

 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index 32f051f..fd353a9 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -4,6 +4,7 @@ Renesas R-Car CAN FD controller Device Tree Bindings
 Required properties:
 - compatible: Must contain one or more of the following:
   - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible controllers.
+  - "renesas,r8a774a1-canfd" for R8A774A1 (RZ/G2M) compatible controller.
   - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
   - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
   - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
@@ -29,13 +30,13 @@ The name of the child nodes are "channel0" and "channel1" respectively. Each
 child node supports the "status" property only, which is used to
 enable/disable the respective channel.
 
-Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd",
-"renesas,r8a7796-canfd", "renesas,r8a77965-canfd", and "renesas,r8a77990-canfd"
-compatible:
-In R8A774C0, R8A7795, R8A7796, R8A77965, and R8A77990 SoCs, canfd clock is a
-div6 clock and can be used by both CAN and CAN FD controller at the same time.
-It needs to be scaled to maximum frequency if any of these controllers use it.
-This is done using the below properties:
+Required properties for "renesas,r8a774a1-canfd", "renesas,r8a774c0-canfd",
+"renesas,r8a7795-canfd", "renesas,r8a7796-canfd", "renesas,r8a77965-canfd", and
+"renesas,r8a77990-canfd" compatible:
+In R8A774A1, R8A774C0, R8A7795, R8A7796, R8A77965, and R8A77990 SoCs, canfd
+clock is a div6 clock and can be used by both CAN and CAN FD controller at the
+same time. It needs to be scaled to maximum frequency if any of these
+controllers use it. This is done using the below properties:
 
 - assigned-clocks: phandle of canfd clock.
 - assigned-clock-rates: maximum frequency of this clock.
-- 
2.7.4
