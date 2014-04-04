From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 03/10] can: c_can: Do not access skb after net_receive_skb()
Date: Fri, 04 Apr 2014 15:24:24 -0000
Message-ID: <20140404134856.671853386@linutronix.de>
References: <20140404134816.751883017@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41523 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbaDDPYM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 11:24:12 -0400
Content-Disposition: inline;
 filename=can-c_can-do-not-access-skb-after-netif_rx.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

There is no guarantee that the skb is in the same state after calling
net_receive_skb(). It might be freed or reused.

The whole can subsystem is full of this. Copy and paste ....

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-can/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-can.orig/drivers/net/can/c_can/c_can.c
+++ linux-can/drivers/net/can/c_can/c_can.c
@@ -429,10 +429,10 @@ static int c_can_read_msg_object(struct
 		}
 	}
 
-	netif_receive_skb(skb);
-
 	stats->rx_packets++;
 	stats->rx_bytes += frame->can_dlc;
+
+	netif_receive_skb(skb);
 	return 0;
 }
 
@@ -960,9 +960,9 @@ static int c_can_handle_state_change(str
 		break;
 	}
 
-	netif_receive_skb(skb);
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
+	netif_receive_skb(skb);
 
 	return 1;
 }
@@ -1033,10 +1033,9 @@ static int c_can_handle_bus_err(struct n
 	/* set a `lec` value so that we can check for updates later */
 	priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
 
-	netif_receive_skb(skb);
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-
+	netif_receive_skb(skb);
 	return 1;
 }
 


