From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/5] can: mscan: remove obsolete variable open_time
Date: Mon, 26 Nov 2012 15:24:43 +0100
Message-ID: <1353939887-19552-2-git-send-email-mkl@pengutronix.de>
References: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56476 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab2KZOYt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 09:24:49 -0500
In-Reply-To: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

The variable open_time in the struct mscan_priv was used to protect
mscan_do_set_mode() only to be called, if the interface is up. Now the CAN
device infrastructure takes care of this.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mscan/mscan.c |    8 --------
 drivers/net/can/mscan/mscan.h |    1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 2b104d5..e6b4095 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -517,12 +517,8 @@ static irqreturn_t mscan_isr(int irq, void *dev_id)
 
 static int mscan_do_set_mode(struct net_device *dev, enum can_mode mode)
 {
-	struct mscan_priv *priv = netdev_priv(dev);
 	int ret = 0;
 
-	if (!priv->open_time)
-		return -EINVAL;
-
 	switch (mode) {
 	case CAN_MODE_START:
 		ret = mscan_restart(dev);
@@ -590,8 +586,6 @@ static int mscan_open(struct net_device *dev)
 		goto exit_napi_disable;
 	}
 
-	priv->open_time = jiffies;
-
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		setbits8(&regs->canctl1, MSCAN_LISTEN);
 	else
@@ -606,7 +600,6 @@ static int mscan_open(struct net_device *dev)
 	return 0;
 
 exit_free_irq:
-	priv->open_time = 0;
 	free_irq(dev->irq, dev);
 exit_napi_disable:
 	napi_disable(&priv->napi);
@@ -627,7 +620,6 @@ static int mscan_close(struct net_device *dev)
 	mscan_set_mode(dev, MSCAN_INIT_MODE);
 	close_candev(dev);
 	free_irq(dev->irq, dev);
-	priv->open_time = 0;
 
 	return 0;
 }
diff --git a/drivers/net/can/mscan/mscan.h b/drivers/net/can/mscan/mscan.h
index b43e9f5..af2ed8b 100644
--- a/drivers/net/can/mscan/mscan.h
+++ b/drivers/net/can/mscan/mscan.h
@@ -281,7 +281,6 @@ struct tx_queue_entry {
 struct mscan_priv {
 	struct can_priv can;	/* must be the first member */
 	unsigned int type; 	/* MSCAN type variants */
-	long open_time;
 	unsigned long flags;
 	void __iomem *reg_base;	/* ioremap'ed address to registers */
 	u8 shadow_statflg;
-- 
1.7.10.4

