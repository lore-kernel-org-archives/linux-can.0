From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 5/7] arm64: dts: r8a77995: Add CAN FD support
Date: Fri, 17 Nov 2017 11:41:27 +0100
Message-ID: <1510915289-15059-6-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com, chris.paterson2@renesas.com, ramesh.shanmugasundaram@bp.renesas.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-can.vger.kernel.org

Adds CAN FD controller node for r8a77995.

Based on a patch for r8a7796 by Chris Paterson.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index a611324..6648c9b 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -306,6 +306,31 @@
 			status = "disabled";
 		};
 
+		canfd: can@e66c0000 {
+			compatible = "renesas,r8a77995-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			       <&cpg CPG_CORE R8A77995_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77995_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
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
+		};
+
 		avb: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a77995",
 				     "renesas,etheravb-rcar-gen3";
-- 
2.7.4
