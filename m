From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 2/3] can: c_can: fix an interrupt thrash issue with c_can driver
Date: Fri, 20 Apr 2012 15:28:06 +0530
Message-ID: <1334915886-30076-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49590 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab2DTJ6U (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 20 Apr 2012 05:58:20 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch fixes an interrupt thrash issue with c_can driver.

In c_can_isr() function interrupts are disabled and enabled only in
c_can_poll() function. c_can_isr() & c_can_poll() both read the
irqstatus flag. However, irqstatus is always read as 0 in c_can_poll()
because all C_CAN interrupts are disabled in c_can_isr(). This causes
all interrupts to be re-enabled in c_can_poll() which in turn causes
another interrupt since the event is not really handled. This keeps
happening causing a flood of interrupts.

To fix this, read the irqstatus register in isr and use the same cached
value in the poll function.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.c |   19 ++++++++-----------
 drivers/net/can/c_can/c_can.h |    1 +
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 9ac28df..09fcc50 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -946,18 +946,16 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 static int c_can_poll(struct napi_struct *napi, int quota)
 {
-	u16 irqstatus;
 	int lec_type = 0;
 	int work_done = 0;
 	struct net_device *dev = napi->dev;
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	irqstatus = priv->read_reg(priv, &priv->regs->interrupt);
-	if (!irqstatus)
+	if (!priv->irqstatus)
 		goto end;
 
 	/* status events have the highest priority */
-	if (irqstatus == STATUS_INTERRUPT) {
+	if (priv->irqstatus == STATUS_INTERRUPT) {
 		priv->current_status = priv->read_reg(priv,
 					&priv->regs->status);
 
@@ -1008,12 +1006,12 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 		lec_type = c_can_has_and_handle_berr(priv);
 		if (lec_type)
 			work_done += c_can_handle_bus_err(dev, lec_type);
-	} else if ((irqstatus >= C_CAN_MSG_OBJ_RX_FIRST) &&
-			(irqstatus <= C_CAN_MSG_OBJ_RX_LAST)) {
+	} else if ((priv->irqstatus >= C_CAN_MSG_OBJ_RX_FIRST) &&
+			(priv->irqstatus <= C_CAN_MSG_OBJ_RX_LAST)) {
 		/* handle events corresponding to receive message objects */
 		work_done += c_can_do_rx_poll(dev, (quota - work_done));
-	} else if ((irqstatus >= C_CAN_MSG_OBJ_TX_FIRST) &&
-			(irqstatus <= C_CAN_MSG_OBJ_TX_LAST)) {
+	} else if ((priv->irqstatus >= C_CAN_MSG_OBJ_TX_FIRST) &&
+			(priv->irqstatus <= C_CAN_MSG_OBJ_TX_LAST)) {
 		/* handle events corresponding to transmit message objects */
 		c_can_do_tx(dev);
 	}
@@ -1030,12 +1028,11 @@ end:
 
 static irqreturn_t c_can_isr(int irq, void *dev_id)
 {
-	u16 irqstatus;
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	irqstatus = priv->read_reg(priv, &priv->regs->interrupt);
-	if (!irqstatus)
+	priv->irqstatus = priv->read_reg(priv, &priv->regs->interrupt);
+	if (!priv->irqstatus)
 		return IRQ_NONE;
 
 	/* disable all interrupts and schedule the NAPI */
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 9b7fbef..5f32d34 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -76,6 +76,7 @@ struct c_can_priv {
 	unsigned int tx_next;
 	unsigned int tx_echo;
 	void *priv;		/* for board-specific data */
+	u16 irqstatus;
 };
 
 struct net_device *alloc_c_can_dev(void);
-- 
1.7.0.4

