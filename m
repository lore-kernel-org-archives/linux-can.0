From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: mp251x: fix mcp2515 stops receiving problem
Date: Mon, 12 May 2014 19:06:00 +0200
Message-ID: <1399914360-7146-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59397 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921AbaELRGF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 13:06:05 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, "Rost, Martin" <Martin.Rost@tonfunk.de>, Alexander Shiyan <shc_work@mail.ru>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "Rost, Martin" <Martin.Rost@tonfunk.de>

The mcp2515 sometimes seems to trigger an interrupt with the corresponding
register not being set yet. This makes the driver exit the interrupt because
there is obviously nothing to do, but the interrupt line is kept low.
Therefore the driver does not see any more interrupts until the chip is reset
(via interface down/up).

This patch changes the IST to first check the IRQ registers, and wait up to 10
ms if an event really occurrs. If the IRQ register is still empty after 10ms,
a kernel message gets issued. The IST loop is rearranged to evaluate the IRQ
register at the last moment before exiting, to not miss a late irq event.

Not-Signed-off-by: Martin Rost <Martin.Rost@tonfunk.de>
Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 5df239e..9b7f3cb 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -804,16 +804,25 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 	struct mcp251x_priv *priv = dev_id;
 	struct spi_device *spi = priv->spi;
 	struct net_device *net = priv->net;
+	int retry = 10;
+	u8 intf, eflag;
 
 	mutex_lock(&priv->mcp_lock);
-	while (!priv->force_quit) {
+
+	do {
+		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
+		if (!intf)
+			mdelay(1);
+	} while (!intf && (retry--));
+
+	if (!intf)
+		dev_err(&spi->dev, "IRQ without a cause.\n");
+
+	while ((!priv->force_quit) && intf) {
 		enum can_state new_state;
-		u8 intf, eflag;
 		u8 clear_intf = 0;
 		int can_id = 0, data1 = 0;
 
-		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
-
 		/* mask out flags we don't care about */
 		intf &= CANINTF_RX | CANINTF_TX | CANINTF_ERR;
 
@@ -911,9 +920,6 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 			}
 		}
 
-		if (intf == 0)
-			break;
-
 		if (intf & CANINTF_TX) {
 			net->stats.tx_packets++;
 			net->stats.tx_bytes += priv->tx_len - 1;
@@ -925,6 +931,7 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 			netif_wake_queue(net);
 		}
 
+		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
 	}
 	mutex_unlock(&priv->mcp_lock);
 	return IRQ_HANDLED;
-- 
2.0.0.rc0

