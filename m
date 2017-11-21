From: Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: [PATCH 1/3] can: kvaser_usb: free buf in error paths
Date: Tue, 21 Nov 2017 08:22:26 +0100
Message-ID: <20171121072228.7570-2-jimmyassarsson@gmail.com>
References: <20171121072228.7570-1-jimmyassarsson@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38474 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbdKUHWm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Nov 2017 02:22:42 -0500
Received: by mail-lf0-f67.google.com with SMTP id c188so5398495lfd.5
        for <linux-can@vger.kernel.org>; Mon, 20 Nov 2017 23:22:41 -0800 (PST)
In-Reply-To: <20171121072228.7570-1-jimmyassarsson@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>

The allocated buffer was not freed if usb_submit_urb() failed.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
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

