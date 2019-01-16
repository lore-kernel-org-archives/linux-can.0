From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 02/11] dt-bindings: arm: renesas: Add si-linux cat87[45] boards
Date: Wed, 16 Jan 2019 18:37:45 +0000
Message-ID: <1547663874-29411-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben Whitten <ben.whitten@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.orglinux-
List-Id: linux-can.vger.kernel.org

This patch adds board cat874 (powered by the RZ/G2E) and board
cat875 (that sits on top of cat874). Both boards are made by
Silicon Linux.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 Documentation/devicetree/bindings/arm/renesas.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 5e9d486..9e1e07b 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -108,6 +108,14 @@ properties:
 
       - description: RZ/G2E (R8A774C0)
         items:
+          - enum:
+              - si-linux,cat874 # Silicon Linux RZ/G2E 96board platform (CAT874)
+          - const: renesas,r8a774c0
+
+      - items:
+          - enum:
+              - si-linux,cat875 # Silicon Linux sub board for CAT874 (CAT875)
+          - const: si-linux,cat874
           - const: renesas,r8a774c0
 
       - description: R-Car M1A (R8A77781)
-- 
2.7.4
