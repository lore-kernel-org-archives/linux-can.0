From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH net-next v2 2/3] dt-bindings: can: rcar_canfd: document r8a774b1 support
Date: Thu, 10 Oct 2019 15:25:59 +0100
Message-ID: <1570717560-7431-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570717560-7431-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1570717560-7431-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>
List-Id: linux-can.vger.kernel.org

Document the support for rcar_canfd on R8A774B1 SoC devices.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2:
* Added the R8A774B1 to the clock paragraph according to Geert's comment

 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index a901cd9..13a4e34 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: Must contain one or more of the following:
   - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible controllers.
   - "renesas,r8a774a1-canfd" for R8A774A1 (RZ/G2M) compatible controller.
+  - "renesas,r8a774b1-canfd" for R8A774B1 (RZ/G2N) compatible controller.
   - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
   - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
   - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
@@ -31,8 +32,8 @@ The name of the child nodes are "channel0" and "channel1" respectively. Each
 child node supports the "status" property only, which is used to
 enable/disable the respective channel.
 
-Required properties for R8A774A1, R8A774C0, R8A7795, R8A7796, R8A77965,
-R8A77990, and R8A77995:
+Required properties for R8A774A1, R8A774B1, R8A774C0, R8A7795, R8A7796,
+R8A77965, R8A77990, and R8A77995:
 In the denoted SoCs, canfd clock is a div6 clock and can be used by both CAN
 and CAN FD controller at the same time. It needs to be scaled to maximum
 frequency if any of these controllers use it. This is done using the below
-- 
2.7.4
