From: <ludovic.desroches@atmel.com>
Subject: [PATCH 2/3] can: at91_can: add pinctrl support
Date: Fri, 8 Mar 2013 18:30:41 +0100
Message-ID: <1362763842-14924-3-git-send-email-ludovic.desroches@atmel.com>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:1238 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933140Ab3CHRbp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 12:31:45 -0500
In-Reply-To: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, mkl@pengutronix.de, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/net/can/at91_can.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index c7f70d4..56fb2aa 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
@@ -1292,6 +1293,7 @@ static int at91_can_probe(struct platform_device *pdev)
 	struct clk *clk;
 	void __iomem *addr;
 	int err, irq;
+	struct pinctrl *pinctrl;
 
 	devtype_data = at91_can_get_driver_data(pdev);
 	if (!devtype_data) {
@@ -1314,6 +1316,13 @@ static int at91_can_probe(struct platform_device *pdev)
 		goto exit_put;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		dev_err(&pdev->dev, "Failed to request pinctrl\n");
+		err = PTR_ERR(pinctrl);
+		goto exit_put;
+	}
+
 	if (!request_mem_region(res->start,
 				resource_size(res),
 				pdev->name)) {
-- 
1.7.11.3

