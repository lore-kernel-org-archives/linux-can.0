From: Andreas Werner <kernel@andy89.org>
Subject: [PATCH] can: flexcan: Deferred on Regulator return EPROBE_DEFER
Date: Sun, 22 Mar 2015 17:35:52 +0100
Message-ID: <CAB4L-ghK_dzo-G_81LwjLh8oJxm6pzWkO4_8fZ6auUbycXF_4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dd22202.kasserver.com ([85.13.141.248]:54303 "EHLO
	dd22202.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbbCVQly (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 22 Mar 2015 12:41:54 -0400
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com [209.85.215.54])
	by dd22202.kasserver.com (Postfix) with ESMTPSA id 60ADFE0055F
	for <linux-can@vger.kernel.org>; Sun, 22 Mar 2015 17:35:53 +0100 (CET)
Received: by lagg8 with SMTP id g8so118230007lag.1
        for <linux-can@vger.kernel.org>; Sun, 22 Mar 2015 09:35:52 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Return EPROBE_DEFER if Regulator returns EPROBE_DEFER

If the Flexcan driver is built into kernel and a regulator is used to
enable the CAN transceiver, the Flexcan driver may not use the regulator.

When initializing the Flexcan device with a regulator defined in the device
tree, but not initialized, the regulator subsystem returns EPROBE_DEFER, hence
the Flexcan init fails.

The solution for this is to return EPROBE_DEFER if regulator is not initialized
and wait until the regulator is initialized.

Signed-off-by: Andreas Werner <kernel@andy89.org>
---
I tested this Patch on a self made Freescale Vybrid VF610 board we developed in
the Formula Student Team of the UaS RheinMain. I think this Patch is working on
all other SoC with a Flexcan Controller. I tested it with the head rev of
linux-can and linux 3.19.2.

Since this is my first patch for the Linux Kernel, please tell me if
there are formal
failures.
---
 drivers/net/can/flexcan.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index b1d583b..c575163 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1164,11 +1164,19 @@ static int flexcan_probe(struct platform_device *pdev)
     void __iomem *base;
     int err, irq;
     u32 clock_freq = 0;
+    struct regulator *reg_xceiver = NULL;

     if (pdev->dev.of_node)
         of_property_read_u32(pdev->dev.of_node,
                         "clock-frequency", &clock_freq);

+    reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
+    if (PTR_ERR(reg_xceiver) == -EPROBE_DEFER) {
+        return -EPROBE_DEFER;
+    } else if (IS_ERR(reg_xceiver)) {
+        reg_xceiver = NULL;
+    }
+
     if (!clock_freq) {
         clk_ipg = devm_clk_get(&pdev->dev, "ipg");
         if (IS_ERR(clk_ipg)) {
@@ -1225,10 +1233,7 @@ static int flexcan_probe(struct platform_device *pdev)
     priv->clk_per = clk_per;
     priv->pdata = dev_get_platdata(&pdev->dev);
     priv->devtype_data = devtype_data;
-
-    priv->reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
-    if (IS_ERR(priv->reg_xceiver))
-        priv->reg_xceiver = NULL;
+    priv->reg_xceiver = reg_xceiver;

     netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);

-- 
1.8.1.2
