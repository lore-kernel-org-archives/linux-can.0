From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH v4 5/6] arm: dts: Remove p1010-flexcan compatible from imx series dts
Date: Fri, 24 Nov 2017 18:52:12 +0530
Message-ID: <1511529733-27942-6-git-send-email-pankaj.bansal@nxp.com>
References: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-cys01nam02on0041.outbound.protection.outlook.com ([104.47.37.41]:19456
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752681AbdKXNSx (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 24 Nov 2017 08:18:53 -0500
In-Reply-To: <1511529733-27942-1-git-send-email-pankaj.bansal@nxp.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Pankaj Bansal <pankaj.bansal@nxp.com>

The flexcan driver has been modified to check for big-endian dts
property for be read/write to flexcan registers/mb.

An exception to this rule is powerpc P1010RDB, which is always
big-endian, even if big-endian is not present in dts. This is
checked using p1010-flexcan compatible in dts.

Therefore, remove p1010-flexcan compatible from imx series dts,
as their flexcan core is little endian.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---
Changes in v4:
  - Merged device tree changes and driver changes in one series
Changes in v3:
  - No change.
Changes in v2:
  - Add this patch in series.

 arch/arm/boot/dts/imx25.dtsi | 4 ++--
 arch/arm/boot/dts/imx28.dtsi | 4 ++--
 arch/arm/boot/dts/imx35.dtsi | 4 ++--
 arch/arm/boot/dts/imx53.dtsi | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 09ce8b8..fcaff1c 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -122,7 +122,7 @@
 			};
 
 			can1: can@43f88000 {
-				compatible = "fsl,imx25-flexcan", "fsl,p1010-flexcan";
+				compatible = "fsl,imx25-flexcan";
 				reg = <0x43f88000 0x4000>;
 				interrupts = <43>;
 				clocks = <&clks 75>, <&clks 75>;
@@ -131,7 +131,7 @@
 			};
 
 			can2: can@43f8c000 {
-				compatible = "fsl,imx25-flexcan", "fsl,p1010-flexcan";
+				compatible = "fsl,imx25-flexcan";
 				reg = <0x43f8c000 0x4000>;
 				interrupts = <44>;
 				clocks = <&clks 76>, <&clks 76>;
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 2f4ebe0..e52e05c 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1038,7 +1038,7 @@
 			};
 
 			can0: can@80032000 {
-				compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
+				compatible = "fsl,imx28-flexcan";
 				reg = <0x80032000 0x2000>;
 				interrupts = <8>;
 				clocks = <&clks 58>, <&clks 58>;
@@ -1047,7 +1047,7 @@
 			};
 
 			can1: can@80034000 {
-				compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
+				compatible = "fsl,imx28-flexcan";
 				reg = <0x80034000 0x2000>;
 				interrupts = <9>;
 				clocks = <&clks 59>, <&clks 59>;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 6d5e6a6..1f0e220 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -303,7 +303,7 @@
 			};
 
 			can1: can@53fe4000 {
-				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
+				compatible = "fsl,imx35-flexcan";
 				reg = <0x53fe4000 0x1000>;
 				clocks = <&clks 33>, <&clks 33>;
 				clock-names = "ipg", "per";
@@ -312,7 +312,7 @@
 			};
 
 			can2: can@53fe8000 {
-				compatible = "fsl,imx35-flexcan", "fsl,p1010-flexcan";
+				compatible = "fsl,imx35-flexcan";
 				reg = <0x53fe8000 0x1000>;
 				clocks = <&clks 34>, <&clks 34>;
 				clock-names = "ipg", "per";
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 8bf0d89..85573cf 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -545,7 +545,7 @@
 			};
 
 			can1: can@53fc8000 {
-				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
+				compatible = "fsl,imx53-flexcan";
 				reg = <0x53fc8000 0x4000>;
 				interrupts = <82>;
 				clocks = <&clks IMX5_CLK_CAN1_IPG_GATE>,
@@ -555,7 +555,7 @@
 			};
 
 			can2: can@53fcc000 {
-				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
+				compatible = "fsl,imx53-flexcan";
 				reg = <0x53fcc000 0x4000>;
 				interrupts = <83>;
 				clocks = <&clks IMX5_CLK_CAN2_IPG_GATE>,
-- 
2.7.4

