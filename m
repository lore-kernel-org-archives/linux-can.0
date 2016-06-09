From: Marek Vasut <marex@denx.de>
Subject: [PATCH 1/5][RFC] can: slcan: Replace sizeof struct can_frame with CAN_MTU
Date: Thu,  9 Jun 2016 21:21:00 +0200
Message-ID: <1465500064-5402-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41458 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbcFITVn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2016 15:21:43 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Use CAN_MTU macro instead of sizeof(struct can_frame) just like the
other drivers do.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/slcan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 9a3f15c..eb71737 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -354,7 +354,7 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct slcan *sl = netdev_priv(dev);
 
-	if (skb->len != sizeof(struct can_frame))
+	if (skb->len != CAN_MTU)
 		goto out;
 
 	spin_lock(&sl->lock);
@@ -442,7 +442,7 @@ static void slc_setup(struct net_device *dev)
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 10;
 
-	dev->mtu		= sizeof(struct can_frame);
+	dev->mtu		= CAN_MTU;
 	dev->type		= ARPHRD_CAN;
 
 	/* New-style flags. */
-- 
2.7.0

