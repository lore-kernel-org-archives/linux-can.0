From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 09/21] can: c_can: Avoid status register update for D_CAN
Date: Fri, 11 Apr 2014 08:13:15 -0000
Message-ID: <20140411080651.967605443@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52400 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbaDKINC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:13:02 -0400
Content-Disposition: inline;
 filename=can-c_can-avoid-status-update-for-dcan.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

On D_CAN the RXOK, TXOK and LEC bits are cleared/set on read of the
status register. No need to update them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
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
 


