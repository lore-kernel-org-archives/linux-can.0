From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] ARM i.MX53: dts: add flexcan to imx53
Date: Wed, 18 Jul 2012 11:42:43 +0200
Message-ID: <1342604563-18915-3-git-send-email-mkl@pengutronix.de>
References: <1342604563-18915-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56666 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab2GRJmx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 05:42:53 -0400
In-Reply-To: <1342604563-18915-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-can@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index e3e8694..5ae0dbd 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -196,6 +196,20 @@
 				status = "disabled";
 			};
 
+			can1: can@53fc8000 {
+				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
+				reg = <0x53fc8000 0x4000>;
+				interrupts = <82>;
+				status = "disabled";
+			};
+
+			can2: can@53fcc000 {
+				compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
+				reg = <0x53fcc000 0x4000>;
+				interrupts = <83>;
+				status = "disabled";
+			};
+
 			gpio5: gpio@53fdc000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
 				reg = <0x53fdc000 0x4000>;
-- 
1.7.10.4

