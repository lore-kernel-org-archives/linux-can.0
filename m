From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: [PATCH -stable 1/3] can: kvaser_usb: Avoid double free on URB submission failures
Date: Sat, 21 Mar 2015 04:03:22 +0200
Message-ID: <1426903404-22925-2-git-send-email-ahmed.darwish@valeo.com>
References: <1426903404-22925-1-git-send-email-ahmed.darwish@valeo.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34780 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbbCUCEN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Mar 2015 22:04:13 -0400
Received: by wibg7 with SMTP id g7so1857047wib.1
        for <linux-can@vger.kernel.org>; Fri, 20 Mar 2015 19:04:12 -0700 (PDT)
In-Reply-To: <1426903404-22925-1-git-send-email-ahmed.darwish@valeo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Olivier Sobrie <olivier@sobrie.be>
Cc: Linux-CAN <linux-can@vger.kernel.org>, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>

From: "Ahmed S. Darwish" <ahmed.darwish@valeo.com>

Upon a URB submission failure, the driver calls usb_free_urb()
but then manually frees the URB buffer by itself.  Meanwhile
usb_free_urb() has alredy freed out that transfer buffer since
we're the only code path holding a reference to this URB.

Remove two of such invalid manual free().

This is a backport of upstream commit: deb2701cf704a2

Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
---
 drivers/net/can/usb/kvaser_usb.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 7af379c..db43c5a 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -595,7 +595,6 @@ static int kvaser_usb_simple_msg_async(struct kvaser_usb_net_priv *priv,
 		netdev_err(netdev, "Error transmitting URB\n");
 		usb_unanchor_urb(urb);
 		usb_free_urb(urb);
-		kfree(buf);
 		return err;
 	}
 
@@ -1278,8 +1277,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	struct urb *urb;
 	void *buf;
 	struct kvaser_msg *msg;
-	int i, err;
-	int ret = NETDEV_TX_OK;
+	int i, err, ret = NETDEV_TX_OK;
 
 	if (can_dropped_invalid_skb(netdev, skb))
 		return NETDEV_TX_OK;
@@ -1296,7 +1294,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	if (!buf) {
 		stats->tx_dropped++;
 		dev_kfree_skb(skb);
-		goto nobufmem;
+		goto freeurb;
 	}
 
 	msg = buf;
@@ -1333,8 +1331,10 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
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
@@ -1371,16 +1371,12 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
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
1.7.7.6

