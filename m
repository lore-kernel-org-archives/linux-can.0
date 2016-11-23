From: Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH 3/3] arm64: dts: r8a7796: Add CAN FD support
Date: Wed, 23 Nov 2016 12:14:48 +0000
Message-ID: <1479903288-2009-1-git-send-email-chris.paterson2@renesas.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:45909 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934812AbcKWMPB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Nov 2016 07:15:01 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Simon Horman <horms@verge.net.au>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, Chris Paterson <chris.paterson2@renesas.com>

Adds CAN FD controller node for r8a7796.

Based on a patch for r8a7795 by Ramesh Shanmugasundaram.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .../devicetree/bindings/net/can/rcar_canfd.txt     | 12 ++++++-----
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 24 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index 22a6f10..788f273 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: Must contain one or more of the following:
   - "renesas,rcar-gen3-canfd" for R-Car Gen3 compatible controller.
   - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
+  - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3) compatible controller.
 
   When compatible with the generic version, nodes must list the
   SoC-specific version corresponding to the platform first, followed by the
@@ -23,11 +24,12 @@ The name of the child nodes are "channel0" and "channel1" respectively. Each
 child node supports the "status" property only, which is used to
 enable/disable the respective channel.
 
-Required properties for "renesas,r8a7795-canfd" compatible:
-In R8A7795 SoC, canfd clock is a div6 clock and can be used by both CAN
-and CAN FD controller at the same time. It needs to be scaled to maximum
-frequency if any of these controllers use it. This is done using the
-below properties.
+Required properties for "renesas,r8a7795-canfd" and "renesas,r8a7796-canfd"
+compatible:
+In R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock and can be used by both
+CAN and CAN FD controller at the same time. It needs to be scaled to maximum
+frequency if any of these controllers use it. This is done using the below
+properties:
 
 - assigned-clocks: phandle of canfd clock.
 - assigned-clock-rates: maximum frequency of this clock.
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 95857fc..c069d77 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -392,6 +392,30 @@
 			status = "disabled";
 		};
 
+		canfd: can@e66c0000 {
+			compatible = "renesas,r8a7796-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			       <&cpg CPG_CORE R8A7796_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
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
 		scif2: serial@e6e88000 {
 			compatible = "renesas,scif-r8a7796",
 				     "renesas,rcar-gen3-scif", "renesas,scif";
-- 
1.9.1

