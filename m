From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: [PATCH v2 3/4] arm/dts: Add nodes for flexcan devices present on LS1021A-Rev2 SoC
Date: Thu, 23 Nov 2017 15:25:34 +0530
Message-ID: <1511430935-29783-3-git-send-email-pankaj.bansal@nxp.com>
References: <1511430935-29783-1-git-send-email-pankaj.bansal@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-cys01nam02on0052.outbound.protection.outlook.com ([104.47.37.52]:2561
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752545AbdKWJwH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 Nov 2017 04:52:07 -0500
In-Reply-To: <1511430935-29783-1-git-send-email-pankaj.bansal@nxp.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: V.Sethi@nxp.com, poonam.aggrwal@nxp.com, Pankaj Bansal <pankaj.bansal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Sakar Arora <Sakar.Arora@freescale.com>

This patch adds the device nodes for flexcan controller(s) present on
LS1021A-Rev2 SoC.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
Reviewed-by: Zhengxiong Jin <Jason.Jin@freescale.com>
Reviewed-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
---
Changes in v2:
  - No change.
  - Added one more patch in series.

 arch/arm/boot/dts/ls1021a-qds.dts | 16 +++++++++++++
 arch/arm/boot/dts/ls1021a-twr.dts | 16 +++++++++++++
 arch/arm/boot/dts/ls1021a.dtsi    | 36 +++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 9408753..4f211e3 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -331,3 +331,19 @@
 &uart1 {
 	status = "okay";
 };
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "disabled";
+};
+
+&can3 {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index a8b148a..7202d9c 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -243,3 +243,19 @@
 &uart1 {
 	status = "okay";
 };
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "disabled";
+};
+
+&can3 {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9319e1f..7789031 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -730,5 +730,41 @@
 					<0000 0 0 3 &gic GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		can0: can@2a70000 {
+			compatible = "fsl,ls1021ar2-flexcan";
+			reg = <0x0 0x2a70000 0x0 0x1000>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			big-endian;
+		};
+
+		can1: can@2a80000 {
+			compatible = "fsl,ls1021ar2-flexcan";
+			reg = <0x0 0x2a80000 0x0 0x1000>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			big-endian;
+		};
+
+		can2: can@2a90000 {
+			compatible = "fsl,ls1021ar2-flexcan";
+			reg = <0x0 0x2a90000 0x0 0x1000>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			big-endian;
+		};
+
+		can3: can@2aa0000 {
+			compatible = "fsl,ls1021ar2-flexcan";
+			reg = <0x0 0x2aa0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			big-endian;
+		};
 	};
 };
-- 
2.7.4

