From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 11/14] can: af_can: can_pernet_exit(): no need to iterate over and cleanup registered CAN devices
Date: Wed,  2 Aug 2017 19:44:31 +0200
Message-ID: <20170802174434.4689-12-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36747 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752314AbdHBRoo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:44 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

The networking core takes care and unregisters every network device in
a namespace before calling the can_pernet_exit() hook. This patch
removes the unneeded cleanup.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index e3df12cd2cae..d781b9330f2c 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -906,27 +906,12 @@ static int can_pernet_init(struct net *net)
 
 static void can_pernet_exit(struct net *net)
 {
-	struct net_device *dev;
-
 	if (IS_ENABLED(CONFIG_PROC_FS)) {
 		can_remove_proc(net);
 		if (stats_timer)
 			del_timer_sync(&net->can.can_stattimer);
 	}
 
-	/* remove created dev_rcv_lists from still registered CAN devices */
-	rcu_read_lock();
-	for_each_netdev_rcu(net, dev) {
-		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
-			struct can_dev_rcv_lists *dev_rcv_lists = dev->ml_priv;
-
-			BUG_ON(dev_rcv_lists->entries);
-			kfree(dev_rcv_lists);
-			dev->ml_priv = NULL;
-		}
-	}
-	rcu_read_unlock();
-
 	kfree(net->can.can_rx_alldev_list);
 	kfree(net->can.can_stats);
 	kfree(net->can.can_pstats);
-- 
2.13.2

