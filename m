From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v3 1/7] pch_can: add spinlocks to protect tx objects
Date: Tue, 11 Dec 2012 22:18:48 +0100
Message-ID: <1355260735-18994-2-git-send-email-wg@grandegger.com>
References: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59216 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab2LKVTN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Dec 2012 16:19:13 -0500
In-Reply-To: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander.Stein@systec-electronic.com, Christian.Bendele@gmx.net, Michael Pellegrini <mikep86@gmail.com>, bhupesh.sharma@st.com, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/pch_can.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 7d17485..af61961 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -182,6 +182,7 @@ struct pch_can_priv {
 	struct napi_struct napi;
 	int tx_obj;	/* Point next Tx Obj index */
 	int use_msi;
+	spinlock_t lock;	/* to protect tx objects */
 };
 
 static const struct can_bittiming_const pch_can_bittiming_const = {
@@ -722,8 +723,11 @@ static void pch_can_tx_complete(struct net_device *ndev, u32 int_stat)
 {
 	struct pch_can_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &(priv->ndev->stats);
+	unsigned long flags;
 	u32 dlc;
 
+	spin_lock_irqsave(&priv->lock, flags);
+
 	can_get_echo_skb(ndev, int_stat - PCH_RX_OBJ_END - 1);
 	iowrite32(PCH_CMASK_RX_TX_GET | PCH_CMASK_CLRINTPND,
 		  &priv->regs->ifregs[1].cmask);
@@ -734,6 +738,8 @@ static void pch_can_tx_complete(struct net_device *ndev, u32 int_stat)
 	stats->tx_packets++;
 	if (int_stat == PCH_TX_OBJ_END)
 		netif_wake_queue(ndev);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 static int pch_can_poll(struct napi_struct *napi, int quota)
@@ -894,6 +900,7 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct pch_can_priv *priv = netdev_priv(ndev);
 	struct can_frame *cf = (struct can_frame *)skb->data;
+	unsigned long flags;
 	int tx_obj_no;
 	int i;
 	u32 id2;
@@ -901,6 +908,8 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (can_dropped_invalid_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
+	spin_lock_irqsave(&priv->lock, flags);
+
 	tx_obj_no = priv->tx_obj;
 	if (priv->tx_obj == PCH_TX_OBJ_END) {
 		if (ioread32(&priv->regs->treq2) & PCH_TREQ2_TX_MASK)
@@ -911,6 +920,8 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *ndev)
 		priv->tx_obj++;
 	}
 
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	/* Setting the CMASK register. */
 	pch_can_bit_set(&priv->regs->ifregs[1].cmask, PCH_CMASK_ALL);
 
-- 
1.7.9.5

