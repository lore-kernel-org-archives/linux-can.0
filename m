From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/6] net: flexcan: clock-frequency is optional for device tree probe
Date: Mon,  2 Jul 2012 14:40:23 +0200
Message-ID: <1341232825-4604-5-git-send-email-mkl@pengutronix.de>
References: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57320 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2GBMka (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 08:40:30 -0400
In-Reply-To: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Shawn Guo <shawn.guo@linaro.org>

The property clock-frequency is optional for device tree probe.  When
it's absent, the flexcan driver will try to get the frequency from clk
system by calling clk_get_rate.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index f31b686..8ff324e 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -11,6 +11,9 @@ Required properties:
 
 - reg : Offset and length of the register set for this device
 - interrupts : Interrupt tuple for this device
+
+Optional properties:
+
 - clock-frequency : The oscillator frequency driving the flexcan device
 
 Example:
-- 
1.7.10

