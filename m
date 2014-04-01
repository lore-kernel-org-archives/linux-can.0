From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 2/4] can: mcp251x: Improve mcp251x_hw_reset()
Date: Tue,  1 Apr 2014 23:02:17 +0200
Message-ID: <1396386139-20238-3-git-send-email-mkl@pengutronix.de>
References: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55437 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbaDAVCW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 17:02:22 -0400
In-Reply-To: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Shiyan <shc_work@mail.ru>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Alexander Shiyan <shc_work@mail.ru>

The MCP251x utilizes an oscillator startup timer (OST), which holds the
chip in reset, to insure that the oscillator has stabilized before the
internal state machine begins to operate. The OST maintains reset for
the first 128 OSC clock cycles after power up or reset.
So, this patch removes unnecessary loops and reduce delay for power on
and reset to the safe value.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mcp251x.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 356d3da..9a8fd94 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -214,6 +214,8 @@
 
 #define TX_ECHO_SKB_MAX	1
 
+#define MCP251X_OST_DELAY_MS	(5)
+
 #define DEVICE_NAME "mcp251x"
 
 static int mcp251x_enable_dma; /* Enable SPI DMA. Default: 0 (Off) */
@@ -624,28 +626,24 @@ static int mcp251x_setup(struct net_device *net, struct mcp251x_priv *priv,
 static int mcp251x_hw_reset(struct spi_device *spi)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+	u8 reg;
 	int ret;
-	unsigned long timeout;
+
+	/* Wait for oscillator startup timer after power up */
+	mdelay(MCP251X_OST_DELAY_MS);
 
 	priv->spi_tx_buf[0] = INSTRUCTION_RESET;
-	ret = spi_write(spi, priv->spi_tx_buf, 1);
-	if (ret) {
-		dev_err(&spi->dev, "reset failed: ret = %d\n", ret);
-		return -EIO;
-	}
+	ret = mcp251x_spi_trans(spi, 1);
+	if (ret)
+		return ret;
+
+	/* Wait for oscillator startup timer after reset */
+	mdelay(MCP251X_OST_DELAY_MS);
+	
+	reg = mcp251x_read_reg(spi, CANSTAT);
+	if ((reg & CANCTRL_REQOP_MASK) != CANCTRL_REQOP_CONF)
+		return -ENODEV;
 
-	/* Wait for reset to finish */
-	timeout = jiffies + HZ;
-	mdelay(10);
-	while ((mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK)
-	       != CANCTRL_REQOP_CONF) {
-		schedule();
-		if (time_after(jiffies, timeout)) {
-			dev_err(&spi->dev, "MCP251x didn't"
-				" enter in conf mode after reset\n");
-			return -EBUSY;
-		}
-	}
 	return 0;
 }
 
@@ -776,7 +774,6 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 
 	mutex_lock(&priv->mcp_lock);
 	if (priv->after_suspend) {
-		mdelay(10);
 		mcp251x_hw_reset(spi);
 		mcp251x_setup(net, priv, spi);
 		if (priv->after_suspend & AFTER_SUSPEND_RESTART) {
-- 
1.9.0.279.gdc9e3eb

