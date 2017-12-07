From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can: peak/pcie_fd: fix potential bug in restarting tx queue
Date: Thu,  7 Dec 2017 16:13:43 +0100
Message-ID: <20171207151343.26923-1-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:25492 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753308AbdLGPPC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 7 Dec 2017 10:15:02 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

Don't rely on can_get_echo_skb() return value to wake the network tx
queue up: can_get_echo_skb() returns 0 if the echo array slot was not
occupied, but also when the DLC of the released echo frame was 0.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 85268be0c913..55513411a82e 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -258,21 +258,18 @@ static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
 	/* if this frame is an echo, */
 	if ((rx_msg_flags & PUCAN_MSG_LOOPED_BACK) &&
 	    !(rx_msg_flags & PUCAN_MSG_SELF_RECEIVE)) {
-		int n;
 		unsigned long flags;
 
 		spin_lock_irqsave(&priv->echo_lock, flags);
-		n = can_get_echo_skb(priv->ndev, msg->client);
+		can_get_echo_skb(priv->ndev, msg->client);
 		spin_unlock_irqrestore(&priv->echo_lock, flags);
 
 		/* count bytes of the echo instead of skb */
 		stats->tx_bytes += cf_len;
 		stats->tx_packets++;
 
-		if (n) {
-			/* restart tx queue only if a slot is free */
-			netif_wake_queue(priv->ndev);
-		}
+		/* restart tx queue (a slot is free) */
+		netif_wake_queue(priv->ndev);
 
 		return 0;
 	}
-- 
2.14.1

