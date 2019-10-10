From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 18/29] can: rx-offload: can_rx_offload_irq_offload_fifo(): continue on error
Date: Thu, 10 Oct 2019 14:17:39 +0200
Message-ID: <20191010121750.27237-19-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

In case of a resource shortage, i.e. the rx_offload queue will overflow
or a skb fails to be allocated (due to OOM),
can_rx_offload_offload_one() will call mailbox_read() to discard the
mailbox and return an ERR_PTR.

If the hardware FIFO is empty can_rx_offload_offload_one() will return
NULL.

In case a CAN frame was read from the hardware,
can_rx_offload_offload_one() returns the skb containing it.

Without this patch can_rx_offload_irq_offload_fifo() bails out if no skb
returned, regardless of the reason.

Similar to can_rx_offload_irq_offload_timestamp() in case of a resource
shortage the whole FIFO should be discarded, to avoid an IRQ storm and
give the system some time to recover. However if the FIFO is empty the
loop can be left.

With this patch the loop is left in case of empty FIFO, but not on
errors.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rx-offload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 42a1b7d1c753..f6274dbb292c 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -230,7 +230,9 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 
 	while (1) {
 		skb = can_rx_offload_offload_one(offload, 0);
-		if (IS_ERR_OR_NULL(skb))
+		if (IS_ERR(skb))
+			continue;
+		if (!skb)
 			break;
 
 		skb_queue_tail(&offload->skb_queue, skb);
-- 
2.23.0
