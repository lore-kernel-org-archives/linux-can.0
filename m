From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 2/3] can: janz-ican3: increase tx buffer size
Date: Thu, 12 Jul 2012 09:15:31 -0700
Message-ID: <1342109732-4995-3-git-send-email-iws@ovro.caltech.edu>
References: <1342109732-4995-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:43745 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab2GLQPf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Jul 2012 12:15:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 938CA2229C
	for <linux-can@vger.kernel.org>; Thu, 12 Jul 2012 09:15:35 -0700 (PDT)
In-Reply-To: <1342109732-4995-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

Using an skb queue allows the driver to increase the buffer size without
any difficult index management.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

The index management in the echo skb array is tricky, and so I used an SKB
queue instead. It tracks the length of the queue, and makes it easy to stop
the transmit queue when it becomes full.

If you think this is an OK idea, please merge this into the previous patch.
I kept them split just in case you don't like it.

 drivers/net/can/janz-ican3.c |  103 +++++++++++++++++++++---------------------
 1 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 0f48136..5fff829 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -220,6 +220,9 @@ struct ican3_dev {
 	/* old and new style host interface */
 	unsigned int iftype;
 
+	/* queue for echo packets */
+	struct sk_buff_head echoq;
+
 	/*
 	 * Any function which changes the current DPM page must hold this
 	 * lock while it is performing data accesses. This ensures that the
@@ -1092,54 +1095,37 @@ static void ican3_handle_message(struct ican3_dev *mod, struct ican3_msg *msg)
  * The ican3 needs to store all echo skbs, and therefore cannot
  * use the generic infrastructure for this.
  */
-static void ican3_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
-			       unsigned int idx)
+static void ican3_put_echo_skb(struct ican3_dev *mod, struct sk_buff *skb)
 {
-	struct can_priv *priv = netdev_priv(dev);
-
-	BUG_ON(idx >= priv->echo_skb_max);
-
-	if (!priv->echo_skb[idx]) {
-		struct sock *srcsk = skb->sk;
+	struct sock *srcsk = skb->sk;
 
-		if (atomic_read(&skb->users) != 1) {
-			struct sk_buff *old_skb = skb;
+	if (atomic_read(&skb->users) != 1) {
+		struct sk_buff *old_skb = skb;
 
-			skb = skb_clone(old_skb, GFP_ATOMIC);
-			kfree_skb(old_skb);
-			if (!skb)
-				return;
-		} else
-			skb_orphan(skb);
+		skb = skb_clone(old_skb, GFP_ATOMIC);
+		kfree_skb(old_skb);
+		if (!skb)
+			return;
+	} else
+		skb_orphan(skb);
 
-		skb->sk = srcsk;
+	skb->sk = srcsk;
 
-		/* save this skb for tx interrupt echo handling */
-		priv->echo_skb[idx] = skb;
-	} else {
-		/* locking problem with netif_stop_queue() ?? */
-		netdev_err(dev, "%s: BUG! echo_skb is occupied!\n", __func__);
-		kfree_skb(skb);
-	}
+	/* save this skb for tx interrupt echo handling */
+	skb_queue_tail(&mod->echoq, skb);
 }
 
-static unsigned int ican3_get_echo_skb(struct net_device *dev, unsigned int idx)
+static unsigned int ican3_get_echo_skb(struct ican3_dev *mod)
 {
-	struct can_priv *priv = netdev_priv(dev);
-	struct sk_buff *skb = priv->echo_skb[idx];
+	struct sk_buff *skb = skb_dequeue(&mod->echoq);
 	struct can_frame *cf;
 	u8 dlc;
 
-	BUG_ON(idx >= priv->echo_skb_max);
-
 	if (!skb)
 		return 0;
 
-	priv->echo_skb[idx] = NULL;
-	cf = (struct can_frame *)skb->data;
-
 	/* check flag whether this packet has to be looped back */
-	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK) {
+	if (!(mod->ndev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK) {
 		kfree_skb(skb);
 		return 0;
 	}
@@ -1148,8 +1134,9 @@ static unsigned int ican3_get_echo_skb(struct net_device *dev, unsigned int idx)
 	skb->protocol = htons(ETH_P_CAN);
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
-	skb->dev = dev;
+	skb->dev = mod->ndev;
 
+	cf = (struct can_frame *)skb->data;
 	dlc = cf->can_dlc;
 	netif_receive_skb(skb);
 
@@ -1165,16 +1152,12 @@ static unsigned int ican3_get_echo_skb(struct net_device *dev, unsigned int idx)
  *
  * Returns true if the skb's are identical, false otherwise.
  */
-static bool ican3_cmp_echo_skb(struct sk_buff *skb, struct net_device *dev,
-			       unsigned int idx)
+static bool ican3_cmp_echo_skb(struct ican3_dev *mod, struct sk_buff *skb)
 {
-	struct can_priv *priv = netdev_priv(dev);
 	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct sk_buff *echo_skb = skb_peek(&mod->echoq);
 
-	BUG_ON(idx >= priv->echo_skb_max);
-
-	if (priv->echo_skb[idx]) {
-		struct sk_buff *echo_skb = priv->echo_skb[idx];
+	if (echo_skb) {
 		struct can_frame *echo_cf = (struct can_frame *)echo_skb->data;
 
 		if (cf->can_id != echo_cf->can_id)
@@ -1199,6 +1182,10 @@ static bool ican3_txok(struct ican3_dev *mod)
 	struct ican3_fast_desc __iomem *desc;
 	u8 control;
 
+	/* check that we have echo queue space */
+	if (skb_queue_len(&mod->echoq) >= ICAN3_TX_BUFFERS)
+		return false;
+
 	/* copy the control bits of the descriptor */
 	ican3_set_page(mod, mod->fasttx_start + (mod->fasttx_num / 16));
 	desc = mod->dpm + ((mod->fasttx_num % 16) * sizeof(*desc));
@@ -1259,11 +1246,10 @@ static int ican3_recv_skb(struct ican3_dev *mod)
 	 *
 	 * Also, the netdevice queue needs to be allowed to send packets again.
 	 */
-	if (ican3_cmp_echo_skb(skb, ndev, 0)) {
+	if (ican3_cmp_echo_skb(mod, skb)) {
 		stats->tx_packets++;
-		stats->tx_bytes += ican3_get_echo_skb(ndev, 0);
+		stats->tx_bytes += ican3_get_echo_skb(mod);
 		kfree_skb(skb);
-		netif_wake_queue(ndev);
 		goto err_noalloc;
 	}
 
@@ -1293,12 +1279,13 @@ err_noalloc:
 static int ican3_napi(struct napi_struct *napi, int budget)
 {
 	struct ican3_dev *mod = container_of(napi, struct ican3_dev, napi);
-	struct ican3_msg msg;
+	unsigned long flags;
 	int received = 0;
 	int ret;
 
 	/* process all communication messages */
 	while (true) {
+		struct ican3_msg msg;
 		ret = ican3_recv_msg(mod, &msg);
 		if (ret)
 			break;
@@ -1315,6 +1302,14 @@ static int ican3_napi(struct napi_struct *napi, int budget)
 		received++;
 	}
 
+	spin_lock_irqsave(&mod->lock, flags);
+
+	/* Wake up the transmit queue if necessary */
+	if (netif_queue_stopped(mod->ndev) && ican3_txok(mod))
+		netif_wake_queue(mod->ndev);
+
+	spin_unlock_irqrestore(&mod->lock, flags);
+
 	/* We have processed all packets that the adapter had, but it
 	 * was less than our budget, stop polling */
 	if (received < budget)
@@ -1516,6 +1511,9 @@ static int ican3_stop(struct net_device *ndev)
 		return ret;
 	}
 
+	/* drop all outstanding echo skbs */
+	skb_queue_purge(&mod->echoq);
+
 	/* close the CAN layer */
 	close_candev(ndev);
 	return 0;
@@ -1553,12 +1551,10 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	/*
 	 * This hardware doesn't have TX-done notifications, so we'll try and
 	 * emulate it the best we can using ECHO skbs. Add the skb to the ECHO
-	 * stack and stop transmitting packets. Upon packet reception, check
-	 * if the ECHO skb and received skb match, and use that to wake the
-	 * queue.
+	 * stack. Upon packet reception, check if the ECHO skb and received
+	 * skb match, and use that to wake the queue.
 	 */
-	netif_stop_queue(ndev);
-	ican3_put_echo_skb(skb, ndev, 0);
+	ican3_put_echo_skb(mod, skb);
 
 	/*
 	 * the programming manual says that you must set the IVALID bit, then
@@ -1578,6 +1574,10 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	mod->fasttx_num = (desc.control & DESC_WRAP) ? 0
 						     : (mod->fasttx_num + 1);
 
+	/* if there is no free descriptor space, stop the transmit queue */
+	if (!ican3_txok(mod))
+		netif_stop_queue(ndev);
+
 	spin_unlock_irqrestore(&mod->lock, flags);
 	return NETDEV_TX_OK;
 }
@@ -1757,7 +1757,7 @@ static int __devinit ican3_probe(struct platform_device *pdev)
 	dev = &pdev->dev;
 
 	/* allocate the CAN device and private data */
-	ndev = alloc_candev(sizeof(*mod), 1);
+	ndev = alloc_candev(sizeof(*mod), 0);
 	if (!ndev) {
 		dev_err(dev, "unable to allocate CANdev\n");
 		ret = -ENOMEM;
@@ -1770,6 +1770,7 @@ static int __devinit ican3_probe(struct platform_device *pdev)
 	mod->dev = &pdev->dev;
 	mod->num = pdata->modno;
 	netif_napi_add(ndev, &mod->napi, ican3_napi, ICAN3_RX_BUFFERS);
+	skb_queue_head_init(&mod->echoq);
 	spin_lock_init(&mod->lock);
 	init_completion(&mod->termination_comp);
 	init_completion(&mod->buserror_comp);
-- 
1.7.8.6

