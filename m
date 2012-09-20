From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v5] can: sja1000: Add support for listen-only mode and one-shot mode
Date: Thu, 20 Sep 2012 09:50:41 +0200
Message-ID: <1348127441-2165-1-git-send-email-andreas@gaisler.com>
References: <5059F783.5030200@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:50269 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753306Ab2ITHwf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Sep 2012 03:52:35 -0400
In-Reply-To: <5059F783.5030200@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: software@gaisler.com

One-shot mode uses the TCS bit of the status register to discern
whether a transmission was successful or not. On a failed
transmission, the frame is not echoed back.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/sja1000/sja1000.c |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 4c4f33d..25011db 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -156,8 +156,13 @@ static void set_normal_mode(struct net_device *dev)
 		}
 
 		/* set chip to normal mode */
-		priv->write_reg(priv, REG_MOD, 0x00);
+		if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+			priv->write_reg(priv, REG_MOD, MOD_LOM);
+		else
+			priv->write_reg(priv, REG_MOD, 0x00);
+
 		udelay(10);
+
 		status = priv->read_reg(priv, REG_MOD);
 	}
 
@@ -310,7 +315,10 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 
 	can_put_echo_skb(skb, dev, 0);
 
-	sja1000_write_cmdreg(priv, CMD_TR);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		sja1000_write_cmdreg(priv, CMD_TR | CMD_AT);
+	else
+		sja1000_write_cmdreg(priv, CMD_TR);
 
 	return NETDEV_TX_OK;
 }
@@ -505,10 +513,18 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 			netdev_warn(dev, "wakeup interrupt\n");
 
 		if (isrc & IRQ_TI) {
-			/* transmission complete interrupt */
-			stats->tx_bytes += priv->read_reg(priv, REG_FI) & 0xf;
-			stats->tx_packets++;
-			can_get_echo_skb(dev, 0);
+			/* transmission buffer released */
+			if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT &&
+			    !(status & SR_TCS)) {
+				stats->tx_errors++;
+				can_free_echo_skb(dev, 0);
+			} else {
+				/* transmission complete */
+				stats->tx_bytes +=
+					priv->read_reg(priv, REG_FI) & 0xf;
+				stats->tx_packets++;
+				can_get_echo_skb(dev, 0);
+			}
 			netif_wake_queue(dev);
 		}
 		if (isrc & IRQ_RI) {
@@ -605,7 +621,8 @@ struct net_device *alloc_sja1000dev(int sizeof_priv)
 	priv->can.do_set_mode = sja1000_set_mode;
 	priv->can.do_get_berr_counter = sja1000_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
-		CAN_CTRLMODE_BERR_REPORTING;
+		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LISTENONLY |
+		CAN_CTRLMODE_ONE_SHOT;
 
 	spin_lock_init(&priv->cmdreg_lock);
 
-- 
1.7.0.4

