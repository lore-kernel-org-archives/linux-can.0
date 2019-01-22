From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/4] can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb by removing it
Date: Tue, 22 Jan 2019 14:21:13 +0100
Message-ID: <20190122132116.7074-2-mkl@pengutronix.de>
References: <20190122132116.7074-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190122132116.7074-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

This patch revert commit 7da11ba5c506
("can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb")

After introduction of this change we encountered following new error
message on various i.MX plattforms (flexcan):

| flexcan 53fc8000.can can0: __can_get_echo_skb: BUG! Trying to echo non
| existing skb: can_priv::echo_skb[0]

The introduction of the message was a mistake because
priv->echo_skb[idx] = NULL is a perfectly valid in following case: If
CAN_RAW_LOOPBACK is disabled (setsockopt) in applications, the pkt_type
of the tx skb's given to can_put_echo_skb is set to PACKET_LOOPBACK. In
this case can_put_echo_skb will not set priv->echo_skb[idx]. It is
therefore kept NULL.

As additional argument for revert: The order of check and usage of idx
was changed. idx is used to access an array element before checking it's
boundaries.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Fixes: 7da11ba5c506 ("can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 3b3f88ffab53..c05e4d50d43d 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -480,8 +480,6 @@ EXPORT_SYMBOL_GPL(can_put_echo_skb);
 struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	struct sk_buff *skb = priv->echo_skb[idx];
-	struct canfd_frame *cf;
 
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
@@ -489,20 +487,21 @@ struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8
 		return NULL;
 	}
 
-	if (!skb) {
-		netdev_err(dev, "%s: BUG! Trying to echo non existing skb: can_priv::echo_skb[%u]\n",
-			   __func__, idx);
-		return NULL;
-	}
+	if (priv->echo_skb[idx]) {
+		/* Using "struct canfd_frame::len" for the frame
+		 * length is supported on both CAN and CANFD frames.
+		 */
+		struct sk_buff *skb = priv->echo_skb[idx];
+		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+		u8 len = cf->len;
 
-	/* Using "struct canfd_frame::len" for the frame
-	 * length is supported on both CAN and CANFD frames.
-	 */
-	cf = (struct canfd_frame *)skb->data;
-	*len_ptr = cf->len;
-	priv->echo_skb[idx] = NULL;
+		*len_ptr = len;
+		priv->echo_skb[idx] = NULL;
 
-	return skb;
+		return skb;
+	}
+
+	return NULL;
 }
 
 /*
-- 
2.20.1
