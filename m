From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 10/20] arm64: dts: renesas: r8a774e1: Add SDHI nodes
Date: Wed, 15 Jul 2020 12:09:00 +0100
Message-ID: <1594811350-14066-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, Niklas <niklas.soderlund@ragnatech.se>, Zhang Rui <rui.zhang@intel.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Magnus Damm <magnus.damm@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, Thomas Gleixner <tglx@linutronix.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: linux-can.vger.kernel.org

Add SDHI[0-2] device nodes to R8A774E1 SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 32 ++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 6ed97187106a..7650152b695b 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -1219,17 +1219,42 @@
 		};
 
 		sdhi0: sd@ee100000 {
+			compatible = "renesas,sdhi-r8a774e1",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee100000 0 0x2000>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			iommus = <&ipmmu_ds1 32>;
 			status = "disabled";
+		};
 
-			/* placeholder */
+		sdhi1: sd@ee120000 {
+			compatible = "renesas,sdhi-r8a774e1",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee120000 0 0x2000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
+			iommus = <&ipmmu_ds1 33>;
+			status = "disabled";
 		};
 
 		sdhi2: sd@ee140000 {
+			compatible = "renesas,sdhi-r8a774e1",
+				     "renesas,rcar-gen3-sdhi";
 			reg = <0 0xee140000 0 0x2000>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
+			iommus = <&ipmmu_ds1 34>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		sdhi3: sd@ee160000 {
@@ -1241,6 +1266,7 @@
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
 			resets = <&cpg 311>;
+			iommus = <&ipmmu_ds1 35>;
 			status = "disabled";
 		};
 
-- 
2.17.1
