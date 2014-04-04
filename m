From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 08/10] can: c_can: Avoid status register update for D_CAN
Date: Fri, 04 Apr 2014 15:24:27 -0000
Message-ID: <20140404134857.752157476@linutronix.de>
References: <20140404134816.751883017@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41556 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbaDDPYP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 11:24:15 -0400
Content-Disposition: inline;
 filename=can-c_can-avoid-status-update-for-dcan.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

On D_CAN the RXOK, TXOK and LEC bits are cleared/set on read of the
status register. No need to update them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-can/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-can.orig/drivers/net/can/c_can/c_can.c
+++ linux-can/drivers/net/can/c_can/c_can.c
@@ -1041,7 +1041,8 @@ static int c_can_handle_bus_err(struct n
 	}
 
 	/* set a `lec` value so that we can check for updates later */
-	priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+	if (priv->type != BOSCH_D_CAN)
+		priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
@@ -1066,11 +1067,13 @@ static int c_can_poll(struct napi_struct
 					C_CAN_STS_REG);
 
 		/* handle Tx/Rx events */
-		if (priv->current_status & STATUS_TXOK)
+		if (priv->current_status & STATUS_TXOK &&
+		    priv->type != BOSCH_D_CAN)
 			priv->write_reg(priv, C_CAN_STS_REG,
 					priv->current_status & ~STATUS_TXOK);
 
-		if (priv->current_status & STATUS_RXOK)
+		if (priv->current_status & STATUS_RXOK &&
+		    priv->type != BOSCH_D_CAN)
 			priv->write_reg(priv, C_CAN_STS_REG,
 					priv->current_status & ~STATUS_RXOK);
 


