From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 2/2] can: rcar_canfd: document r8a77995 (R-Car D3) compatibility strings
Date: Mon, 18 Dec 2017 16:51:37 +0100
Message-ID: <1513612297-10173-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1513612297-10173-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513612297-10173-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com, chris.paterson2@renesas.com, ramesh.shanmugasundaram@bp.renesas.com, robh@kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-can.vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index 93c3a6a..eeb9fec 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -6,6 +6,7 @@ Required properties:
   - "renesas,rcar-gen3-canfd" for R-Car Gen3 compatible controller.
   - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
   - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3) compatible controller.
+  - "renesas,r8a77995-canfd" for R8A77995 (R-Car D3) compatible controller.
 
   When compatible with the generic version, nodes must list the
   SoC-specific version corresponding to the platform first, followed by the
@@ -24,12 +25,12 @@ The name of the child nodes are "channel0" and "channel1" respectively. Each
 child node supports the "status" property only, which is used to
 enable/disable the respective channel.
 
-Required properties for "renesas,r8a7795-canfd" and "renesas,r8a7796-canfd"
-compatible:
-In R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock and can be used by both
-CAN and CAN FD controller at the same time. It needs to be scaled to maximum
-frequency if any of these controllers use it. This is done using the below
-properties:
+Required properties for "renesas,r8a7795-canfd", "renesas,r8a7796-canfd" and
+"renesas,r8a77995-canfd" compatible:
+In R8A7795, R8A7796 and R8A77995 SoCs, canfd clock is a div6 clock and can
+be used by both CAN and CAN FD controller at the same time. It needs to be
+scaled to maximum frequency if any of these controllers use it. This is
+done using the below properties:
 
 - assigned-clocks: phandle of canfd clock.
 - assigned-clock-rates: maximum frequency of this clock.
-- 
2.7.4
