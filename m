From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v2 1/7] pch_can: add spinlocks to protect tx objects
Date: Thu, 29 Nov 2012 15:39:41 +0100
Message-ID: <1354199987-10350-2-git-send-email-wg@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44188 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab2K2Ojz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 09:39:55 -0500
In-Reply-To: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bhupesh.sharma@st.com, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/pch_can.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 48b3d62..442a04f 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -182,6 +182,7 @@ struct pch_can_priv {
 	struct napi_struct napi;
 	int tx_obj;	/* Point next Tx Obj index */
 	int use_msi;
+	spinlock_t lock;	/* to protect tx objects */
 };
 
 static const struct can_bittiming_const pch_can_bittiming_const = {
@@ -724,6 +725,8 @@ static void pch_can_tx_complete(struct net_device *ndev, u32 int_stat)
 	struct net_device_stats *stats = &(priv->ndev->stats);
 	u32 dlc;
 
+	spin_lock_bh(&priv->lock);
+
 	can_get_echo_skb(ndev, int_stat - PCH_RX_OBJ_END - 1);
 	iowrite32(PCH_CMASK_RX_TX_GET | PCH_CMASK_CLRINTPND,
 		  &priv->regs->ifregs[1].cmask);
@@ -734,6 +737,8 @@ static void pch_can_tx_complete(struct net_device *ndev, u32 int_stat)
 	stats->tx_packets++;
 	if (int_stat == PCH_TX_OBJ_END)
 		netif_wake_queue(ndev);
+
+	spin_unlock_bh(&priv->lock);
 }
 
 static int pch_can_poll(struct napi_struct *napi, int quota)
@@ -901,6 +906,8 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (can_dropped_invalid_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
+	spin_lock_bh(&priv->lock);
+
 	tx_obj_no = priv->tx_obj;
 	if (priv->tx_obj == PCH_TX_OBJ_END) {
 		if (ioread32(&priv->regs->treq2) & PCH_TREQ2_TX_MASK)
@@ -911,6 +918,8 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *ndev)
 		priv->tx_obj++;
 	}
 
+	spin_unlock_bh(&priv->lock);
+
 	/* Setting the CMASK register. */
 	pch_can_bit_set(&priv->regs->ifregs[1].cmask, PCH_CMASK_ALL);
 
-- 
1.7.9.5

