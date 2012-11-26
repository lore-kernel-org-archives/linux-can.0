From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/5] can: sja1000: remove obsolete variable open_time
Date: Mon, 26 Nov 2012 15:24:44 +0100
Message-ID: <1353939887-19552-3-git-send-email-mkl@pengutronix.de>
References: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56478 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab2KZOYt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 09:24:49 -0500
In-Reply-To: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

The variable open_time in the struct sja1000_priv was used to protect
sja1000_set_mode() only to be called, if the interface is up. Now the CAN
device infrastructure takes care of this.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c |    8 --------
 drivers/net/can/sja1000/sja1000.h |    1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 25011db..83ee11e 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -188,11 +188,6 @@ static void sja1000_start(struct net_device *dev)
 
 static int sja1000_set_mode(struct net_device *dev, enum can_mode mode)
 {
-	struct sja1000_priv *priv = netdev_priv(dev);
-
-	if (!priv->open_time)
-		return -EINVAL;
-
 	switch (mode) {
 	case CAN_MODE_START:
 		sja1000_start(dev);
@@ -579,7 +574,6 @@ static int sja1000_open(struct net_device *dev)
 
 	/* init and start chi */
 	sja1000_start(dev);
-	priv->open_time = jiffies;
 
 	netif_start_queue(dev);
 
@@ -598,8 +592,6 @@ static int sja1000_close(struct net_device *dev)
 
 	close_candev(dev);
 
-	priv->open_time = 0;
-
 	return 0;
 }
 
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index 23fff06..afa9984 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -152,7 +152,6 @@
  */
 struct sja1000_priv {
 	struct can_priv can;	/* must be the first member */
-	int open_time;
 	struct sk_buff *echo_skb;
 
 	/* the lower-layer is responsible for appropriate locking */
-- 
1.7.10.4

