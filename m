From: Stefano Babic <sbabic@denx.de>
Subject: [PATCH v1 3/3] Introduce can_get_echo_skb_ni() when TX is not in interrupt
Date: Fri, 21 Mar 2014 13:25:58 +0100
Message-ID: <1395404758-21977-4-git-send-email-sbabic@denx.de>
References: <1395404758-21977-1-git-send-email-sbabic@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp2.ngi.it ([88.149.128.113]:37790 "EHLO smtp2.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759833AbaCUMe2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 21 Mar 2014 08:34:28 -0400
In-Reply-To: <1395404758-21977-1-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, socketcan@hartkopp.net, Stefano Babic <sbabic@denx.de>

Drivers that do not have TX inside an interrupt handler must
call this function that replaces netif_rx with netif_rx_ni.

Signed-off-by: Stefano Babic <sbabic@denx.de>
---

 drivers/net/can/dev.c   |   21 +++++++++++++++++++++
 include/linux/can/dev.h |    1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index fc59bc6..53081fd 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -372,6 +372,27 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
 }
 EXPORT_SYMBOL_GPL(can_get_echo_skb);
 
+unsigned int can_get_echo_skb_ni(struct net_device *dev, unsigned int idx)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	BUG_ON(idx >= priv->echo_skb_max);
+
+	if (priv->echo_skb[idx]) {
+		struct sk_buff *skb = priv->echo_skb[idx];
+		struct can_frame *cf = (struct can_frame *)skb->data;
+		u8 dlc = cf->can_dlc;
+
+		netif_rx_ni(priv->echo_skb[idx]);
+		priv->echo_skb[idx] = NULL;
+
+		return dlc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_get_echo_skb_ni);
+
 /*
   * Remove the skb from the stack and free it.
   *
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index fb0ab65..57b678a 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -121,6 +121,7 @@ void can_bus_off(struct net_device *dev);
 void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		      unsigned int idx);
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
+unsigned int can_get_echo_skb_ni(struct net_device *dev, unsigned int idx);
 void can_free_echo_skb(struct net_device *dev, unsigned int idx);
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
-- 
1.7.9.5

