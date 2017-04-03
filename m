From: Patrick Menschel <menschel.p@posteo.de>
Subject: [PATCH v3 2/4] ARM: dts: sun4i: Add can0_pins_a pinctrl settings
Date: Mon,  3 Apr 2017 19:00:12 +0200
Message-ID: <1491238814-4888-3-git-send-email-menschel.p@posteo.de>
References: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Cc: Patrick Menschel <menschel.p@posteo.de>
List-Id: linux-can.vger.kernel.org

The A10 SoC has an on-board CAN controller. This patch adds the
pinctrl settings for pins PH20 and PH21.

This patch is adapted from the description in
Documentation/devicetree/bindings/net/can/sun4i_can.txt

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 7c559e7..f7dced4 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -974,6 +974,11 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			can0_pins_a: can0@0 {
+				pins = "PH20","PH21";
+				function = "can";
+			};
+
 			emac_pins_a: emac0@0 {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
-- 
1.9.1
