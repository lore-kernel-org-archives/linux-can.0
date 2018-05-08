From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/7] can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()
Date: Tue,  8 May 2018 11:28:28 +0200
Message-ID: <20180508092831.28247-5-mkl@pengutronix.de>
References: <20180508092831.28247-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180508092831.28247-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Increase rx_dropped, if alloc_can_skb() fails, not tx_dropped.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 63587b8e6825..daed57d3d209 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1179,7 +1179,7 @@ static void kvaser_usb_rx_can_msg(const struct kvaser_usb *dev,
 
 	skb = alloc_can_skb(priv->netdev, &cf);
 	if (!skb) {
-		stats->tx_dropped++;
+		stats->rx_dropped++;
 		return;
 	}
 
-- 
2.17.0
