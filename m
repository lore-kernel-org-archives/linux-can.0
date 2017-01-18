From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 05/16] can: flexcan: do_bus_err(): convert rx_,tx_errors into bool
Date: Wed, 18 Jan 2017 15:52:16 +0100
Message-ID: <20170118145227.24916-6-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50751 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753148AbdARPEH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:04:07 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch converts the rx_errors and tx_errors from int into bool
values, to reflect their actual meaning.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 409f924e46ea..bd780bbf4f1a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -517,41 +517,41 @@ static void do_bus_err(struct net_device *dev,
 		       struct can_frame *cf, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
-	int rx_errors = 0, tx_errors = 0;
+	bool rx_errors = false, tx_errors = false;
 
 	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 	if (reg_esr & FLEXCAN_ESR_BIT1_ERR) {
 		netdev_dbg(dev, "BIT1_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT1;
-		tx_errors = 1;
+		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_BIT0_ERR) {
 		netdev_dbg(dev, "BIT0_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT0;
-		tx_errors = 1;
+		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_ACK_ERR) {
 		netdev_dbg(dev, "ACK_ERR irq\n");
 		cf->can_id |= CAN_ERR_ACK;
 		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
-		tx_errors = 1;
+		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_CRC_ERR) {
 		netdev_dbg(dev, "CRC_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT;
 		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
-		rx_errors = 1;
+		rx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_FRM_ERR) {
 		netdev_dbg(dev, "FRM_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_FORM;
-		rx_errors = 1;
+		rx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_STF_ERR) {
 		netdev_dbg(dev, "STF_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_STUFF;
-		rx_errors = 1;
+		rx_errors = true;
 	}
 
 	priv->can.can_stats.bus_error++;
-- 
2.11.0

