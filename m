From: David Dueck <davidcdueck@googlemail.com>
Subject: [PATCH] can: at91_can: prepare and unprepare the clock
Date: Wed, 17 Sep 2014 11:05:21 +0200
Message-ID: <1410944721-32325-1-git-send-email-davidcdueck__49421.0052457221$1410945215$gmane$org@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41178 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbaIQJNP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 17 Sep 2014 05:13:15 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1XUBIX-0005Ii-PC
	for linux-can@vger.kernel.org; Wed, 17 Sep 2014 11:13:14 +0200
Received: from [IPv6:2001:6f8:105b:1122:5e51:4fff:fed6:c770] (unknown [IPv6:2001:6f8:105b:1122:5e51:4fff:fed6:c770])
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: frogger)
	by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id 8654A5FD43
	for <linux-can@vger.kernel.org>; Wed, 17 Sep 2014 11:13:13 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: mkl@pengutronix.de, wg@grandegger.com, nicolas.ferre@atmel.com, Anthony Harivel <anthony.harivel@emtrion.de>

This prevents a warning.

Signed-off-by: David Dueck <davidcdueck@googlemail.com>
Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>
---
 drivers/net/can/at91_can.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index f07fa89..7dcb790 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1123,7 +1123,7 @@ static int at91_open(struct net_device *dev)
 	struct at91_priv *priv = netdev_priv(dev);
 	int err;
 
-	clk_enable(priv->clk);
+	clk_prepare_enable(priv->clk);
 
 	/* check or determine and set bittime */
 	err = open_candev(dev);
@@ -1149,7 +1149,7 @@ static int at91_open(struct net_device *dev)
  out_close:
 	close_candev(dev);
  out:
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return err;
 }
@@ -1166,7 +1166,7 @@ static int at91_close(struct net_device *dev)
 	at91_chip_stop(dev, CAN_STATE_STOPPED);
 
 	free_irq(dev->irq, dev);
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	close_candev(dev);
 
-- 
2.1.0


