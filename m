From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/9] can: kvaser_usb: free buf in error paths
Date: Fri,  1 Dec 2017 15:17:31 +0100
Message-ID: <20171201141739.5816-2-mkl@pengutronix.de>
References: <20171201141739.5816-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37931 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752881AbdLAORs (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Fri, 1 Dec 2017 09:17:48 -0500
In-Reply-To: <20171201141739.5816-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Jimmy Assarsson <jimmyassarsson@gmail.com>

The allocated buffer was not freed if usb_submit_urb() failed.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 9b18d96ef526..075644591498 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -813,6 +813,7 @@ static int kvaser_usb_simple_msg_async(struct kvaser_usb_net_priv *priv,
 	if (err) {
 		netdev_err(netdev, "Error transmitting URB\n");
 		usb_unanchor_urb(urb);
+		kfree(buf);
 		usb_free_urb(urb);
 		return err;
 	}
@@ -1768,6 +1769,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 		spin_unlock_irqrestore(&priv->tx_contexts_lock, flags);
 
 		usb_unanchor_urb(urb);
+		kfree(buf);
 
 		stats->tx_dropped++;
 
-- 
2.15.0

