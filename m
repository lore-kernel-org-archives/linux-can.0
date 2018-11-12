From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 03/20] can: kvaser_usb: Fix accessing freed memory in kvaser_usb_start_xmit()
Date: Mon, 12 Nov 2018 12:57:11 +0100
Message-ID: <20181112115728.18331-4-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Jimmy Assarsson <jimmyassarsson@gmail.com>

The call to can_put_echo_skb() may result in the skb being freed. The skb
is later used in the call to dev->ops->dev_frame_to_cmd().

This is avoided by moving the call to can_put_echo_skb() after
dev->ops->dev_frame_to_cmd().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index b939a4c10b84..c89c7d4900d7 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -528,7 +528,6 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 			context = &priv->tx_contexts[i];
 
 			context->echo_index = i;
-			can_put_echo_skb(skb, netdev, context->echo_index);
 			++priv->active_tx_contexts;
 			if (priv->active_tx_contexts >= (int)dev->max_tx_urbs)
 				netif_stop_queue(netdev);
@@ -553,7 +552,6 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 		dev_kfree_skb(skb);
 		spin_lock_irqsave(&priv->tx_contexts_lock, flags);
 
-		can_free_echo_skb(netdev, context->echo_index);
 		context->echo_index = dev->max_tx_urbs;
 		--priv->active_tx_contexts;
 		netif_wake_queue(netdev);
@@ -564,6 +562,8 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 
 	context->priv = priv;
 
+	can_put_echo_skb(skb, netdev, context->echo_index);
+
 	usb_fill_bulk_urb(urb, dev->udev,
 			  usb_sndbulkpipe(dev->udev,
 					  dev->bulk_out->bEndpointAddress),
-- 
2.19.1
