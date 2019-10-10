From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 3/3] arm64: dts: renesas: r8a774b1: Add CAN and CAN FD support
Date: Thu, 10 Oct 2019 13:37:29 +0100
Message-ID: <1570711049-5691-4-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570711049-5691-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1570711049-5691-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>
List-Id: linux-can.vger.kernel.org

Add CAN and CAN FD support to the RZ/G2N SoC specific dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 48 +++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 80b8b2e..bfea6df 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -994,18 +994,60 @@
 		};
 
 		can0: can@e6c30000 {
+			compatible = "renesas,can-r8a774b1",
+				     "renesas,rcar-gen3-can";
 			reg = <0 0xe6c30000 0 0x1000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+				 <&cpg CPG_CORE R8A774B1_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A774B1_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
+			status = "disabled";
 		};
 
 		can1: can@e6c38000 {
+			compatible = "renesas,can-r8a774b1",
+				     "renesas,rcar-gen3-can";
 			reg = <0 0xe6c38000 0 0x1000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+				 <&cpg CPG_CORE R8A774B1_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A774B1_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
+			status = "disabled";
 		};
 
 		canfd: can@e66c0000 {
+			compatible = "renesas,r8a774b1-canfd",
+				     "renesas,rcar-gen3-canfd";
 			reg = <0 0xe66c0000 0 0x8000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+				 <&cpg CPG_CORE R8A774B1_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A774B1_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
 		};
 
 		pwm0: pwm@e6e30000 {
-- 
2.7.4
