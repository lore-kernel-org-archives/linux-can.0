From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: [PATCH 1/5] can: kvaser_usb: Avoid double free on URB submission
 failures
Date: Thu, 26 Feb 2015 10:20:11 -0500
Message-ID: <20150226152011.GA6075@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33493 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbbBZPUR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Feb 2015 10:20:17 -0500
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

From: Ahmed S. Darwish <ahmed.darwish@valeo.com>

Upon a URB submission failure, the driver calls usb_free_urb()
but then manually frees the URB buffer by itself.  Meanwhile
usb_free_urb() has alredy freed out that transfer buffer since
we're the only code path holding a reference to this URB.

Remove two of such invalid manual free().

Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
---
 drivers/net/can/usb/kvaser_usb.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 2928f70..d986fe8 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -787,7 +787,6 @@ static int kvaser_usb_simple_msg_async(struct kvaser_usb_net_priv *priv,
 		netdev_err(netdev, "Error transmitting URB\n");
 		usb_unanchor_urb(urb);
 		usb_free_urb(urb);
-		kfree(buf);
 		return err;
 	}
 
@@ -1615,8 +1614,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	struct urb *urb;
 	void *buf;
 	struct kvaser_msg *msg;
-	int i, err;
-	int ret = NETDEV_TX_OK;
+	int i, err, ret = NETDEV_TX_OK;
 	u8 *msg_tx_can_flags = NULL;		/* GCC */
 
 	if (can_dropped_invalid_skb(netdev, skb))
@@ -1634,7 +1632,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	if (!buf) {
 		stats->tx_dropped++;
 		dev_kfree_skb(skb);
-		goto nobufmem;
+		goto freeurb;
 	}
 
 	msg = buf;
@@ -1681,8 +1679,10 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	/* This should never happen; it implies a flow control bug */
 	if (!context) {
 		netdev_warn(netdev, "cannot find free context\n");
+
+		kfree(buf);
 		ret =  NETDEV_TX_BUSY;
-		goto releasebuf;
+		goto freeurb;
 	}
 
 	context->priv = priv;
@@ -1719,16 +1719,12 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 		else
 			netdev_warn(netdev, "Failed tx_urb %d\n", err);
 
-		goto releasebuf;
+		goto freeurb;
 	}
 
-	usb_free_urb(urb);
-
-	return NETDEV_TX_OK;
+	ret = NETDEV_TX_OK;
 
-releasebuf:
-	kfree(buf);
-nobufmem:
+freeurb:
 	usb_free_urb(urb);
 	return ret;
 }
-- 
1.9.1

