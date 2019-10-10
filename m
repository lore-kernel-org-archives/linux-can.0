From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH net-next 2/3] dt-bindings: can: rcar_canfd: document r8a774b1 support
Date: Thu, 10 Oct 2019 13:37:28 +0100
Message-ID: <1570711049-5691-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570711049-5691-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1570711049-5691-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>
List-Id: linux-can.vger.kernel.org

Document the support for rcar_canfd on R8A774B1 SoC devices.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index a901cd9..5761147 100644
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
-- 
2.7.4
