From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clkp2 clock to CAN nodes
Date: Thu, 17 Jan 2019 14:54:15 +0000
Message-ID: <1547736856-16539-3-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1547736856-16539-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1547736856-16539-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-can.vger.kernel.org

According to the latest information, clkp2 is available on RZ/G2.
Modify CAN0 and CAN1 nodes accordingly.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 46a8fd2..71066d4 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -879,8 +879,10 @@
 				     "renesas,rcar-gen3-can";
 			reg = <0 0xe6c30000 0 0x1000>;
 			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 916>, <&can_clk>;
-			clock-names = "clkp1", "can_clk";
+			clocks = <&cpg CPG_MOD 916>,
+				 <&cpg CPG_CORE R8A774A1_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 916>;
 			status = "disabled";
@@ -891,8 +893,10 @@
 				     "renesas,rcar-gen3-can";
 			reg = <0 0xe6c38000 0 0x1000>;
 			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 915>, <&can_clk>;
-			clock-names = "clkp1", "can_clk";
+			clocks = <&cpg CPG_MOD 915>,
+				 <&cpg CPG_CORE R8A774A1_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 915>;
 			status = "disabled";
-- 
2.7.4
