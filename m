From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v2] can: sja1000: Add support for listen-only mode and one-shot mode
Date: Tue, 18 Sep 2012 18:34:01 +0200
Message-ID: <1347986041-5358-1-git-send-email-andreas@gaisler.com>
References: <5058994E.8000501@gaisler.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:38391 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751006Ab2IRQeN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 12:34:13 -0400
In-Reply-To: <5058994E.8000501@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: software@gaisler.com

One-shot mode correctly refrains from trying to resend frames that
fail. However, all can frames are echoed back by can_get_echo_skb
regardless of whether they were transmitted successfully or not. When
in one-shot mode, sja1000 generates a transmit interrupt both for a
successful and a failed transmission. It is not possible to
distinguish between the cases and therefore not possible to refrain
from echoing back a frame that was not transmitted successfully.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/net/can/sja1000/sja1000.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 4c4f33d..1a2159e 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -141,6 +141,7 @@ static void set_normal_mode(struct net_device *dev)
 	struct sja1000_priv *priv = netdev_priv(dev);
 	unsigned char status = priv->read_reg(priv, REG_MOD);
 	int i;
+	u8 mod;
 
 	for (i = 0; i < 100; i++) {
 		/* check reset bit */
@@ -156,7 +157,10 @@ static void set_normal_mode(struct net_device *dev)
 		}
 
 		/* set chip to normal mode */
-		priv->write_reg(priv, REG_MOD, 0x00);
+		mod = 0;
+		if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+			mod |= MOD_LOM;
+		priv->write_reg(priv, REG_MOD, mod);
 		udelay(10);
 		status = priv->read_reg(priv, REG_MOD);
 	}
@@ -278,6 +282,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	canid_t id;
 	uint8_t dreg;
 	int i;
+	u8 cmd;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -310,7 +315,10 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 
 	can_put_echo_skb(skb, dev, 0);
 
-	sja1000_write_cmdreg(priv, CMD_TR);
+	cmd = CMD_TR;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		cmd |= CMD_AT;
+	sja1000_write_cmdreg(priv, cmd);
 
 	return NETDEV_TX_OK;
 }
@@ -605,7 +613,8 @@ struct net_device *alloc_sja1000dev(int sizeof_priv)
 	priv->can.do_set_mode = sja1000_set_mode;
 	priv->can.do_get_berr_counter = sja1000_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
-		CAN_CTRLMODE_BERR_REPORTING;
+		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LISTENONLY |
+		CAN_CTRLMODE_ONE_SHOT;
 
 	spin_lock_init(&priv->cmdreg_lock);
 
-- 
1.7.0.4

