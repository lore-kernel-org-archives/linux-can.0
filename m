From: Patrick Menschel <menschel.p@posteo.de>
Subject: [PATCH v4 4/6] ARM: dts: sun7i: fix device node ordering
Date: Tue,  4 Apr 2017 20:36:30 +0200
Message-ID: <1491330992-9876-5-git-send-email-menschel.p@posteo.de>
References: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Cc: Patrick Menschel <menschel.p@posteo.de>
List-Id: linux-can.vger.kernel.org

This patch changes the device node position of ps20 and ps21 to fix
ordering by rising physical address.

From

uart7: serial@01c29c00
i2c0: i2c@01c2ac00
i2c1: i2c@01c2b000
i2c2: i2c@01c2b400
i2c3: i2c@01c2b800
i2c4: i2c@01c2c000
gmac: ethernet@01c50000
hstimer@01c60000
gic: interrupt-controller@01c81000
ps20: ps2@01c2a000
ps21: ps2@01c2a400

to

uart7: serial@01c29c00
ps20: ps2@01c2a000
ps21: ps2@01c2a400
i2c0: i2c@01c2ac00
i2c1: i2c@01c2b000
i2c2: i2c@01c2b400
i2c3: i2c@01c2b800
i2c4: i2c@01c2c000
gmac: ethernet@01c50000
hstimer@01c60000
gic: interrupt-controller@01c81000

Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 2db97fc..100b4e9 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1538,6 +1538,22 @@
 			status = "disabled";
 		};
 
+		ps20: ps2@01c2a000 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a000 0x400>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb1_gates 6>;
+			status = "disabled";
+		};
+
+		ps21: ps2@01c2a400 {
+			compatible = "allwinner,sun4i-a10-ps2";
+			reg = <0x01c2a400 0x400>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb1_gates 7>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@01c2ac00 {
 			compatible = "allwinner,sun7i-a20-i2c",
 				     "allwinner,sun4i-a10-i2c";
@@ -1629,20 +1645,5 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
-		ps20: ps2@01c2a000 {
-			compatible = "allwinner,sun4i-a10-ps2";
-			reg = <0x01c2a000 0x400>;
-			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb1_gates 6>;
-			status = "disabled";
-		};
-
-		ps21: ps2@01c2a400 {
-			compatible = "allwinner,sun4i-a10-ps2";
-			reg = <0x01c2a400 0x400>;
-			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb1_gates 7>;
-			status = "disabled";
-		};
 	};
 };
-- 
2.7.4
