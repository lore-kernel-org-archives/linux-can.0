From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 01/14] can: af_can: can_pernet_init(): add missing error handling for kzalloc returning NULL
Date: Wed,  2 Aug 2017 19:44:21 +0200
Message-ID: <20170802174434.4689-2-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38057 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752062AbdHBRoj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:39 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds the missing check and error handling for out-of-memory
situations, when kzalloc cannot allocate memory.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 88edac0f3e36..0896e2facd50 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -875,9 +875,14 @@ static int can_pernet_init(struct net *net)
 	spin_lock_init(&net->can.can_rcvlists_lock);
 	net->can.can_rx_alldev_list =
 		kzalloc(sizeof(struct dev_rcv_lists), GFP_KERNEL);
-
-	net->can.can_stats = kzalloc(sizeof(struct s_stats), GFP_KERNEL);
-	net->can.can_pstats = kzalloc(sizeof(struct s_pstats), GFP_KERNEL);
+	if (!net->can.can_rx_alldev_list)
+		goto out;
+	net->can.can_stats = kzalloc(sizeof(struct can_stats), GFP_KERNEL);
+	if (!net->can.can_stats)
+		goto out_free_alldev_list;
+	net->can.can_pstats = kzalloc(sizeof(struct can_pstats), GFP_KERNEL);
+	if (!net->can.can_pstats)
+		goto out_free_can_stats;
 
 	if (IS_ENABLED(CONFIG_PROC_FS)) {
 		/* the statistics are updated every second (timer triggered) */
@@ -892,6 +897,13 @@ static int can_pernet_init(struct net *net)
 	}
 
 	return 0;
+
+ out_free_can_stats:
+	kfree(net->can.can_stats);
+ out_free_alldev_list:
+	kfree(net->can.can_rx_alldev_list);
+ out:
+	return -ENOMEM;
 }
 
 static void can_pernet_exit(struct net *net)
-- 
2.13.2

