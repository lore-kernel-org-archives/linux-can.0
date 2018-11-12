From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 14/20] can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_frame to access frame length
Date: Mon, 12 Nov 2018 12:57:22 +0100
Message-ID: <20181112115728.18331-15-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This patch replaces the use of "struct can_frame::can_dlc" by "struct
canfd_frame::len" to access the frame's length. As it is ensured that
both structures have a compatible memory layout for this member this is
no functional change. Futher, this compatibility is documented in a
comment.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 80530ab37b1e..46cc5fec4043 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -484,11 +484,14 @@ struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8
 	BUG_ON(idx >= priv->echo_skb_max);
 
 	if (priv->echo_skb[idx]) {
+		/* Using "struct canfd_frame::len" for the frame
+		 * length is supported on both CAN and CANFD frames.
+		 */
 		struct sk_buff *skb = priv->echo_skb[idx];
-		struct can_frame *cf = (struct can_frame *)skb->data;
-		u8 dlc = cf->can_dlc;
+		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+		u8 len = cf->len;
 
-		*len_ptr = dlc;
+		*len_ptr = len;
 		priv->echo_skb[idx] = NULL;
 
 		return skb;
-- 
2.19.1
