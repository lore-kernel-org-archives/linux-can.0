From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/4 RESEND] can: flexcan: Disable error interrupt when bus error reporting is disabled
Date: Tue, 12 Aug 2014 15:43:04 +0200
Message-ID: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:35607 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751810AbaHLNqf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Aug 2014 09:46:35 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

In case we don't have FLEXCAN_HAS_BROKEN_ERR_STATE and the user set
CAN_CTRLMODE_BERR_REPORTING once it can not be unset again until reboot.
So in case neither hardware nor user wants the error interrupt disable
the bit.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/flexcan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 33aea7eb9337..fd79dd40840b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -862,6 +862,8 @@ static int flexcan_chip_start(struct net_device *dev)
 	if (priv->devtype_data->features & FLEXCAN_HAS_BROKEN_ERR_STATE ||
 	    priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
 		reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
+	else
+		reg_ctrl &= ~FLEXCAN_CTRL_ERR_MSK;
 
 	/* save for later use */
 	priv->reg_ctrl_default = reg_ctrl;
-- 
1.8.5.5

