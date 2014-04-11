From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 07/21] can: c_can: Always update error stats
Date: Fri, 11 Apr 2014 08:13:13 -0000
Message-ID: <20140411080651.544767510@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52387 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315AbaDKINB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:13:01 -0400
Content-Disposition: inline; filename=can-c_can-always-update-error-stats.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

If the allocation of the error skb fails, we still want to see the
error statistics.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -378,6 +378,9 @@ static int c_can_handle_lost_msg_obj(str
 	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
 	c_can_object_put(dev, iface, objno, IF_COMM_CONTROL);
 
+	stats->rx_errors++;
+	stats->rx_over_errors++;
+
 	/* create an error msg */
 	skb = alloc_can_err_skb(dev, &frame);
 	if (unlikely(!skb))
@@ -385,8 +388,6 @@ static int c_can_handle_lost_msg_obj(str
 
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
-	stats->rx_errors++;
-	stats->rx_over_errors++;
 
 	netif_receive_skb(skb);
 	return 1;
@@ -996,6 +997,10 @@ static int c_can_handle_bus_err(struct n
 	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 		return 0;
 
+	/* common for all type of bus errors */
+	priv->can.can_stats.bus_error++;
+	stats->rx_errors++;
+
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
 	if (unlikely(!skb))
@@ -1005,10 +1010,6 @@ static int c_can_handle_bus_err(struct n
 	 * check for 'last error code' which tells us the
 	 * type of the last error to occur on the CAN bus
 	 */
-
-	/* common for all type of bus errors */
-	priv->can.can_stats.bus_error++;
-	stats->rx_errors++;
 	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 	cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 


