From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 03/14] can: flexcan: only for bus error reporting enable berr interrupt
Date: Wed,  7 Dec 2011 15:55:17 +0100
Message-ID: <1323269728-17491-4-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49257 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284Ab1LGOzj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:39 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>, Reuben Dowle <Reuben.Dowle@navico.com>

So far, the bus error (berr) interrupt source is always enabled,
even if bus error reporting is not requested (via ctrlmode flag
CAN_CTRLMODE_BERR_REPORTING). This is not necessay, at least on
the Flexcan of the i.MX28 SOC and it avoids flooding with with
bus error interrupts. State changes interrupts do still arrive
as documented. The function flexcan_has_and_handle_berr() has
been removed and error state changes and bus errors are now
packed into one error message by a common poll function, like
for other CAN controllers.

CC: Reuben Dowle <Reuben.Dowle@navico.com>
Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/flexcan.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0ce914a..095b74b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -705,7 +705,10 @@ static int flexcan_chip_start(struct net_device *dev)
 	reg_ctrl = flexcan_read(&regs->ctrl);
 	reg_ctrl &= ~FLEXCAN_CTRL_TSYN;
 	reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
-		FLEXCAN_CTRL_ERR_STATE | FLEXCAN_CTRL_ERR_MSK;
+		FLEXCAN_CTRL_ERR_STATE;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
 
 	/* save for later use */
 	priv->reg_ctrl_default = reg_ctrl;
-- 
1.7.4.1

