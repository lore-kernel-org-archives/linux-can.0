From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/4] can: mcp251x: Improve mcp251x_hw_reset()
Date: Fri, 28 Mar 2014 14:14:45 +0400
Message-ID: <1396001687-7092-2-git-send-email-shc_work@mail.ru>
References: <1396001687-7092-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:56802 "EHLO
	fallback6.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750951AbaC1KVm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Mar 2014 06:21:42 -0400
Received: from smtp11.mail.ru (smtp11.mail.ru [94.100.176.85])
	by fallback6.mail.ru (mPOP.Fallback_MX) with ESMTP id AC1D23535114
	for <linux-can@vger.kernel.org>; Fri, 28 Mar 2014 14:15:17 +0400 (MSK)
In-Reply-To: <1396001687-7092-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

The MCP251x utilizes an oscillator startup timer (OST), which holds the
chip in reset, to insure that the oscillator has stabilized before the
internal state machine begins to operate. The OST maintains reset for
the first 128 OSC clock cycles after power up or reset.
So, this patch removes unnecessary loops and reduce delay for power on
and reset to the safe value.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 26879c7..fea41b4 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -214,6 +214,8 @@
 
 #define TX_ECHO_SKB_MAX	1
 
+#define MCP251X_OST_DELAY_MS	(5)
+
 #define DEVICE_NAME "mcp251x"
 
 static int mcp251x_enable_dma; /* Enable SPI DMA. Default: 0 (Off) */
@@ -625,28 +627,20 @@ static int mcp251x_hw_reset(struct spi_device *spi)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
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
-	return 0;
+	/* Wait for oscillator startup timer after reset */
+	mdelay(MCP251X_OST_DELAY_MS);
+	
+	return ((mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK) ==
+		CANCTRL_REQOP_CONF) ? 0 : -ENODEV;
 }
 
 static int mcp251x_hw_probe(struct spi_device *spi)
@@ -776,7 +770,6 @@ static void mcp251x_restart_work_handler(struct work_struct *ws)
 
 	mutex_lock(&priv->mcp_lock);
 	if (priv->after_suspend) {
-		mdelay(10);
 		mcp251x_hw_reset(spi);
 		mcp251x_setup(net, priv, spi);
 		if (priv->after_suspend & AFTER_SUSPEND_RESTART) {
-- 
1.8.3.2

