From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH 3/4] can: cc770: Fix queue stall due to RTR
Date: Mon, 29 Jan 2018 15:47:38 +0000
Message-ID: <20180129154739.21427-3-andri.yngvason@marel.com>
References: <20180129154739.21427-1-andri.yngvason@marel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve1eur01on0040.outbound.protection.outlook.com ([104.47.1.40]:11136
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751898AbeA2PsV (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 29 Jan 2018 10:48:21 -0500
In-Reply-To: <20180129154739.21427-1-andri.yngvason@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com, Andri Yngvason <andri.yngvason@marel.com>

According to the CC770 datasheed the id of a message object should not be
changed while the MSGVAL bit is set. This has been fixed by resetting the
MSGVAL bit before modifying the object in the transmit function and setting
it after.

It is important to keep the MSGVAL bit reset while the message object is
being modified. Otherwise, during RTR transmission, a frame with matching
id could trigger an rx-interrupt, which would cause a race condition
between the interrupt routine and the transmit function.

While waiting for the TX object to send an RTR, an external message with a
matching id can overwrite the TX data. In this case we must call the rx
routine.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
 drivers/net/can/cc770/cc770.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 12d3b89..8f32357 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -418,10 +418,10 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		rtr = 0;
 	else
 		rtr = MSGCFG_DIR;
-	cc770_write_reg(priv, msgobj[mo].ctrl1,
-			RMTPND_RES | TXRQST_RES | CPUUPD_SET | NEWDAT_RES);
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_SET | TXIE_SET | RXIE_RES | INTPND_RES);
+			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
+	cc770_write_reg(priv, msgobj[mo].ctrl1,
+			RMTPND_RES | TXRQST_RES | CPUUPD_SET | NEWDAT_SET);
 	if (id & CAN_EFF_FLAG) {
 		id &= CAN_EFF_MASK;
 		cc770_write_reg(priv, msgobj[mo].config,
@@ -444,7 +444,9 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	can_put_echo_skb(skb, dev, 0);
 
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
-			RMTPND_RES | TXRQST_SET | CPUUPD_RES | NEWDAT_UNC);
+			RMTPND_UNC | TXRQST_SET | CPUUPD_RES | NEWDAT_UNC);
+	cc770_write_reg(priv, msgobj[mo].ctrl0,
+			MSGVAL_SET | TXIE_SET | RXIE_SET | INTPND_UNC);
 
 	stats->tx_bytes += dlc;
 
@@ -672,13 +674,24 @@ static void cc770_tx_interrupt(struct net_device *dev, unsigned int o)
 	struct cc770_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	unsigned int mo = obj2msgobj(o);
+	u8 ctrl1;
+
+	ctrl1 = cc770_read_reg(priv, msgobj[mo].ctrl1);
 
-	/* Nothing more to send, switch off interrupts */
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
+	cc770_write_reg(priv, msgobj[mo].ctrl1,
+			RMTPND_RES | TXRQST_RES | MSGLST_RES | NEWDAT_RES);
+
+	if (ctrl1 & MSGLST_RES) {
+		can_get_echo_skb(dev, 0);
+		stats->tx_packets++;
+	} else {
+		can_free_echo_skb(dev, 0);
+		cc770_rx(dev, mo, ctrl1);
+		stats->tx_dropped++;
+	}
 
-	stats->tx_packets++;
-	can_get_echo_skb(dev, 0);
 	netif_wake_queue(dev);
 }
 
-- 
1.9.1

