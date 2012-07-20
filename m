From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/9] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Fri, 20 Jul 2012 13:11:47 +0200
Message-ID: <1342782709-4868-8-git-send-email-mkl@pengutronix.de>
References: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42092 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2GTLL4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jul 2012 07:11:56 -0400
In-Reply-To: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

The Janz VMOD-ICAN3 firmware does not support any sort of TX-done
notification or interrupt. The driver previously used the hardware
loopback to attempt to work around this deficiency, but this caused all
sockets to receive all messages, even if CAN_RAW_RECV_OWN_MSGS is off.

Using the new function ican3_cmp_echo_skb(), we can drop the loopback
messages and return the original skbs. This fixes the issues with
CAN_RAW_RECV_OWN_MSGS.

A private skb queue is used to store the echo skbs. This avoids the need
for any index management.

Due to a lack of TX-error interrupts, bus errors are permanently
enabled, and are used as a TX-error notification. This is used to drop
an echo skb when transmission fails. Bus error packets are not generated
if the user has not enabled bus error reporting.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/janz-ican3.c |  203 ++++++++++++++++++++++++++++++++----------
 1 file changed, 157 insertions(+), 46 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 4a5a8fb..47f8f6b 100644
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
@@ -925,7 +928,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 	struct net_device *dev = mod->ndev;
 	struct net_device_stats *stats = &dev->stats;
 	enum can_state state = mod->can.state;
-	u8 status, isrc, rxerr, txerr;
+	u8 isrc, ecc, status, rxerr, txerr;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 
@@ -941,15 +944,43 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 		return -EINVAL;
 	}
 
-	skb = alloc_can_err_skb(dev, &cf);
-	if (skb == NULL)
-		return -ENOMEM;
-
 	isrc = msg->data[0];
+	ecc = msg->data[2];
 	status = msg->data[3];
 	rxerr = msg->data[4];
 	txerr = msg->data[5];
 
+	/*
+	 * This hardware lacks any support other than bus error messages to
+	 * determine if packet transmission has failed.
+	 *
+	 * When TX errors happen, one echo skb needs to be dropped from the
+	 * front of the queue.
+	 *
+	 * A small bit of code is duplicated here and below, to avoid error
+	 * skb allocation when it will just be freed immediately.
+	 */
+	if (isrc == CEVTIND_BEI) {
+		int ret;
+		dev_dbg(mod->dev, "bus error interrupt\n");
+
+		/* TX error */
+		if (!(ecc & ECC_DIR)) {
+			kfree_skb(skb_dequeue(&mod->echoq));
+			stats->tx_errors++;
+		} else {
+			stats->rx_errors++;
+		}
+
+		/* bus error reporting is off, return immediately */
+		if (!(mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
+			return 0;
+	}
+
+	skb = alloc_can_err_skb(dev, &cf);
+	if (skb == NULL)
+		return -ENOMEM;
+
 	/* data overrun interrupt */
 	if (isrc == CEVTIND_DOI || isrc == CEVTIND_LOST) {
 		dev_dbg(mod->dev, "data overrun interrupt\n");
@@ -978,9 +1009,6 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 
 	/* bus error interrupt */
 	if (isrc == CEVTIND_BEI) {
-		u8 ecc = msg->data[2];
-
-		dev_dbg(mod->dev, "bus error interrupt\n");
 		mod->can.can_stats.bus_error++;
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
@@ -1000,12 +1028,8 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 			break;
 		}
 
-		if (!(ecc & ECC_DIR)) {
+		if (!(ecc & ECC_DIR))
 			cf->data[2] |= CAN_ERR_PROT_TX;
-			stats->tx_errors++;
-		} else {
-			stats->rx_errors++;
-		}
 
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
@@ -1090,6 +1114,88 @@ static void ican3_handle_message(struct ican3_dev *mod, struct ican3_msg *msg)
 }
 
 /*
+ * The ican3 needs to store all echo skbs, and therefore cannot
+ * use the generic infrastructure for this.
+ */
+static void ican3_put_echo_skb(struct ican3_dev *mod, struct sk_buff *skb)
+{
+	struct sock *srcsk = skb->sk;
+
+	if (atomic_read(&skb->users) != 1) {
+		struct sk_buff *old_skb = skb;
+
+		skb = skb_clone(old_skb, GFP_ATOMIC);
+		kfree_skb(old_skb);
+		if (!skb)
+			return;
+	} else {
+		skb_orphan(skb);
+	}
+
+	skb->sk = srcsk;
+
+	/* save this skb for tx interrupt echo handling */
+	skb_queue_tail(&mod->echoq, skb);
+}
+
+static unsigned int ican3_get_echo_skb(struct ican3_dev *mod)
+{
+	struct sk_buff *skb = skb_dequeue(&mod->echoq);
+	struct can_frame *cf;
+	u8 dlc;
+
+	/* this should never trigger unless there is a driver bug */
+	if (!skb) {
+		netdev_err(mod->ndev, "BUG: echo skb not occupied\n");
+		return 0;
+	}
+
+	cf = (struct can_frame *)skb->data;
+	dlc = cf->can_dlc;
+
+	/* check flag whether this packet has to be looped back */
+	if (skb->pkt_type != PACKET_LOOPBACK) {
+		kfree_skb(skb);
+		return dlc;
+	}
+
+	skb->protocol = htons(ETH_P_CAN);
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb->dev = mod->ndev;
+	netif_receive_skb(skb);
+	return dlc;
+}
+
+/*
+ * Compare an skb with an existing echo skb
+ *
+ * This function will be used on devices which have a hardware loopback.
+ * On these devices, this function can be used to compare a received skb
+ * with the saved echo skbs so that the hardware echo skb can be dropped.
+ *
+ * Returns true if the skb's are identical, false otherwise.
+ */
+static bool ican3_echo_skb_matches(struct ican3_dev *mod, struct sk_buff *skb)
+{
+	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct sk_buff *echo_skb = skb_peek(&mod->echoq);
+	struct can_frame *echo_cf;
+
+	if (!echo_skb)
+		return false;
+
+	echo_cf = (struct can_frame *)echo_skb->data;
+	if (cf->can_id != echo_cf->can_id)
+		return false;
+
+	if (cf->can_dlc != echo_cf->can_dlc)
+		return false;
+
+	return memcmp(cf->data, echo_cf->data, cf->can_dlc) == 0;
+}
+
+/*
  * Check that there is room in the TX ring to transmit another skb
  *
  * LOCKING: must hold mod->lock
@@ -1099,6 +1205,10 @@ static bool ican3_txok(struct ican3_dev *mod)
 	struct ican3_fast_desc __iomem *desc;
 	u8 control;
 
+	/* check that we have echo queue space */
+	if (skb_queue_len(&mod->echoq) >= ICAN3_TX_BUFFERS)
+		return false;
+
 	/* copy the control bits of the descriptor */
 	ican3_set_page(mod, mod->fasttx_start + (mod->fasttx_num / 16));
 	desc = mod->dpm + ((mod->fasttx_num % 16) * sizeof(*desc));
@@ -1149,10 +1259,27 @@ static int ican3_recv_skb(struct ican3_dev *mod)
 	/* convert the ICAN3 frame into Linux CAN format */
 	ican3_to_can_frame(mod, &desc, cf);
 
-	/* receive the skb, update statistics */
-	netif_receive_skb(skb);
+	/*
+	 * If this is an ECHO frame received from the hardware loopback
+	 * feature, use the skb saved in the ECHO stack instead. This allows
+	 * the Linux CAN core to support CAN_RAW_RECV_OWN_MSGS correctly.
+	 *
+	 * Since this is a confirmation of a successfully transmitted packet
+	 * sent from this host, update the transmit statistics.
+	 *
+	 * Also, the netdevice queue needs to be allowed to send packets again.
+	 */
+	if (ican3_echo_skb_matches(mod, skb)) {
+		stats->tx_packets++;
+		stats->tx_bytes += ican3_get_echo_skb(mod);
+		kfree_skb(skb);
+		goto err_noalloc;
+	}
+
+	/* update statistics, receive the skb */
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
+	netif_receive_skb(skb);
 
 err_noalloc:
 	/* toggle the valid bit and return the descriptor to the ring */
@@ -1175,13 +1302,13 @@ err_noalloc:
 static int ican3_napi(struct napi_struct *napi, int budget)
 {
 	struct ican3_dev *mod = container_of(napi, struct ican3_dev, napi);
-	struct ican3_msg msg;
 	unsigned long flags;
 	int received = 0;
 	int ret;
 
 	/* process all communication messages */
 	while (true) {
+		struct ican3_msg msg;
 		ret = ican3_recv_msg(mod, &msg);
 		if (ret)
 			break;
@@ -1353,7 +1480,6 @@ static int __devinit ican3_startup_module(struct ican3_dev *mod)
 static int ican3_open(struct net_device *ndev)
 {
 	struct ican3_dev *mod = netdev_priv(ndev);
-	u8 quota;
 	int ret;
 
 	/* open the CAN layer */
@@ -1363,19 +1489,6 @@ static int ican3_open(struct net_device *ndev)
 		return ret;
 	}
 
-	/* set the bus error generation state appropriately */
-	if (mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-		quota = ICAN3_BUSERR_QUOTA_MAX;
-	else
-		quota = 0;
-
-	ret = ican3_set_buserror(mod, quota);
-	if (ret) {
-		dev_err(mod->dev, "unable to set bus-error\n");
-		close_candev(ndev);
-		return ret;
-	}
-
 	/* bring the bus online */
 	ret = ican3_set_bus_state(mod, true);
 	if (ret) {
@@ -1407,6 +1520,9 @@ static int ican3_stop(struct net_device *ndev)
 		return ret;
 	}
 
+	/* drop all outstanding echo skbs */
+	skb_queue_purge(&mod->echoq);
+
 	/* close the CAN layer */
 	close_candev(ndev);
 	return 0;
@@ -1415,7 +1531,6 @@ static int ican3_stop(struct net_device *ndev)
 static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ican3_dev *mod = netdev_priv(ndev);
-	struct net_device_stats *stats = &ndev->stats;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	struct ican3_fast_desc desc;
 	void __iomem *desc_addr;
@@ -1428,8 +1543,7 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	/* check that we can actually transmit */
 	if (!ican3_txok(mod)) {
-		dev_err(mod->dev, "no free descriptors, stopping queue\n");
-		netif_stop_queue(ndev);
+		dev_err(mod->dev, "BUG: no free descriptors\n");
 		spin_unlock_irqrestore(&mod->lock, flags);
 		return NETDEV_TX_BUSY;
 	}
@@ -1444,6 +1558,14 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	can_frame_to_ican3(mod, cf, &desc);
 
 	/*
+	 * This hardware doesn't have TX-done notifications, so we'll try and
+	 * emulate it the best we can using ECHO skbs. Add the skb to the ECHO
+	 * stack. Upon packet reception, check if the ECHO skb and received
+	 * skb match, and use that to wake the queue.
+	 */
+	ican3_put_echo_skb(mod, skb);
+
+	/*
 	 * the programming manual says that you must set the IVALID bit, then
 	 * interrupt, then set the valid bit. Quite weird, but it seems to be
 	 * required for this to work
@@ -1461,19 +1583,7 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	mod->fasttx_num = (desc.control & DESC_WRAP) ? 0
 						     : (mod->fasttx_num + 1);
 
-	/* update statistics */
-	stats->tx_packets++;
-	stats->tx_bytes += cf->can_dlc;
-	kfree_skb(skb);
-
-	/*
-	 * This hardware doesn't have TX-done notifications, so we'll try and
-	 * emulate it the best we can using ECHO skbs. Get the next TX
-	 * descriptor, and see if we have room to send. If not, stop the queue.
-	 * It will be woken when the ECHO skb for the current packet is recv'd.
-	 */
-
-	/* copy the control bits of the descriptor */
+	/* if there is no free descriptor space, stop the transmit queue */
 	if (!ican3_txok(mod))
 		netif_stop_queue(ndev);
 
@@ -1669,6 +1779,7 @@ static int __devinit ican3_probe(struct platform_device *pdev)
 	mod->dev = &pdev->dev;
 	mod->num = pdata->modno;
 	netif_napi_add(ndev, &mod->napi, ican3_napi, ICAN3_RX_BUFFERS);
+	skb_queue_head_init(&mod->echoq);
 	spin_lock_init(&mod->lock);
 	init_completion(&mod->termination_comp);
 	init_completion(&mod->buserror_comp);
-- 
1.7.10

