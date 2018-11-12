From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 13/20] can: dev: can_get_echo_skb(): factor out non sending code to __can_get_echo_skb()
Date: Mon, 12 Nov 2018 12:57:21 +0100
Message-ID: <20181112115728.18331-14-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This patch factors out all non sending parts of can_get_echo_skb() into
a seperate function __can_get_echo_skb(), so that it can be re-used in
an upcoming patch.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c   | 36 +++++++++++++++++++++++++-----------
 include/linux/can/dev.h |  1 +
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 49163570a63a..80530ab37b1e 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -477,14 +477,7 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(can_put_echo_skb);
 
-/*
- * Get the skb from the stack and loop it back locally
- *
- * The function is typically called when the TX done interrupt
- * is handled in the device driver. The driver must protect
- * access to priv->echo_skb, if necessary.
- */
-unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
+struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
@@ -495,13 +488,34 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
 		struct can_frame *cf = (struct can_frame *)skb->data;
 		u8 dlc = cf->can_dlc;
 
-		netif_rx(priv->echo_skb[idx]);
+		*len_ptr = dlc;
 		priv->echo_skb[idx] = NULL;
 
-		return dlc;
+		return skb;
 	}
 
-	return 0;
+	return NULL;
+}
+
+/*
+ * Get the skb from the stack and loop it back locally
+ *
+ * The function is typically called when the TX done interrupt
+ * is handled in the device driver. The driver must protect
+ * access to priv->echo_skb, if necessary.
+ */
+unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
+{
+	struct sk_buff *skb;
+	u8 len;
+
+	skb = __can_get_echo_skb(dev, idx, &len);
+	if (!skb)
+		return 0;
+
+	netif_rx(skb);
+
+	return len;
 }
 EXPORT_SYMBOL_GPL(can_get_echo_skb);
 
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index a83e1f632eb7..f01623aef2f7 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -169,6 +169,7 @@ void can_change_state(struct net_device *dev, struct can_frame *cf,
 
 void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		      unsigned int idx);
+struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr);
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
 void can_free_echo_skb(struct net_device *dev, unsigned int idx);
 
-- 
2.19.1
