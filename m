From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/7] arm: dts: imx[35]*: declare flexcan devices to be compatible to imx25's flexcan
Date: Tue,  8 May 2018 11:28:27 +0200
Message-ID: <20180508092831.28247-4-mkl@pengutronix.de>
References: <20180508092831.28247-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180508092831.28247-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Commit d50f4630c2e1 ("arm: dts: Remove p1010-flexcan compatible from imx
series dts") removed the fallback compatible "fsl,p1010-flexcan" from
the imx device trees. As the flexcan cores on i.MX25, i.MX35 and i.MX53
are identical, introduce the first as fallback for the two latter ones.

Fixes: d50f4630c2e1 ("arm: dts: Remove p1010-flexcan compatible from imx series dts")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org> # >= v4.16
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/imx35.dtsi | 4 ++--
 arch/arm/boot/dts/imx53.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index bf343195697e..54111ed218b1 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -303,7 +303,7 @@
 			};
 
 			can1: can@53fe4000 {
-				compatible = "fsl,imx35-flexcan";
+				compatible = "fsl,imx35-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fe4000 0x1000>;
 				clocks = <&clks 33>, <&clks 33>;
 				clock-names = "ipg", "per";
@@ -312,7 +312,7 @@
 			};
 
 			can2: can@53fe8000 {
-				compatible = "fsl,imx35-flexcan";
+				compatible = "fsl,imx35-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fe8000 0x1000>;
 				clocks = <&clks 34>, <&clks 34>;
 				clock-names = "ipg", "per";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 7d647d043f52..3d65c0192f69 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -551,7 +551,7 @@
 			};
 
 			can1: can@53fc8000 {
-				compatible = "fsl,imx53-flexcan";
+				compatible = "fsl,imx53-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fc8000 0x4000>;
 				interrupts = <82>;
 				clocks = <&clks IMX5_CLK_CAN1_IPG_GATE>,
@@ -561,7 +561,7 @@
 			};
 
 			can2: can@53fcc000 {
-				compatible = "fsl,imx53-flexcan";
+				compatible = "fsl,imx53-flexcan", "fsl,imx25-flexcan";
 				reg = <0x53fcc000 0x4000>;
 				interrupts = <83>;
 				clocks = <&clks IMX5_CLK_CAN2_IPG_GATE>,
-- 
2.17.0
