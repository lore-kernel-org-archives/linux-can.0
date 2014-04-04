From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 09/10] can: c_can: Get rid of pointless interrupts
Date: Fri, 04 Apr 2014 15:24:27 -0000
Message-ID: <20140404134857.976174549@linutronix.de>
References: <20140404134816.751883017@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41563 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbaDDPYP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 11:24:15 -0400
Content-Disposition: inline;
 filename=can-c-can-get-rid-of-pointless-interrupts.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

The driver handles pointlessly TWO interrupts per packet. The reason
is that it enables the status interrupt which fires for each rx and tx
packet and it enables the per message object interrupts as well.

The status interrupt merily acks or in case of D_CAN ignores the TX/RX
state and then the message object interrupt fires.

The message objects interrupts are only useful if all message objects
have hardware filters activated.

But we don't have that and its not simple to implement in that driver
without rewriting it completely.

So we can ditch the message object interrupts and handle the RX/TX
right away from the status interrupt. Instead of TWO we handle ONE.

If we ever have the need for HW filtering, then this code needs a
complete overhaul and we can think about it then. For now we prefer a
lower interrupt load.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |  124 +++++++++++++++++-------------------------
 drivers/net/can/c_can/c_can.h |    3 -
 2 files changed, 54 insertions(+), 73 deletions(-)

Index: linux-can/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-can.orig/drivers/net/can/c_can/c_can.c
+++ linux-can/drivers/net/can/c_can/c_can.c
@@ -348,8 +348,7 @@ static void c_can_write_msg_object(struc
 
 	/* enable interrupt for this message object */
 	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface),
-			IF_MCONT_TXIE | IF_MCONT_TXRQST | IF_MCONT_EOB |
-			frame->can_dlc);
+			IF_MCONT_TXRQST | IF_MCONT_EOB | frame->can_dlc);
 	c_can_object_put(dev, iface, objno, IF_COMM_ALL);
 }
 
@@ -592,11 +591,10 @@ static void c_can_configure_msg_objects(
 
 	/* setup receive message objects */
 	for (i = C_CAN_MSG_OBJ_RX_FIRST; i < C_CAN_MSG_OBJ_RX_LAST; i++)
-		c_can_setup_receive_object(dev, IF_RX, i, 0, 0,
-			(IF_MCONT_RXIE | IF_MCONT_UMASK) & ~IF_MCONT_EOB);
+		c_can_setup_receive_object(dev, IF_RX, i, 0, 0, IF_MCONT_UMASK);
 
 	c_can_setup_receive_object(dev, IF_RX, C_CAN_MSG_OBJ_RX_LAST, 0, 0,
-			IF_MCONT_EOB | IF_MCONT_RXIE | IF_MCONT_UMASK);
+				   IF_MCONT_EOB | IF_MCONT_UMASK);
 }
 
 /*
@@ -649,8 +647,9 @@ static int c_can_start(struct net_device
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	/* reset tx helper pointers */
+	/* reset tx helper pointers and the rx mask */
 	priv->tx_next = priv->tx_echo = 0;
+	priv->rxmasked = 0;
 
 	return 0;
 }
@@ -823,9 +822,13 @@ static int c_can_read_objects(struct net
 		/* read the data from the message object */
 		c_can_read_msg_object(dev, IF_RX, ctrl);
 
-		if (obj == C_CAN_MSG_RX_LOW_LAST)
+		if (obj < C_CAN_MSG_RX_LOW_LAST)
+			priv->rxmasked |= BIT(obj - 1);
+		else if (obj == C_CAN_MSG_RX_LOW_LAST) {
+			priv->rxmasked = 0;
 			/* activate all lower message objects */
 			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
+		}
 
 		pkts++;
 		quota--;
@@ -870,7 +873,8 @@ static int c_can_do_rx_poll(struct net_d
 
 	while (quota > 0) {
 		if (!pend) {
-			pend = priv->read_reg(priv, C_CAN_INTPND1_REG);
+			pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
+			pend &= ~priv->rxmasked;
 			if (!pend)
 				break;
 			/*
@@ -1052,76 +1056,55 @@ static int c_can_handle_bus_err(struct n
 
 static int c_can_poll(struct napi_struct *napi, int quota)
 {
-	u16 irqstatus;
-	int work_done = 0;
 	struct net_device *dev = napi->dev;
 	struct c_can_priv *priv = netdev_priv(dev);
+	u16 curr, last = priv->last_status;
+	int work_done = 0;
 
-	irqstatus = priv->irqstatus;
-	if (!irqstatus)
+	curr = priv->read_reg(priv, C_CAN_STS_REG);
+
+	/* handle state changes */
+	if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
+		netdev_dbg(dev, "entered error warning state\n");
+		work_done += c_can_handle_state_change(dev, C_CAN_ERROR_WARNING);
+	}
+
+	if ((curr & STATUS_EPASS) && (!(last & STATUS_EPASS))) {
+		netdev_dbg(dev, "entered error passive state\n");
+		work_done += c_can_handle_state_change(dev, C_CAN_ERROR_PASSIVE);
+	}
+
+	if ((curr & STATUS_BOFF) && (!(last & STATUS_BOFF))) {
+		netdev_dbg(dev, "entered bus off state\n");
+		work_done += c_can_handle_state_change(dev, C_CAN_BUS_OFF);
 		goto end;
+	}
 
-	/* status events have the highest priority */
-	if (irqstatus == STATUS_INTERRUPT) {
-		priv->current_status = priv->read_reg(priv,
-					C_CAN_STS_REG);
-
-		/* handle Tx/Rx events */
-		if (priv->current_status & STATUS_TXOK &&
-		    priv->type != BOSCH_D_CAN)
-			priv->write_reg(priv, C_CAN_STS_REG,
-					priv->current_status & ~STATUS_TXOK);
-
-		if (priv->current_status & STATUS_RXOK &&
-		    priv->type != BOSCH_D_CAN)
-			priv->write_reg(priv, C_CAN_STS_REG,
-					priv->current_status & ~STATUS_RXOK);
-
-		/* handle state changes */
-		if ((priv->current_status & STATUS_EWARN) &&
-				(!(priv->last_status & STATUS_EWARN))) {
-			netdev_dbg(dev, "entered error warning state\n");
-			work_done += c_can_handle_state_change(dev,
-						C_CAN_ERROR_WARNING);
-		}
-		if ((priv->current_status & STATUS_EPASS) &&
-				(!(priv->last_status & STATUS_EPASS))) {
-			netdev_dbg(dev, "entered error passive state\n");
-			work_done += c_can_handle_state_change(dev,
-						C_CAN_ERROR_PASSIVE);
-		}
-		if ((priv->current_status & STATUS_BOFF) &&
-				(!(priv->last_status & STATUS_BOFF))) {
-			netdev_dbg(dev, "entered bus off state\n");
-			work_done += c_can_handle_state_change(dev,
-						C_CAN_BUS_OFF);
-			goto end;
-		}
+	/* handle bus recovery events */
+	if ((!(curr & STATUS_BOFF)) && (last & STATUS_BOFF)) {
+		netdev_dbg(dev, "left bus off state\n");
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
+	}
+	if ((!(curr & STATUS_EPASS)) && (last & STATUS_EPASS)) {
+		netdev_dbg(dev, "left error passive state\n");
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
+	}
 
-		/* handle bus recovery events */
-		if ((!(priv->current_status & STATUS_BOFF)) &&
-				(priv->last_status & STATUS_BOFF)) {
-			netdev_dbg(dev, "left bus off state\n");
-			priv->can.state = CAN_STATE_ERROR_ACTIVE;
-		}
-		if ((!(priv->current_status & STATUS_EPASS)) &&
-				(priv->last_status & STATUS_EPASS)) {
-			netdev_dbg(dev, "left error passive state\n");
-			priv->can.state = CAN_STATE_ERROR_ACTIVE;
-		}
+	priv->last_status = curr;
 
-		priv->last_status = priv->current_status;
+	/* handle lec errors on the bus */
+	work_done += c_can_handle_bus_err(dev, curr & LEC_MASK);
 
-		/* handle lec errors on the bus */
-		work_done += c_can_handle_bus_err(dev,
-					priv->current_status & LEC_MASK);
-	} else if ((irqstatus >= C_CAN_MSG_OBJ_RX_FIRST) &&
-			(irqstatus <= C_CAN_MSG_OBJ_RX_LAST)) {
-		/* handle events corresponding to receive message objects */
+	/* handle Tx/Rx events */
+	if (curr & STATUS_RXOK) {
+		if (priv->type != BOSCH_D_CAN)
+			priv->write_reg(priv, C_CAN_STS_REG, curr & ~STATUS_RXOK);
 		work_done += c_can_do_rx_poll(dev, (quota - work_done));
-	} else if ((irqstatus >= C_CAN_MSG_OBJ_TX_FIRST) &&
-			(irqstatus <= C_CAN_MSG_OBJ_TX_LAST)) {
-		/* handle events corresponding to transmit message objects */
+	}
+
+	if (curr & STATUS_TXOK) {
+		if (priv->type != BOSCH_D_CAN)
+			priv->write_reg(priv, C_CAN_STS_REG, curr & ~STATUS_TXOK);
 		c_can_do_tx(dev);
 	}
 
@@ -1141,8 +1124,7 @@ static irqreturn_t c_can_isr(int irq, vo
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	priv->irqstatus = priv->read_reg(priv, C_CAN_INT_REG);
-	if (!priv->irqstatus)
+	if (!priv->read_reg(priv, C_CAN_INT_REG))
 		return IRQ_NONE;
 
 	/* disable all interrupts and schedule the NAPI */
Index: linux-can/drivers/net/can/c_can/c_can.h
===================================================================
--- linux-can.orig/drivers/net/can/c_can/c_can.h
+++ linux-can/drivers/net/can/c_can/c_can.h
@@ -185,7 +185,6 @@ struct c_can_priv {
 	struct device *device;
 	spinlock_t xmit_lock;
 	int tx_object;
-	int current_status;
 	int last_status;
 	u16 (*read_reg) (struct c_can_priv *priv, enum reg index);
 	void (*write_reg) (struct c_can_priv *priv, enum reg index, u16 val);
@@ -195,11 +194,11 @@ struct c_can_priv {
 	unsigned int tx_next;
 	unsigned int tx_echo;
 	void *priv;		/* for board-specific data */
-	u16 irqstatus;
 	enum c_can_dev_id type;
 	u32 __iomem *raminit_ctrlreg;
 	unsigned int instance;
 	void (*raminit) (const struct c_can_priv *priv, bool enable);
+	u32 rxmasked;
 	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
 };
 


