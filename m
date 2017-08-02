From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 06/14] can: af_can: rename find_rcv_list() to can_rcv_list_find()
Date: Wed,  2 Aug 2017 19:44:26 +0200
Message-ID: <20170802174434.4689-7-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39891 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752314AbdHBRol (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:41 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch add the commonly used prefix "can_" to the find_rcv_list()
function and add the "find" to the end, as the function returns a struct
rcv_list. This improves the overall readability of the code.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 43f4f51d5a73..0f1334803aea 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -354,7 +354,7 @@ static unsigned int effhash(canid_t can_id)
 }
 
 /**
- * find_rcv_list - determine optimal filterlist inside device filter struct
+ * can_rcv_list_find - determine optimal filterlist inside device filter struct
  * @can_id: pointer to CAN identifier of a given can_filter
  * @mask: pointer to CAN mask of a given can_filter
  * @d: pointer to the device filter struct
@@ -380,8 +380,8 @@ static unsigned int effhash(canid_t can_id)
  *  Constistency checked mask.
  *  Reduced can_id to have a preprocessed filter compare value.
  */
-static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
-					struct can_dev_rcv_lists *dev_rcv_lists)
+static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
+					    struct can_dev_rcv_lists *dev_rcv_lists)
 {
 	canid_t inv = *can_id & CAN_INV_FILTER; /* save flag before masking */
 
@@ -484,7 +484,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	if (dev_rcv_lists) {
-		rl = find_rcv_list(&can_id, &mask, dev_rcv_lists);
+		rl = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 		r->can_id  = can_id;
 		r->mask    = mask;
@@ -560,7 +560,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 		goto out;
 	}
 
-	rl = find_rcv_list(&can_id, &mask, dev_rcv_lists);
+	rl = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	/*
 	 * Search the receiver list for the item to delete.  This should
-- 
2.13.2

