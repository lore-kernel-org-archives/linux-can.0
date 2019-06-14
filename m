From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 2/6] dt-bindings: can: rcar_can: Complete documentation for RZ/G2[EM]
Date: Fri, 14 Jun 2019 12:53:30 +0100
Message-ID: <1560513214-28031-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1560513214-28031-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1560513214-28031-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Add missing RZ/G2[EM] CANFD clock specific documentation.

Fixes: 868b7c0f43e6 ("dt-bindings: can: rcar_can: Add r8a774a1 support")
Fixes: 0c11e7d0f51c ("dt-bindings: can: rcar_can: Add r8a774c0 support")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
Hello Simon,

I think it would make more sense if this patch went through you as it
sits on series:
https://lkml.org/lkml/2019/5/9/941

Do you think that's doable?

Thanks,
Fab

 Documentation/devicetree/bindings/net/can/rcar_can.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index b463e12..e1f315a 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -33,7 +33,7 @@ Required properties:
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must be "default".
 
-Required properties for R8A7795, R8A7796 and R8A77965:
+Required properties for R8A774A1, R8A774C0, R8A7795, R8A7796 and R8A77965:
 For the denoted SoCs, "clkp2" can be CANFD clock. This is a div6 clock and can
 be used by both CAN and CAN FD controller at the same time. It needs to be
 scaled to maximum frequency if any of these controllers use it. This is done
-- 
2.7.4
