From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 07/16] can: flexcan: flexcan_poll_bus_err(): fold in do_bus_err()
Date: Wed, 18 Jan 2017 15:52:18 +0100
Message-ID: <20170118145227.24916-8-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55649 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752466AbdARPEW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:04:22 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch folds in the do_bus_err() function into
flexcan_poll_bus_err().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 62180b486272..746be60173d7 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -513,12 +513,17 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void do_bus_err(struct net_device *dev,
-		       struct can_frame *cf, u32 reg_esr)
+static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
+	struct sk_buff *skb;
+	struct can_frame *cf;
 	bool rx_errors = false, tx_errors = false;
 
+	skb = alloc_can_err_skb(dev, &cf);
+	if (unlikely(!skb))
+		return 0;
+
 	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 	if (reg_esr & FLEXCAN_ESR_BIT1_ERR) {
@@ -559,18 +564,6 @@ static void do_bus_err(struct net_device *dev,
 		dev->stats.rx_errors++;
 	if (tx_errors)
 		dev->stats.tx_errors++;
-}
-
-static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
-{
-	struct sk_buff *skb;
-	struct can_frame *cf;
-
-	skb = alloc_can_err_skb(dev, &cf);
-	if (unlikely(!skb))
-		return 0;
-
-	do_bus_err(dev, cf, reg_esr);
 
 	dev->stats.rx_packets++;
 	dev->stats.rx_bytes += cf->can_dlc;
-- 
2.11.0

