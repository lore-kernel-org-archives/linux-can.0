From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] can: mcp251x: Make driver more quiet
Date: Wed,  5 Mar 2014 21:31:56 +0400
Message-ID: <1394040716-31095-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:53502 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbaCERcP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Mar 2014 12:32:15 -0500
Received: from smtp21.mail.ru (smtp21.mail.ru [94.100.176.174])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id 4D31610F638EA
	for <linux-can@vger.kernel.org>; Wed,  5 Mar 2014 21:32:11 +0400 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

This patch moves one diagnostic message used for debugging purposes
to dev_dbg() and removes one useless message.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index cdb9808..7cc9705 100644
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
@@ -1155,8 +1155,6 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	devm_can_led_init(net);
 
-	dev_info(&spi->dev, "probed\n");
-
 	return ret;
 
 error_probe:
-- 
1.8.3.2

