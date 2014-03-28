From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 3/4] can: mcp251x: Improve mcp251x_hw_probe()
Date: Fri, 28 Mar 2014 14:14:46 +0400
Message-ID: <1396001687-7092-3-git-send-email-shc_work@mail.ru>
References: <1396001687-7092-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback6.mail.ru ([94.100.176.134]:34462 "EHLO
	fallback6.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaC1KPW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Mar 2014 06:15:22 -0400
Received: from smtp11.mail.ru (smtp11.mail.ru [94.100.176.85])
	by fallback6.mail.ru (mPOP.Fallback_MX) with ESMTP id D144237B4DEB
	for <linux-can@vger.kernel.org>; Fri, 28 Mar 2014 14:15:20 +0400 (MSK)
In-Reply-To: <1396001687-7092-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

This patch adds check for mcp251x_hw_reset() result on startup and
removes unnecessary checking for CANSTAT register since this value
is being checked in mcp251x_hw_reset().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index fea41b4..f4786c8 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -645,23 +645,19 @@ static int mcp251x_hw_reset(struct spi_device *spi)
 
 static int mcp251x_hw_probe(struct spi_device *spi)
 {
-	int st1, st2;
+	u8 ctrl;
+	int ret;
 
-	mcp251x_hw_reset(spi);
+	ret = mcp251x_hw_reset(spi);
+	if (ret)
+		return ret;
 
-	/*
-	 * Please note that these are "magic values" based on after
-	 * reset defaults taken from data sheet which allows us to see
-	 * if we really have a chip on the bus (we avoid common all
-	 * zeroes or all ones situations)
-	 */
-	st1 = mcp251x_read_reg(spi, CANSTAT) & 0xEE;
-	st2 = mcp251x_read_reg(spi, CANCTRL) & 0x17;
+	ctrl = mcp251x_read_reg(spi, CANCTRL);
 
-	dev_dbg(&spi->dev, "CANSTAT 0x%02x CANCTRL 0x%02x\n", st1, st2);
+	dev_dbg(&spi->dev, "CANCTRL 0x%02x\n", ctrl);
 
-	/* Check for power up default values */
-	return (st1 == 0x80 && st2 == 0x07) ? 1 : 0;
+	/* Check for power up default value */
+	return ((ctrl & 0x17) == 0x07) ? 0 : -ENODEV;
 }
 
 static int mcp251x_power_enable(struct regulator *reg, int enable)
@@ -1138,19 +1134,18 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	SET_NETDEV_DEV(net, &spi->dev);
 
 	/* Here is OK to not lock the MCP, no one knows about it yet */
-	if (!mcp251x_hw_probe(spi)) {
-		ret = -ENODEV;
-		goto error_probe;
-	}
-	mcp251x_hw_sleep(spi);
+	ret = mcp251x_hw_probe(spi);
+	if (!ret) {
+		mcp251x_hw_sleep(spi);
 
-	ret = register_candev(net);
-	if (ret)
-		goto error_probe;
+		ret = register_candev(net);
+		if (ret)
+			goto error_probe;
 
-	devm_can_led_init(net);
+		devm_can_led_init(net);
 
-	return ret;
+		return 0;
+	}
 
 error_probe:
 	if (mcp251x_enable_dma)
-- 
1.8.3.2

