From: Patrick Menschel <menschel.p@posteo.de>
Subject: [PATCH 2/2] ARM: dts: sun7i: Add CAN node and can0_pins_a pinctrl settings
Date: Sun, 12 Mar 2017 14:28:11 +0100
Message-ID: <1489325291-6298-3-git-send-email-menschel.p@posteo.de>
References: <1489325291-6298-1-git-send-email-menschel.p@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489325291-6298-1-git-send-email-menschel.p@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Cc: Patrick Menschel <menschel.p@posteo.de>
List-Id: linux-can.vger.kernel.org

The A20 SoC has an on-board CAN controller. This patch adds the device node
and the corresponding pinctrl settings for pins PH20 and PH21.

The CAN controller is inherited from the A10 SoC and uses the same driver.

This patch is adapted from the description in
Documentation/devicetree/bindings/net/can/sun4i_can.txt

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index f7db067..a0417c0 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1390,6 +1390,13 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			can0_pins_a: can0@0 {
+				allwinner,pins = "PH20","PH21";
+				allwinner,function = "can";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 
 		timer@01c20c00 {
@@ -1711,5 +1718,13 @@
 			clocks = <&apb1_gates 7>;
 			status = "disabled";
 		};
+
+		can0: can@01c2bc00 {
+			compatible = "allwinner,sun4i-a10-can";
+			reg = <0x01c2bc00 0x400>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb1_gates 4>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
