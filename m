From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] can: mcp251x: Move diagnostic messages to dev_dbg()
Date: Sat, 22 Feb 2014 09:51:13 +0400
Message-ID: <1393048274-7949-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:43922 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbaBVFv6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 22 Feb 2014 00:51:58 -0500
Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [94.100.177.104])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id CD9D010DDAF07
	for <linux-can@vger.kernel.org>; Sat, 22 Feb 2014 09:51:56 +0400 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Christian Pellegrin <chripell@evolware.org>, Chris Elston <celston@katalix.com>, Alexander Shiyan <shc_work@mail.ru>

This patch moves diagnostic messages used for debugging purposes
to dev_dbg().

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index cdb9808..56e38a6 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -601,10 +601,10 @@ static int mcp251x_do_set_bittiming(struct net_device *net)
 			  (bt->prop_seg - 1));
 	mcp251x_write_bits(spi, CNF3, CNF3_PHSEG2_MASK,
 			   (bt->phase_seg2 - 1));
-	dev_info(&spi->dev, "CNF: 0x%02x 0x%02x 0x%02x\n",
-		 mcp251x_read_reg(spi, CNF1),
-		 mcp251x_read_reg(spi, CNF2),
-		 mcp251x_read_reg(spi, CNF3));
+	dev_dbg(&spi->dev, "CNF: 0x%02x 0x%02x 0x%02x\n",
+		mcp251x_read_reg(spi, CNF1),
+		mcp251x_read_reg(spi, CNF2),
+		mcp251x_read_reg(spi, CNF3));
 
 	return 0;
 }
@@ -1155,7 +1155,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	devm_can_led_init(net);
 
-	dev_info(&spi->dev, "probed\n");
+	dev_dbg(&spi->dev, "probed\n");
 
 	return ret;
 
-- 
1.8.3.2

