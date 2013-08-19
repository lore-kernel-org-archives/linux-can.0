From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2 2/3] can: mcp251x: Eliminate irq_flags from driver platform_data
Date: Mon, 19 Aug 2013 15:39:20 +0400
Message-ID: <1376912361-22133-2-git-send-email-shc_work@mail.ru>
References: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp33.i.mail.ru ([94.100.177.93]:56960 "EHLO smtp33.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263Ab3HSLjf (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 19 Aug 2013 07:39:35 -0400
In-Reply-To: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Alexander Shiyan <shc_work@mail.ru>

Flags is not used by boards, so remove this field from the driver
platform_data.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c            | 9 +--------
 include/linux/can/platform/mcp251x.h | 2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 3df83f8..a48d3df 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -935,8 +935,7 @@ static int mcp251x_open(struct net_device *net)
 {
 	struct mcp251x_priv *priv = netdev_priv(net);
 	struct spi_device *spi = priv->spi;
-	struct mcp251x_platform_data *pdata = spi->dev.platform_data;
-	unsigned long flags;
+	unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_FALLING;
 	int ret;
 
 	ret = open_candev(net);
@@ -952,12 +951,6 @@ static int mcp251x_open(struct net_device *net)
 	priv->tx_skb = NULL;
 	priv->tx_len = 0;
 
-	flags = IRQF_ONESHOT;
-	if (pdata->irq_flags)
-		flags |= pdata->irq_flags;
-	else
-		flags |= IRQF_TRIGGER_FALLING;
-
 	ret = request_threaded_irq(spi->irq, NULL, mcp251x_can_ist,
 				   flags, DEVICE_NAME, priv);
 	if (ret) {
diff --git a/include/linux/can/platform/mcp251x.h b/include/linux/can/platform/mcp251x.h
index 8a27256..dc029db 100644
--- a/include/linux/can/platform/mcp251x.h
+++ b/include/linux/can/platform/mcp251x.h
@@ -12,12 +12,10 @@
 /*
  * struct mcp251x_platform_data - MCP251X SPI CAN controller platform data
  * @oscillator_frequency:       - oscillator frequency in Hz
- * @irq_flags:                  - IRQF configuration flags
  */
 
 struct mcp251x_platform_data {
 	unsigned long oscillator_frequency;
-	unsigned long irq_flags;
 };
 
 #endif /* __CAN_PLATFORM_MCP251X_H__ */
-- 
1.8.1.5

