From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 3/5] can: bcm: unify bcm_msg_head handling and prepare function parameters
Date: Mon, 30 May 2016 20:36:28 +0200
Message-ID: <1464633390-24299-4-git-send-email-socketcan@hartkopp.net>
References: <1464633390-24299-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:26298 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933443AbcE3Sgo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 May 2016 14:36:44 -0400
In-Reply-To: <1464633390-24299-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 54 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 59553de..640578a 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -695,13 +695,13 @@ rx_starttimer:
 /*
  * helpers for bcm_op handling: find & delete bcm [rx|tx] op elements
  */
-static struct bcm_op *bcm_find_op(struct list_head *ops, canid_t can_id,
-				  int ifindex)
+static struct bcm_op *bcm_find_op(struct list_head *ops,
+				  struct bcm_msg_head *mh, int ifindex)
 {
 	struct bcm_op *op;
 
 	list_for_each_entry(op, ops, list) {
-		if ((op->can_id == can_id) && (op->ifindex == ifindex))
+		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex))
 			return op;
 	}
 
@@ -744,12 +744,13 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 /*
  * bcm_delete_rx_op - find and remove a rx op (returns number of removed ops)
  */
-static int bcm_delete_rx_op(struct list_head *ops, canid_t can_id, int ifindex)
+static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
+			    int ifindex)
 {
 	struct bcm_op *op, *n;
 
 	list_for_each_entry_safe(op, n, ops, list) {
-		if ((op->can_id == can_id) && (op->ifindex == ifindex)) {
+		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex)) {
 
 			/*
 			 * Don't care if we're bound or not (due to netdev
@@ -789,12 +790,13 @@ static int bcm_delete_rx_op(struct list_head *ops, canid_t can_id, int ifindex)
 /*
  * bcm_delete_tx_op - find and remove a tx op (returns number of removed ops)
  */
-static int bcm_delete_tx_op(struct list_head *ops, canid_t can_id, int ifindex)
+static int bcm_delete_tx_op(struct list_head *ops, struct bcm_msg_head *mh,
+			    int ifindex)
 {
 	struct bcm_op *op, *n;
 
 	list_for_each_entry_safe(op, n, ops, list) {
-		if ((op->can_id == can_id) && (op->ifindex == ifindex)) {
+		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex)) {
 			list_del(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
@@ -810,7 +812,7 @@ static int bcm_delete_tx_op(struct list_head *ops, canid_t can_id, int ifindex)
 static int bcm_read_op(struct list_head *ops, struct bcm_msg_head *msg_head,
 		       int ifindex)
 {
-	struct bcm_op *op = bcm_find_op(ops, msg_head->can_id, ifindex);
+	struct bcm_op *op = bcm_find_op(ops, msg_head, ifindex);
 
 	if (!op)
 		return -EINVAL;
@@ -847,8 +849,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		return -EINVAL;
 
 	/* check the given can_id */
-	op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex);
-
+	op = bcm_find_op(&bo->tx_ops, msg_head, ifindex);
 	if (op) {
 		/* update existing BCM operation */
 
@@ -1012,7 +1013,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		return -EINVAL;
 
 	/* check the given can_id */
-	op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex);
+	op = bcm_find_op(&bo->rx_ops, msg_head, ifindex);
 	if (op) {
 		/* update existing BCM operation */
 
@@ -1194,7 +1195,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 /*
  * bcm_tx_send - send a single CAN frame to the CAN interface (for bcm_sendmsg)
  */
-static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk)
+static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
+		       int cfsiz)
 {
 	struct sk_buff *skb;
 	struct net_device *dev;
@@ -1204,13 +1206,13 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk)
 	if (!ifindex)
 		return -ENODEV;
 
-	skb = alloc_skb(CFSIZ + sizeof(struct can_skb_priv), GFP_KERNEL);
+	skb = alloc_skb(cfsiz + sizeof(struct can_skb_priv), GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
 	can_skb_reserve(skb);
 
-	err = memcpy_from_msg(skb_put(skb, CFSIZ), msg, CFSIZ);
+	err = memcpy_from_msg(skb_put(skb, cfsiz), msg, cfsiz);
 	if (err < 0) {
 		kfree_skb(skb);
 		return err;
@@ -1232,7 +1234,7 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk)
 	if (err)
 		return err;
 
-	return CFSIZ + MHSIZ;
+	return cfsiz + MHSIZ;
 }
 
 /*
@@ -1250,7 +1252,15 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		return -ENOTCONN;
 
 	/* check for valid message length from userspace */
-	if (size < MHSIZ || (size - MHSIZ) % CFSIZ)
+	if (size < MHSIZ)
+		return -EINVAL;
+
+	/* read message head information */
+	ret = memcpy_from_msg((u8 *)&msg_head, msg, MHSIZ);
+	if (ret < 0)
+		return ret;
+
+	if ((size - MHSIZ) % CFSIZ)
 		return -EINVAL;
 
 	/* check for alternative ifindex for this bcm_op */
@@ -1284,12 +1294,6 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		}
 	}
 
-	/* read message head information */
-
-	ret = memcpy_from_msg((u8 *)&msg_head, msg, MHSIZ);
-	if (ret < 0)
-		return ret;
-
 	lock_sock(sk);
 
 	switch (msg_head.opcode) {
@@ -1303,14 +1307,14 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		break;
 
 	case TX_DELETE:
-		if (bcm_delete_tx_op(&bo->tx_ops, msg_head.can_id, ifindex))
+		if (bcm_delete_tx_op(&bo->tx_ops, &msg_head, ifindex))
 			ret = MHSIZ;
 		else
 			ret = -EINVAL;
 		break;
 
 	case RX_DELETE:
-		if (bcm_delete_rx_op(&bo->rx_ops, msg_head.can_id, ifindex))
+		if (bcm_delete_rx_op(&bo->rx_ops, &msg_head, ifindex))
 			ret = MHSIZ;
 		else
 			ret = -EINVAL;
@@ -1333,7 +1337,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		if ((msg_head.nframes != 1) || (size != CFSIZ + MHSIZ))
 			ret = -EINVAL;
 		else
-			ret = bcm_tx_send(msg, ifindex, sk);
+			ret = bcm_tx_send(msg, ifindex, sk, CFSIZ);
 		break;
 
 	default:
-- 
2.8.1

