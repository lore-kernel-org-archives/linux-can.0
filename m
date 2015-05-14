From: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Subject: [PATCH v2 2/5] arm/dts: Add nodes for flexcan devices present on LS1021A SoC
Date: Thu, 14 May 2015 17:03:32 +0530
Message-ID: <1431603215-25546-3-git-send-email-bhupesh.sharma@freescale.com>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2on0114.outbound.protection.outlook.com ([207.46.100.114]:46004
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751830AbbENLeQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 14 May 2015 07:34:16 -0400
In-Reply-To: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: arnd@arndb.de, linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: bhupesh.linux@gmail.com, bhupesh.sharma@freescale.com, Sakar.Arora@freescale.com, linux-arm-kernel@lists.infradead.org

From: Sakar Arora <Sakar.Arora@freescale.com>

This patch adds the device nodes for flexcan controller(s) present
on LS1021A SoC.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts |    8 ++++++++
 arch/arm/boot/dts/ls1021a.dtsi    |   18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 9c5e16b..1641a04 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -238,3 +238,11 @@
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
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..3fb7b52 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -332,6 +332,24 @@
 			status = "disabled";
 		};
 
+		can0: can@2a70000 {
+			compatible = "fsl,ls1021a-flexcan";
+			reg = <0x0 0x2a70000 0x0 0x1000>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>, <&platform_clk 1>;;
+			clock-names = "ipg", "per";
+			little-endian;
+		};
+
+		can1: can@2a80000 {
+			compatible = "fsl,ls1021a-flexcan";
+			reg = <0x0 0x2a80000 0x0 0x1000>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>, <&platform_clk 1>;;
+			clock-names = "ipg", "per";
+			little-endian;
+		};
+
 		wdog0: watchdog@2ad0000 {
 			compatible = "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
-- 
1.7.9.5


