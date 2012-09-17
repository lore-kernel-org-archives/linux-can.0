From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH] can: sja1000: Add support for listen-only mode and one-shot mode
Date: Mon, 17 Sep 2012 17:58:02 +0200
Message-ID: <1347897482-26379-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:51092 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756927Ab2IQRuM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Sep 2012 13:50:12 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: software@gaisler.com

Packages that fails to be transmitted in one-shot mode are never the
less echoed back as sja1000 does not give any indication when a single
transmission has failed.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/net/can/sja1000/sja1000.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 4c4f33d..cc771d9 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -141,6 +141,7 @@ static void set_normal_mode(struct net_device *dev)
 	struct sja1000_priv *priv = netdev_priv(dev);
 	unsigned char status = priv->read_reg(priv, REG_MOD);
 	int i;
+	u8 normal = priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY ? MOD_LOM : 0;
 
 	for (i = 0; i < 100; i++) {
 		/* check reset bit */
@@ -156,7 +157,7 @@ static void set_normal_mode(struct net_device *dev)
 		}
 
 		/* set chip to normal mode */
-		priv->write_reg(priv, REG_MOD, 0x00);
+		priv->write_reg(priv, REG_MOD, normal);
 		udelay(10);
 		status = priv->read_reg(priv, REG_MOD);
 	}
@@ -278,6 +279,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	canid_t id;
 	uint8_t dreg;
 	int i;
+	u8 oneshot;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -310,7 +312,8 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 
 	can_put_echo_skb(skb, dev, 0);
 
-	sja1000_write_cmdreg(priv, CMD_TR);
+	oneshot = (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT) ? CMD_AT : 0;
+	sja1000_write_cmdreg(priv, CMD_TR | oneshot);
 
 	return NETDEV_TX_OK;
 }
@@ -605,7 +608,8 @@ struct net_device *alloc_sja1000dev(int sizeof_priv)
 	priv->can.do_set_mode = sja1000_set_mode;
 	priv->can.do_get_berr_counter = sja1000_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
-		CAN_CTRLMODE_BERR_REPORTING;
+		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LISTENONLY |
+		CAN_CTRLMODE_ONE_SHOT;
 
 	spin_lock_init(&priv->cmdreg_lock);
 
-- 
1.7.0.4

