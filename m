From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 08/14] can: flexcan: consolidate bus-off handling
Date: Wed,  7 Dec 2011 15:55:22 +0100
Message-ID: <1323269728-17491-9-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49270 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284Ab1LGOzl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:41 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

The netdev queue is restarted not before the CAN error state has
returned to error active.

Here is an example output of "candump -candump -td -e any,0:0,#FFFFFFFF"
for a bus-off recovery due to a short circiut (restart after 5s) for a
Flexcan controller on the i.MX28 SOC:

 (000.200433)  can0    D  [4] B5 97 EB 52
 (000.200401)  can0  2000028C  [8] 00 20 08 00 00 00 91 00   ERRORFRAME
        controller-problem{tx-error-passive}
        protocol-violation{{tx-dominant-bit-error}{}}
        bus-error
        state-change{tx-error-passive}
        error-counter-tx-rx{{145}{0}}
 (000.001000)  can0  200002C8  [8] 00 00 08 00 00 00 0E 00   ERRORFRAME
        protocol-violation{{tx-dominant-bit-error}{}}
        bus-off
        bus-error
        state-change{}
        error-counter-tx-rx{{14}{0}}
 (005.006823)  can0  20000100  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
        restarted-after-bus-off
 (000.001063)  can0  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRAME
        state-change{back-to-error-active}
 (000.006218)  can0   27  [2] 72 F3

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/flexcan.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 73e0597..86b697c 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -376,6 +376,7 @@ static int flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
 		new_state = CAN_STATE_ERROR_PASSIVE;
 	} else {
 		new_state = CAN_STATE_BUS_OFF;
+		netif_stop_queue(dev);
 		can_bus_off(dev);
 	}
 
@@ -675,7 +676,9 @@ static int flexcan_chip_start(struct net_device *dev)
 	reg_mcr &= ~FLEXCAN_MCR_HALT;
 	flexcan_write(reg_mcr, &regs->mcr);
 
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+	/* If from bus-off, wait for state change to error active */
+	if (priv->can.state != CAN_STATE_BUS_OFF)
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* enable FIFO interrupts */
 	flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
@@ -767,6 +770,7 @@ static int flexcan_close(struct net_device *dev)
 
 static int flexcan_set_mode(struct net_device *dev, enum can_mode mode)
 {
+	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
 	switch (mode) {
@@ -775,7 +779,9 @@ static int flexcan_set_mode(struct net_device *dev, enum can_mode mode)
 		if (err)
 			return err;
 
-		netif_wake_queue(dev);
+		/* If from bus-off, wait for state change to error active */
+		if (priv->can.state != CAN_STATE_BUS_OFF)
+			netif_wake_queue(dev);
 
 		break;
 
-- 
1.7.4.1

