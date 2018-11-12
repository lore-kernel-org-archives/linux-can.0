From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 15/20] can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::echo_skb is accessed out of bounds
Date: Mon, 12 Nov 2018 12:57:23 +0100
Message-ID: <20181112115728.18331-16-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

If the "struct can_priv::echo_skb" is accessed out of bounds would lead
to a kernel crash. Better print a sensible warning message instead and
try to recover.

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 46cc5fec4043..c05e4d50d43d 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -481,7 +481,11 @@ struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	BUG_ON(idx >= priv->echo_skb_max);
+	if (idx >= priv->echo_skb_max) {
+		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
+			   __func__, idx, priv->echo_skb_max);
+		return NULL;
+	}
 
 	if (priv->echo_skb[idx]) {
 		/* Using "struct canfd_frame::len" for the frame
-- 
2.19.1
