From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 15/33] can: rx-offload: can_rx_offload_offload_one(): do not increase the skb_queue beyond skb_queue_len_max
Date: Tue,  5 Nov 2019 17:31:57 +0100
Message-ID: <20191105163215.30194-16-mkl@pengutronix.de>
References: <20191105163215.30194-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191105163215.30194-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

The skb_queue is a linked list, holding the skb to be processed in the
next NAPI call.

Without this patch, the queue length in can_rx_offload_offload_one() is
limited to skb_queue_len_max + 1. As the skb_queue is a linked list, no
array or other resources are accessed out-of-bound, however this
behaviour is counterintuitive.

This patch limits the rx-offload skb_queue length to skb_queue_len_max.

Fixes: d254586c3453 ("can: rx-offload: Add support for HW fifo based irq offloading")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rx-offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index d1c863409945..bdc27481b57f 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -115,7 +115,7 @@ static struct sk_buff *can_rx_offload_offload_one(struct can_rx_offload *offload
 	int ret;
 
 	/* If queue is full or skb not available, read to discard mailbox */
-	if (likely(skb_queue_len(&offload->skb_queue) <=
+	if (likely(skb_queue_len(&offload->skb_queue) <
 		   offload->skb_queue_len_max))
 		skb = alloc_can_skb(offload->dev, &cf);
 
-- 
2.24.0.rc1
