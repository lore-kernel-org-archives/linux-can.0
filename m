From: Matthias Klein <matthias.klein@optimeas.de>
Subject: [PATCH 5/5] net: can: flexcan: fix for wrong TX error count behaviour on i.MX53
Date: Fri, 25 Jul 2014 20:16:42 +0200
Message-ID: <1406312202-2542-5-git-send-email-matthias.klein@optimeas.de>
References: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from obi-wan.optimeas.de ([82.165.198.204]:60848 "EHLO
	obi-wan.optimeas.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176AbaGYSYF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 14:24:05 -0400
In-Reply-To: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

Once the CAN-bus is open and a packet is sent, the controller switches
into the PASSIVE state and the TX error count goes to 0x80. When the
bus is closed and the packet gets acknowledged the controller switches
to ERROR-WARNING state and the TX error counter is decremented to 0x7f.
Everything OK so far.

When now the bus is open again and a packet is sent, the controller
switches into PASSIVE state and sets the TX error count to 0x86.
When now the bus is closed the TX error is decremented to 0x85, but
the state does not change to ERROR-WARNING. Now with each successfully
transfered packet (in PASSIVE state!) the TX error counter is
decremented, and when the TX error counter reaches 0x7f the controller
switched back into ERROR-WARNING state.

This fix sets the TX error count back to zero when entering the
ERROR-WARNING state (after the first retransfered packet is acknowledged).

Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
---
 drivers/net/can/flexcan.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0fbc571..a74524d 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -464,6 +464,8 @@ static void do_state(struct net_device *dev,
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct can_berr_counter bec;
+	struct flexcan_regs __iomem *regs = priv->base;
+	u32 reg_mcr;
 
 	flexcan_get_berr_counter(dev, &bec);
 
@@ -517,6 +519,21 @@ static void do_state(struct net_device *dev,
 		cf->data[1] = (bec.txerr > bec.rxerr) ?
 			CAN_ERR_CRTL_TX_WARNING :
 			CAN_ERR_CRTL_RX_WARNING;
+
+		reg_mcr = flexcan_read(&regs->mcr);
+		reg_mcr |= FLEXCAN_MCR_HALT;
+		flexcan_write(reg_mcr, &regs->mcr);
+
+		flexcan_wait_for_frz(dev, regs, 1);
+
+		flexcan_write(0, &regs->ecr);
+
+		reg_mcr &= ~FLEXCAN_MCR_HALT;
+		flexcan_write(reg_mcr, &regs->mcr);
+		flexcan_wait_for_frz(dev, regs, 0);
+
+		netdev_dbg(dev, "txerr: %x\n",
+			flexcan_read(&regs->ecr));
 		break;
 	case CAN_STATE_ERROR_ACTIVE:
 		netdev_dbg(dev, "Error Active\n");
-- 
2.0.1

