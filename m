From: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Subject: [PATCH 2/2] arm/dts: Add nodes for flexcan devices present on LS1021A SoC
Date: Thu, 9 Apr 2015 20:21:27 +0530
Message-ID: <1428591087-12831-2-git-send-email-bhupesh.sharma__43638.7776666836$1428591727$gmane$org@freescale.com>
References: <1428591087-12831-1-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60310 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbbDIPBu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2015 11:01:50 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1YgDxk-0007ZW-Vc
	for linux-can@vger.kernel.org; Thu, 09 Apr 2015 17:01:49 +0200
Received: from [172.17.34.170] (unknown [172.17.34.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: frogger)
	by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id 9E318E58B
	for <linux-can@vger.kernel.org>; Thu,  9 Apr 2015 15:01:48 +0000 (UTC)
In-Reply-To: <1428591087-12831-1-git-send-email-bhupesh.sharma@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mkl@pengutronix.de
Cc: bhupesh.linux@gmail.com, bhupesh.sharma@freescale.com, olof@lixom.net, Sakar.Arora@freescale.com

From: Sakar Arora <Sakar.Arora@freescale.com>

This patch adds the device nodes for flexcan controller(s) present
on LS1021A SoC.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts |    8 ++++++++
 arch/arm/boot/dts/ls1021a.dtsi    |   20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

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
index c70bb27..c44661b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -332,6 +332,26 @@
 			status = "disabled";
 		};
 
+		can0: can@2a70000 {
+			compatible = "fsl,ls1021a-flexcan";
+			reg = <0x0 0x2a70000 0x0 0x1000>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-frequency = <150000000>;
+			clock-names = "per";
+			little-endian;
+		};
+
+		can1: can@2a80000 {
+			compatible = "fsl,ls1021a-flexcan";
+			reg = <0x0 0x2a80000 0x0 0x1000>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&platform_clk 1>;
+			clock-frequency = <150000000>;
+			clock-names = "per";
+			little-endian;
+		};
+
 		wdog0: watchdog@2ad0000 {
 			compatible = "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
-- 
1.7.9.5



