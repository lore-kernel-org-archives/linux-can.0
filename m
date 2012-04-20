From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 3/3] can: c_can: Add support for Bosch D_CAN controller
Date: Fri, 20 Apr 2012 15:28:22 +0530
Message-ID: <1334915902-30253-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39283 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab2DTJ6e (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Apr 2012 05:58:34 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch adds the support for D_CAN controller driver to the existing
C_CAN driver.

Bosch D_CAN controller is a full-CAN implementation which is compliant
to CAN protocol version 2.0 part A and B. Bosch D_CAN user manual can be
obtained from: http://www.semiconductors.bosch.de/media/en/pdf/
ipmodules_1/can/d_can_users_manual_111.pdf

The following are the design choices made while adding D_CAN to C_CAN
driver:
A new overlay structure is added for d_can controller and care is taken
to make sure its member names match with equavalent c_can structure
members (even if the d_can specification calls them slightly differently).
Note that d_can controller has more registers, so structure members of
d_can are more than those in c_can.

A new set if read/write macros are used to access the registers common
between c_can and d_can. To get the basic d_can functionality working
it is sufficient to access just these registers.

Current D_CAN implementation has following limitations, this is done
to avoid large changes to the C_CAN driver.
1. Message objects are limited to 32, 16 for RX and 16 for TX. C_CAN IP
   supports upto 32 message objects but in case of D_CAN we can configure
   upto 128 message objects.
2. Using two 16bit reads/writes for accessing the 32bit D_CAN registers.
3. These patches have been tested on little endian machine, there might
   be some hidden endian-related issues due to the nature of the accesses
   (32-bit registers accessed as 2 16-bit registers). However, I do not
   have a big-endian D_CAN implementation to confirm.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.c          |  139 ++++++++++++++++----------------
 drivers/net/can/c_can/c_can.h          |   93 +++++++++++++++++++++-
 drivers/net/can/c_can/c_can_platform.c |   47 +++++++++--
 include/linux/can/platform/c_can.h     |   42 ++++++++++
 4 files changed, 245 insertions(+), 76 deletions(-)
 create mode 100644 include/linux/can/platform/c_can.h

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 09fcc50..4abb09d 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -38,6 +38,7 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/can/platform/c_can.h>
 
 #include "c_can.h"
 
@@ -219,24 +220,24 @@ static u32 c_can_read_reg32(struct c_can_priv *priv, void *reg)
 static void c_can_enable_all_interrupts(struct c_can_priv *priv,
 						int enable)
 {
-	unsigned int cntrl_save = priv->read_reg(priv,
-						&priv->regs->control);
+	unsigned int cntrl_save;
 
+	C_CAN_READ(cntrl_save, priv, regs->control);
 	if (enable)
 		cntrl_save |= (CONTROL_SIE | CONTROL_EIE | CONTROL_IE);
 	else
 		cntrl_save &= ~(CONTROL_EIE | CONTROL_IE | CONTROL_SIE);
 
-	priv->write_reg(priv, &priv->regs->control, cntrl_save);
+	C_CAN_WRITE(priv, regs->control, cntrl_save);
 }
 
 static inline int c_can_msg_obj_is_busy(struct c_can_priv *priv, int iface)
 {
 	int count = MIN_TIMEOUT_VALUE;
+	u32 com_req;
 
-	while (count && priv->read_reg(priv,
-				&priv->regs->ifregs[iface].com_req) &
-				IF_COMR_BUSY) {
+	C_CAN_READ(com_req, priv, regs->ifregs[iface].com_req);
+	while (count && com_req & IF_COMR_BUSY) {
 		count--;
 		udelay(1);
 	}
@@ -258,9 +259,9 @@ static inline void c_can_object_get(struct net_device *dev,
 	 * register and message RAM must be complete in 6 CAN-CLK
 	 * period.
 	 */
-	priv->write_reg(priv, &priv->regs->ifregs[iface].com_mask,
+	C_CAN_WRITE(priv, regs->ifregs[iface].com_mask,
 			IFX_WRITE_LOW_16BIT(mask));
-	priv->write_reg(priv, &priv->regs->ifregs[iface].com_req,
+	C_CAN_WRITE(priv, regs->ifregs[iface].com_req,
 			IFX_WRITE_LOW_16BIT(objno));
 
 	if (c_can_msg_obj_is_busy(priv, iface))
@@ -278,9 +279,9 @@ static inline void c_can_object_put(struct net_device *dev,
 	 * register and message RAM must be complete in 6 CAN-CLK
 	 * period.
 	 */
-	priv->write_reg(priv, &priv->regs->ifregs[iface].com_mask,
+	C_CAN_WRITE(priv, regs->ifregs[iface].com_mask,
 			(IF_COMM_WR | IFX_WRITE_LOW_16BIT(mask)));
-	priv->write_reg(priv, &priv->regs->ifregs[iface].com_req,
+	C_CAN_WRITE(priv, regs->ifregs[iface].com_req,
 			IFX_WRITE_LOW_16BIT(objno));
 
 	if (c_can_msg_obj_is_busy(priv, iface))
@@ -306,18 +307,18 @@ static void c_can_write_msg_object(struct net_device *dev,
 
 	flags |= IF_ARB_MSGVAL;
 
-	priv->write_reg(priv, &priv->regs->ifregs[iface].arb1,
+	C_CAN_WRITE(priv, regs->ifregs[iface].arb1,
 				IFX_WRITE_LOW_16BIT(id));
-	priv->write_reg(priv, &priv->regs->ifregs[iface].arb2, flags |
+	C_CAN_WRITE(priv, regs->ifregs[iface].arb2, flags |
 				IFX_WRITE_HIGH_16BIT(id));
 
 	for (i = 0; i < frame->can_dlc; i += 2) {
-		priv->write_reg(priv, &priv->regs->ifregs[iface].data[i / 2],
+		C_CAN_WRITE(priv, regs->ifregs[iface].data[i / 2],
 				frame->data[i] | (frame->data[i + 1] << 8));
 	}
 
 	/* enable interrupt for this message object */
-	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl,
+	C_CAN_WRITE(priv, regs->ifregs[iface].msg_cntrl,
 			IF_MCONT_TXIE | IF_MCONT_TXRQST | IF_MCONT_EOB |
 			frame->can_dlc);
 	c_can_object_put(dev, iface, objno, IF_COMM_ALL);
@@ -329,7 +330,7 @@ static inline void c_can_mark_rx_msg_obj(struct net_device *dev,
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl,
+	C_CAN_WRITE(priv, regs->ifregs[iface].msg_cntrl,
 			ctrl_mask & ~(IF_MCONT_MSGLST | IF_MCONT_INTPND));
 	c_can_object_put(dev, iface, obj, IF_COMM_CONTROL);
 
@@ -343,7 +344,7 @@ static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *dev,
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_MSG_RX_LOW_LAST; i++) {
-		priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl,
+		C_CAN_WRITE(priv, regs->ifregs[iface].msg_cntrl,
 				ctrl_mask & ~(IF_MCONT_MSGLST |
 					IF_MCONT_INTPND | IF_MCONT_NEWDAT));
 		c_can_object_put(dev, iface, i, IF_COMM_CONTROL);
@@ -356,7 +357,7 @@ static inline void c_can_activate_rx_msg_obj(struct net_device *dev,
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl,
+	C_CAN_WRITE(priv, regs->ifregs[iface].msg_cntrl,
 			ctrl_mask & ~(IF_MCONT_MSGLST |
 				IF_MCONT_INTPND | IF_MCONT_NEWDAT));
 	c_can_object_put(dev, iface, obj, IF_COMM_CONTROL);
@@ -374,7 +375,7 @@ static void c_can_handle_lost_msg_obj(struct net_device *dev,
 
 	c_can_object_get(dev, iface, objno, IF_COMM_ALL & ~IF_COMM_TXRQST);
 
-	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl,
+	C_CAN_WRITE(priv, regs->ifregs[iface].msg_cntrl,
 			IF_MCONT_CLR_MSGLST);
 
 	c_can_object_put(dev, 0, objno, IF_COMM_CONTROL);
@@ -410,9 +411,9 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, int ctrl)
 
 	frame->can_dlc = get_can_dlc(ctrl & 0x0F);
 
-	flags =	priv->read_reg(priv, &priv->regs->ifregs[iface].arb2);
-	val = priv->read_reg(priv, &priv->regs->ifregs[iface].arb1) |
-		(flags << 16);
+	C_CAN_READ(flags, priv, regs->ifregs[iface].arb2);
+	C_CAN_READ(val, priv, regs->ifregs[iface].arb1);
+	val |= (flags << 16);
 
 	if (flags & IF_ARB_MSGXTD)
 		frame->can_id = (val & CAN_EFF_MASK) | CAN_EFF_FLAG;
@@ -423,8 +424,8 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, int ctrl)
 		frame->can_id |= CAN_RTR_FLAG;
 	else {
 		for (i = 0; i < frame->can_dlc; i += 2) {
-			data = priv->read_reg(priv,
-				&priv->regs->ifregs[iface].data[i / 2]);
+			C_CAN_READ(data, priv,
+				regs->ifregs[iface].data[i / 2]);
 			frame->data[i] = data;
 			frame->data[i + 1] = data >> 8;
 		}
@@ -443,41 +444,45 @@ static void c_can_setup_receive_object(struct net_device *dev, int iface,
 					unsigned int id, unsigned int mcont)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
+	u32 msgval1;
 
-	priv->write_reg(priv, &priv->regs->ifregs[iface].mask1,
+	C_CAN_WRITE(priv, regs->ifregs[iface].mask1,
 			IFX_WRITE_LOW_16BIT(mask));
-	priv->write_reg(priv, &priv->regs->ifregs[iface].mask2,
+	C_CAN_WRITE(priv, regs->ifregs[iface].mask2,
 			IFX_WRITE_HIGH_16BIT(mask));
 
-	priv->write_reg(priv, &priv->regs->ifregs[iface].arb1,
+	C_CAN_WRITE(priv, regs->ifregs[iface].arb1,
 			IFX_WRITE_LOW_16BIT(id));
-	priv->write_reg(priv, &priv->regs->ifregs[iface].arb2,
+	C_CAN_WRITE(priv, regs->ifregs[iface].arb2,
 			(IF_ARB_MSGVAL | IFX_WRITE_HIGH_16BIT(id)));
 
-	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl, mcont);
+	C_CAN_WRITE(priv, regs->ifregs[iface].msg_cntrl, mcont);
 	c_can_object_put(dev, iface, objno, IF_COMM_ALL & ~IF_COMM_TXRQST);
 
-	netdev_dbg(dev, "obj no:%d, msgval:0x%08x\n", objno,
-			c_can_read_reg32(priv, &priv->regs->msgval1));
+	C_CAN_READ_REG32(msgval1, priv, regs->msgval1);
+	netdev_dbg(dev, "obj no:%d, msgval:0x%08x\n", objno, msgval1);
 }
 
 static void c_can_inval_msg_object(struct net_device *dev, int iface, int objno)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
+	u32 msgval1;
 
-	priv->write_reg(priv, &priv->regs->ifregs[iface].arb1, 0);
-	priv->write_reg(priv, &priv->regs->ifregs[iface].arb2, 0);
-	priv->write_reg(priv, &priv->regs->ifregs[iface].msg_cntrl, 0);
+	C_CAN_WRITE(priv, regs->ifregs[iface].arb1, 0);
+	C_CAN_WRITE(priv, regs->ifregs[iface].arb2, 0);
+	C_CAN_WRITE(priv, regs->ifregs[iface].msg_cntrl, 0);
 
 	c_can_object_put(dev, iface, objno, IF_COMM_ARB | IF_COMM_CONTROL);
+	C_CAN_READ_REG32(msgval1, priv, regs->msgval1);
 
-	netdev_dbg(dev, "obj no:%d, msgval:0x%08x\n", objno,
-			c_can_read_reg32(priv, &priv->regs->msgval1));
+	netdev_dbg(dev, "obj no:%d, msgval:0x%08x\n", objno, msgval1);
 }
 
 static inline int c_can_is_next_tx_obj_busy(struct c_can_priv *priv, int objno)
 {
-	int val = c_can_read_reg32(priv, &priv->regs->txrqst1);
+	int val;
+
+	C_CAN_READ_REG32(val, priv, regs->txrqst1);
 
 	/*
 	 * as transmission request register's bit n-1 corresponds to
@@ -540,12 +545,12 @@ static int c_can_set_bittiming(struct net_device *dev)
 	netdev_info(dev,
 		"setting BTR=%04x BRPE=%04x\n", reg_btr, reg_brpe);
 
-	ctrl_save = priv->read_reg(priv, &priv->regs->control);
-	priv->write_reg(priv, &priv->regs->control,
+	C_CAN_READ(ctrl_save, priv, regs->control);
+	C_CAN_WRITE(priv, regs->control,
 			ctrl_save | CONTROL_CCE | CONTROL_INIT);
-	priv->write_reg(priv, &priv->regs->btr, reg_btr);
-	priv->write_reg(priv, &priv->regs->brp_ext, reg_brpe);
-	priv->write_reg(priv, &priv->regs->control, ctrl_save);
+	C_CAN_WRITE(priv, regs->btr, reg_btr);
+	C_CAN_WRITE(priv, regs->brp_ext, reg_brpe);
+	C_CAN_WRITE(priv, regs->control, ctrl_save);
 
 	return 0;
 }
@@ -587,36 +592,35 @@ static void c_can_chip_config(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	/* enable automatic retransmission */
-	priv->write_reg(priv, &priv->regs->control,
-			CONTROL_ENABLE_AR);
+	C_CAN_WRITE(priv, regs->control, CONTROL_ENABLE_AR);
 
 	if (priv->can.ctrlmode & (CAN_CTRLMODE_LISTENONLY &
 					CAN_CTRLMODE_LOOPBACK)) {
 		/* loopback + silent mode : useful for hot self-test */
-		priv->write_reg(priv, &priv->regs->control, CONTROL_EIE |
+		C_CAN_WRITE(priv, regs->control, CONTROL_EIE |
 				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
-		priv->write_reg(priv, &priv->regs->test,
+		C_CAN_WRITE(priv, regs->test,
 				TEST_LBACK | TEST_SILENT);
 	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
 		/* loopback mode : useful for self-test function */
-		priv->write_reg(priv, &priv->regs->control, CONTROL_EIE |
+		C_CAN_WRITE(priv, regs->control, CONTROL_EIE |
 				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
-		priv->write_reg(priv, &priv->regs->test, TEST_LBACK);
+		C_CAN_WRITE(priv, regs->test, TEST_LBACK);
 	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
 		/* silent mode : bus-monitoring mode */
-		priv->write_reg(priv, &priv->regs->control, CONTROL_EIE |
+		C_CAN_WRITE(priv, regs->control, CONTROL_EIE |
 				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
-		priv->write_reg(priv, &priv->regs->test, TEST_SILENT);
+		C_CAN_WRITE(priv, regs->test, TEST_SILENT);
 	} else
 		/* normal mode*/
-		priv->write_reg(priv, &priv->regs->control,
+		C_CAN_WRITE(priv, regs->control,
 				CONTROL_EIE | CONTROL_SIE | CONTROL_IE);
 
 	/* configure message objects */
 	c_can_configure_msg_objects(dev);
 
 	/* set a `lec` value so that we can check for updates later */
-	priv->write_reg(priv, &priv->regs->status, LEC_UNUSED);
+	C_CAN_WRITE(priv, regs->status, LEC_UNUSED);
 
 	/* set bittiming params */
 	c_can_set_bittiming(dev);
@@ -669,7 +673,7 @@ static int c_can_get_berr_counter(const struct net_device *dev,
 	unsigned int reg_err_counter;
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	reg_err_counter = priv->read_reg(priv, &priv->regs->err_cnt);
+	C_CAN_READ(reg_err_counter, priv, regs->err_cnt);
 	bec->rxerr = (reg_err_counter & ERR_CNT_REC_MASK) >>
 				ERR_CNT_REC_SHIFT;
 	bec->txerr = reg_err_counter & ERR_CNT_TEC_MASK;
@@ -690,20 +694,19 @@ static int c_can_get_berr_counter(const struct net_device *dev,
  */
 static void c_can_do_tx(struct net_device *dev)
 {
-	u32 val;
+	u32 val, msg_cntrl;
 	u32 msg_obj_no;
 	struct c_can_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 
 	for (/* nix */; (priv->tx_next - priv->tx_echo) > 0; priv->tx_echo++) {
 		msg_obj_no = get_tx_echo_msg_obj(priv);
-		val = c_can_read_reg32(priv, &priv->regs->txrqst1);
+		C_CAN_READ_REG32(val, priv, regs->txrqst1);
 		if (!(val & (1 << (msg_obj_no - 1)))) {
 			can_get_echo_skb(dev,
 					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
-			stats->tx_bytes += priv->read_reg(priv,
-					&priv->regs->ifregs[0].msg_cntrl)
-					& IF_MCONT_DLC_MASK;
+			C_CAN_READ(msg_cntrl, priv, regs->ifregs[0].msg_cntrl);
+			stats->tx_bytes += msg_cntrl & IF_MCONT_DLC_MASK;
 			stats->tx_packets++;
 			c_can_inval_msg_object(dev, 0, msg_obj_no);
 		} else {
@@ -744,11 +747,11 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 	u32 num_rx_pkts = 0;
 	unsigned int msg_obj, msg_ctrl_save;
 	struct c_can_priv *priv = netdev_priv(dev);
-	u32 val = c_can_read_reg32(priv, &priv->regs->intpnd1);
+	u32 val;
 
+	C_CAN_READ_REG32(val, priv, regs->intpnd1);
 	for (msg_obj = C_CAN_MSG_OBJ_RX_FIRST;
 			msg_obj <= C_CAN_MSG_OBJ_RX_LAST && quota > 0;
-			val = c_can_read_reg32(priv, &priv->regs->intpnd1),
 			msg_obj++) {
 		/*
 		 * as interrupt pending register's bit n-1 corresponds to
@@ -757,8 +760,8 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 		if (val & (1 << (msg_obj - 1))) {
 			c_can_object_get(dev, 0, msg_obj, IF_COMM_ALL &
 					~IF_COMM_TXRQST);
-			msg_ctrl_save = priv->read_reg(priv,
-					&priv->regs->ifregs[0].msg_cntrl);
+			C_CAN_READ(msg_ctrl_save, priv,
+					regs->ifregs[0].msg_cntrl);
 
 			if (msg_ctrl_save & IF_MCONT_EOB)
 				return num_rx_pkts;
@@ -791,6 +794,7 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 			num_rx_pkts++;
 			quota--;
 		}
+		C_CAN_READ_REG32(val, priv, regs->intpnd1);
 	}
 
 	return num_rx_pkts;
@@ -819,7 +823,7 @@ static int c_can_handle_state_change(struct net_device *dev,
 		return 0;
 
 	c_can_get_berr_counter(dev, &bec);
-	reg_err_counter = priv->read_reg(priv, &priv->regs->err_cnt);
+	C_CAN_READ(reg_err_counter, priv, regs->err_cnt);
 	rx_err_passive = (reg_err_counter & ERR_CNT_RP_MASK) >>
 				ERR_CNT_RP_SHIFT;
 
@@ -935,7 +939,7 @@ static int c_can_handle_bus_err(struct net_device *dev,
 	}
 
 	/* set a `lec` value so that we can check for updates later */
-	priv->write_reg(priv, &priv->regs->status, LEC_UNUSED);
+	C_CAN_WRITE(priv, regs->status, LEC_UNUSED);
 
 	netif_receive_skb(skb);
 	stats->rx_packets++;
@@ -956,16 +960,15 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 
 	/* status events have the highest priority */
 	if (priv->irqstatus == STATUS_INTERRUPT) {
-		priv->current_status = priv->read_reg(priv,
-					&priv->regs->status);
+		C_CAN_READ(priv->current_status, priv, regs->status);
 
 		/* handle Tx/Rx events */
 		if (priv->current_status & STATUS_TXOK)
-			priv->write_reg(priv, &priv->regs->status,
+			C_CAN_WRITE(priv, regs->status,
 					priv->current_status & ~STATUS_TXOK);
 
 		if (priv->current_status & STATUS_RXOK)
-			priv->write_reg(priv, &priv->regs->status,
+			C_CAN_WRITE(priv, regs->status,
 					priv->current_status & ~STATUS_RXOK);
 
 		/* handle state changes */
@@ -1031,7 +1034,7 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	priv->irqstatus = priv->read_reg(priv, &priv->regs->interrupt);
+	C_CAN_READ(priv->irqstatus, priv, regs->interrupt);
 	if (!priv->irqstatus)
 		return IRQ_NONE;
 
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 5f32d34..7084e4c 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -61,6 +61,95 @@ struct c_can_regs {
 	u16 _reserved6[6];
 };
 
+/* c_can IF registers */
+struct d_can_if_regs {
+	u16 com_req;
+	u16 com_mask;
+	u16 mask1;
+	u16 mask2;
+	u16 arb1;
+	u16 arb2;
+	u16 msg_cntrl;
+	u16 msg_cntrl1;
+	u16 data[4];
+};
+
+/* d_can hardware registers */
+struct d_can_regs {
+	u16 control;
+	u16 control1;
+	u16 status;
+	u16 status1;
+	u16 err_cnt;
+	u16 err_cnt1;
+	u16 btr;
+	u16 brp_ext;
+	u16 interrupt;
+	u16 interrupt1;
+	u16 test;
+	u16 test1;
+	u32 _reserved1;
+	u16 parity_err;
+	u16 parity_err1;
+	u32 _reserved2[24];
+	u16 auto_bus_on;
+	u16 auto_bus_on1;
+	u16 txrq_x;
+	u16 txrq_x1;
+	u16 txrqst1;
+	u16 txrqst2;
+	u32 txrq[3];
+	u16 new_dat_x;
+	u16 new_dat_x1;
+	u16 newdat1;
+	u16 newdat2;
+	u32 new_dat[3];
+	u16 intpnd_x;
+	u16 intpnd_x1;
+	u16 intpnd1;
+	u16 intpnd2;
+	u32 intpnd[3];
+	u16 msg_val_x;
+	u16 msg_val_x1;
+	u16 msgval1;
+	u16 msgval2;
+	u32 msg_val[3];
+	u32 _reserved3;
+	u32 intmux[4];
+	u32 _reserved4[6];
+	struct d_can_if_regs ifregs[3];
+	u32 _reserved5[2];
+	u32 if3_update[4];
+	u16 tioc;
+	u16 tioc1;
+	u16 rioc;
+	u16 rioc1;
+};
+
+#define C_CAN_READ_REG32(ret, priv, reg)				\
+	do {								\
+		if (priv->dev_type == DEV_TYPE_D_CAN)			\
+			ret = c_can_read_reg32(priv, &priv->d##reg);	\
+		else							\
+			ret = c_can_read_reg32(priv, &priv->c##reg);	\
+	} while (0)							\
+
+#define C_CAN_READ(ret, priv, reg)					\
+	do {								\
+		if (priv->dev_type == DEV_TYPE_D_CAN)			\
+			ret = priv->read_reg(priv, &priv->d##reg);	\
+		else							\
+			ret = priv->read_reg(priv, &priv->c##reg);	\
+	} while (0)							\
+
+#define C_CAN_WRITE(priv, reg, val)					\
+	do {								\
+		if (priv->dev_type == DEV_TYPE_D_CAN)			\
+			priv->write_reg(priv, &priv->d##reg, val);	\
+		else							\
+			priv->write_reg(priv, &priv->c##reg, val);	\
+	} while (0)							\
+
 /* c_can private data structure */
 struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
@@ -71,12 +160,14 @@ struct c_can_priv {
 	int last_status;
 	u16 (*read_reg) (struct c_can_priv *priv, void *reg);
 	void (*write_reg) (struct c_can_priv *priv, void *reg, u16 val);
-	struct c_can_regs __iomem *regs;
+	struct d_can_regs __iomem *dregs;
+	struct c_can_regs __iomem *cregs;
 	unsigned long irq_flags; /* for request_irq() */
 	unsigned int tx_next;
 	unsigned int tx_echo;
 	void *priv;		/* for board-specific data */
 	u16 irqstatus;
+	unsigned int dev_type;
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 5e1a5ff..56de2dc 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -32,6 +32,7 @@
 #include <linux/clk.h>
 
 #include <linux/can/dev.h>
+#include <linux/can/platform/c_can.h>
 
 #include "c_can.h"
 
@@ -56,13 +57,25 @@ static void c_can_plat_write_reg_aligned_to_16bit(struct c_can_priv *priv,
 static u16 c_can_plat_read_reg_aligned_to_32bit(struct c_can_priv *priv,
 						void *reg)
 {
-	return readw(reg + (long)reg - (long)priv->regs);
+	return readw(reg + (long)reg - (long)priv->cregs);
 }
 
 static void c_can_plat_write_reg_aligned_to_32bit(struct c_can_priv *priv,
 						void *reg, u16 val)
 {
-	writew(val, reg + (long)reg - (long)priv->regs);
+	writew(val, reg + (long)reg - (long)priv->cregs);
+}
+
+static u16 d_can_plat_read_reg_aligned_to_32bit(struct c_can_priv *priv,
+						void *reg)
+{
+	return readw(reg + (long)reg - (long)priv->dregs);
+}
+
+static void d_can_plat_write_reg_aligned_to_32bit(struct c_can_priv *priv,
+						void *reg, u16 val)
+{
+	writew(val, reg + (long)reg - (long)priv->dregs);
 }
 
 static int __devinit c_can_plat_probe(struct platform_device *pdev)
@@ -71,6 +84,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	struct net_device *dev;
 	struct c_can_priv *priv;
+	struct c_can_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *mem;
 	int irq;
 #ifdef CONFIG_HAVE_CLK
@@ -115,9 +129,19 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	}
 
 	priv = netdev_priv(dev);
+	if (pdata) {
+		if (pdata->dev_type == DEV_TYPE_D_CAN) {
+			priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
+			priv->dev_type = DEV_TYPE_D_CAN;
+			priv->dregs = (struct d_can_regs __iomem *)addr;
+		} else {
+			priv->cregs = (struct c_can_regs __iomem *)addr;
+			priv->dev_type = DEV_TYPE_C_CAN;
+		}
+	}
 
 	dev->irq = irq;
-	priv->regs = addr;
+
 #ifdef CONFIG_HAVE_CLK
 	priv->can.clock.freq = clk_get_rate(clk);
 	priv->priv = clk;
@@ -125,8 +149,13 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 
 	switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
 	case IORESOURCE_MEM_32BIT:
-		priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
-		priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
+		if (pdata->dev_type == DEV_TYPE_D_CAN) {
+			priv->read_reg = d_can_plat_read_reg_aligned_to_32bit;
+			priv->write_reg = d_can_plat_write_reg_aligned_to_32bit;
+		} else {
+			priv->read_reg = c_can_plat_read_reg_aligned_to_32bit;
+			priv->write_reg = c_can_plat_write_reg_aligned_to_32bit;
+		}
 		break;
 	case IORESOURCE_MEM_16BIT:
 	default:
@@ -146,7 +175,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
-		 KBUILD_MODNAME, priv->regs, dev->irq);
+		 KBUILD_MODNAME, addr, dev->irq);
 	return 0;
 
 exit_free_device:
@@ -176,7 +205,11 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 
 	free_c_can_dev(dev);
-	iounmap(priv->regs);
+
+	if (priv->dev_type == DEV_TYPE_D_CAN)
+		iounmap(priv->dregs);
+	else
+		iounmap(priv->cregs);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
diff --git a/include/linux/can/platform/c_can.h b/include/linux/can/platform/c_can.h
new file mode 100644
index 0000000..e95201a
--- /dev/null
+++ b/include/linux/can/platform/c_can.h
@@ -0,0 +1,42 @@
+/*
+ * C_CAN controller driver platform header
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Bosch C_CAN/D_CAN controller is compliant to CAN protocol version 2.0
+ * part A and B.
+ * Bosch C_CAN user manual can be obtained from:
+ * http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/c_can/
+ * users_manual_c_can.pdf
+ * Bosch D_CAN user manual can be obtained from:
+ * http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/can/
+ * d_can_users_manual_111.pdf
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __CAN_PLATFORM_TI_C_CAN_H__
+#define __CAN_PLATFORM_TI_C_CAN_H__
+
+#define DEV_TYPE_C_CAN		0
+#define DEV_TYPE_D_CAN		1
+
+/**
+ * struct c_can_platform_data - CCAN Platform Data
+ *
+ * @dev_type:		Device type C_CAN/D_CAN
+ *
+ * Platform data structure to get all platform specific settings.
+ */
+
+struct c_can_platform_data {
+	unsigned int dev_type;
+};
+#endif
-- 
1.7.0.4

