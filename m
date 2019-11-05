From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 21/33] can: ti_hecc: ti_hecc_error(): increase error counters if skb enqueueing via can_rx_offload_queue_sorted() fails
Date: Tue,  5 Nov 2019 17:32:03 +0100
Message-ID: <20191105163215.30194-22-mkl@pengutronix.de>
References: <20191105163215.30194-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191105163215.30194-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

The call to can_rx_offload_queue_sorted() may fail and return an error
(in the current implementation due to resource shortage). The passed skb
is consumed.

This patch adds incrementing of the appropriate error counters to let
the device statistics reflect that there's a problem.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index f8b19eef5d26..91188e6d4f78 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -558,6 +558,7 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	u32 timestamp;
+	int err;
 
 	/* propagate the error condition to the can stack */
 	skb = alloc_can_err_skb(ndev, &cf);
@@ -639,7 +640,9 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
 	}
 
 	timestamp = hecc_read(priv, HECC_CANLNT);
-	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	if (err)
+		ndev->stats.rx_fifo_errors++;
 
 	return 0;
 }
-- 
2.24.0.rc1
