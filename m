From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4 3/5] can: bcm: unify bcm_msg_head handling and prepare function parameters
Date: Sat,  4 Jun 2016 21:26:49 +0200
Message-ID: <1465068411-24301-4-git-send-email-socketcan@hartkopp.net>
References: <1465068411-24301-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:37025 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcFDT1P (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 4 Jun 2016 15:27:15 -0400
In-Reply-To: <1465068411-24301-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 54 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 83aa6cf..f3bf387 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -693,13 +693,13 @@ rx_starttimer:
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
 
@@ -742,12 +742,13 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
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
@@ -787,12 +788,13 @@ static int bcm_delete_rx_op(struct list_head *ops, canid_t can_id, int ifindex)
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
@@ -808,7 +810,7 @@ static int bcm_delete_tx_op(struct list_head *ops, canid_t can_id, int ifindex)
 static int bcm_read_op(struct list_head *ops, struct bcm_msg_head *msg_head,
 		       int ifindex)
 {
-	struct bcm_op *op = bcm_find_op(ops, msg_head->can_id, ifindex);
+	struct bcm_op *op = bcm_find_op(ops, msg_head, ifindex);
 
 	if (!op)
 		return -EINVAL;
@@ -845,8 +847,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		return -EINVAL;
 
 	/* check the given can_id */
-	op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex);
-
+	op = bcm_find_op(&bo->tx_ops, msg_head, ifindex);
 	if (op) {
 		/* update existing BCM operation */
 
@@ -1010,7 +1011,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		return -EINVAL;
 
 	/* check the given can_id */
-	op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex);
+	op = bcm_find_op(&bo->rx_ops, msg_head, ifindex);
 	if (op) {
 		/* update existing BCM operation */
 
@@ -1192,7 +1193,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 /*
  * bcm_tx_send - send a single CAN frame to the CAN interface (for bcm_sendmsg)
  */
-static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk)
+static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
+		       int cfsiz)
 {
 	struct sk_buff *skb;
 	struct net_device *dev;
@@ -1202,13 +1204,13 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk)
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
@@ -1230,7 +1232,7 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk)
 	if (err)
 		return err;
 
-	return CFSIZ + MHSIZ;
+	return cfsiz + MHSIZ;
 }
 
 /*
@@ -1248,7 +1250,15 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
@@ -1282,12 +1292,6 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
@@ -1301,14 +1305,14 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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
@@ -1331,7 +1335,7 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		if ((msg_head.nframes != 1) || (size != CFSIZ + MHSIZ))
 			ret = -EINVAL;
 		else
-			ret = bcm_tx_send(msg, ifindex, sk);
+			ret = bcm_tx_send(msg, ifindex, sk, CFSIZ);
 		break;
 
 	default:
-- 
2.8.1

