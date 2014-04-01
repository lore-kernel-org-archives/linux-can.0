From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 3/4] can: mcp251x: Improve mcp251x_hw_probe()
Date: Tue,  1 Apr 2014 23:02:18 +0200
Message-ID: <1396386139-20238-4-git-send-email-mkl@pengutronix.de>
References: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55438 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbaDAVCX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 17:02:23 -0400
In-Reply-To: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Shiyan <shc_work@mail.ru>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Alexander Shiyan <shc_work@mail.ru>

This patch adds check for mcp251x_hw_reset() result on startup and
removes unnecessary checking for CANSTAT register since this value
is being checked in mcp251x_hw_reset().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mcp251x.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 9a8fd94..bc235f9 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -649,23 +649,22 @@ static int mcp251x_hw_reset(struct spi_device *spi)
 
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
+
+	dev_dbg(&spi->dev, "CANCTRL 0x%02x\n", ctrl);
 
-	dev_dbg(&spi->dev, "CANSTAT 0x%02x CANCTRL 0x%02x\n", st1, st2);
+	/* Check for power up default value */
+	if ((ctrl & 0x17) != 0x07)
+		return -ENODEV;
 
-	/* Check for power up default values */
-	return (st1 == 0x80 && st2 == 0x07) ? 1 : 0;
+	return 0;
 }
 
 static int mcp251x_power_enable(struct regulator *reg, int enable)
@@ -1142,10 +1141,10 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	SET_NETDEV_DEV(net, &spi->dev);
 
 	/* Here is OK to not lock the MCP, no one knows about it yet */
-	if (!mcp251x_hw_probe(spi)) {
-		ret = -ENODEV;
+	ret = mcp251x_hw_probe(spi);
+	if (ret)
 		goto error_probe;
-	}
+
 	mcp251x_hw_sleep(spi);
 
 	ret = register_candev(net);
@@ -1154,7 +1153,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	devm_can_led_init(net);
 
-	return ret;
+	return 0;
 
 error_probe:
 	if (mcp251x_enable_dma)
-- 
1.9.0.279.gdc9e3eb

