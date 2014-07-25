From: Matthias Klein <matthias.klein@optimeas.de>
Subject: [PATCH 4/5] net: can: flexcan: wait for completion when entering freeze mode
Date: Fri, 25 Jul 2014 20:16:41 +0200
Message-ID: <1406312202-2542-4-git-send-email-matthias.klein@optimeas.de>
References: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from obi-wan.optimeas.de ([82.165.198.204]:60852 "EHLO
	obi-wan.optimeas.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758030AbaGYSYG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 14:24:06 -0400
In-Reply-To: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

After requesting Freeze Mode, the user must wait for the FRZ_ACK
bit to be asserted in MCR before executing any other action,
otherwise FLEXCAN may operate in an unpredictable way.

Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
---
 drivers/net/can/flexcan.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f6f95ae..0fbc571 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -441,6 +441,24 @@ static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
 	return 1;
 }
 
+static int flexcan_wait_for_frz(struct net_device *dev,
+				struct flexcan_regs __iomem *regs, int en)
+{
+	u32 reg_mcr;
+	u32 loops = 100;
+
+	do {
+		reg_mcr = flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK;
+		if ((en && reg_mcr) || (!en && !reg_mcr))
+			return 0;
+		loops--;
+		udelay(1);
+	} while (loops);
+
+	netdev_err(dev, "Freeze Timeout\n");
+	return -ETIMEDOUT;
+}
+
 static void do_state(struct net_device *dev,
 		     struct can_frame *cf, enum can_state new_state)
 {
@@ -801,6 +819,7 @@ static int flexcan_chip_start(struct net_device *dev)
 		FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
+	flexcan_wait_for_frz(dev, regs, 1);
 
 	/*
 	 * CTRL
@@ -852,6 +871,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	reg_mcr = flexcan_read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_HALT;
 	flexcan_write(reg_mcr, &regs->mcr);
+	flexcan_wait_for_frz(dev, regs, 0);
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
@@ -885,6 +905,7 @@ static void flexcan_chip_stop(struct net_device *dev)
 	reg = flexcan_read(&regs->mcr);
 	reg |= FLEXCAN_MCR_MDIS | FLEXCAN_MCR_HALT;
 	flexcan_write(reg, &regs->mcr);
+	flexcan_wait_for_frz(dev, regs, 1);
 
 	/* Disable all interrupts */
 	flexcan_write(0, &regs->imask1);
@@ -1018,6 +1039,7 @@ static int register_flexcandev(struct net_device *dev)
 	reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
 	flexcan_write(reg, &regs->mcr);
+	flexcan_wait_for_frz(dev, regs, 1);
 
 	/*
 	 * Currently we only support newer versions of this core
-- 
2.0.1

