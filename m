From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] can: flexcan: Let device core handle pinctrl
Date: Mon, 20 May 2013 10:06:18 -0300
Message-ID: <1369055178-6083-2-git-send-email-fabio.estevam@freescale.com>
References: <1369055178-6083-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from [207.46.163.26] ([207.46.163.26]:13036 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1756585Ab3ETNHr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 May 2013 09:07:47 -0400
In-Reply-To: <1369055178-6083-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: davem@davemloft.net
Cc: shawn.guo@linaro.org, netdev@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core)
we can rely on device core for handling pinctrl, so remove 
devm_pinctrl_get_select_default() from the driver.

Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: <linux-can@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/net/can/flexcan.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4a40a18..a93cdb2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -37,7 +37,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/pinctrl/consumer.h>
 
 #define DRV_NAME			"flexcan"
 
@@ -1004,16 +1003,11 @@ static int flexcan_probe(struct platform_device *pdev)
 	struct flexcan_priv *priv;
 	struct resource *mem;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
-	struct pinctrl *pinctrl;
 	void __iomem *base;
 	resource_size_t mem_size;
 	int err, irq;
 	u32 clock_freq = 0;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		return PTR_ERR(pinctrl);
-
 	if (pdev->dev.of_node)
 		of_property_read_u32(pdev->dev.of_node,
 						"clock-frequency", &clock_freq);
-- 
1.8.1.2


