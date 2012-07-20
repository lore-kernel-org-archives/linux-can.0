From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/9] can: janz-ican3: avoid firmware lockup caused by infinite bus error quota
Date: Fri, 20 Jul 2012 13:11:48 +0200
Message-ID: <1342782709-4868-9-git-send-email-mkl@pengutronix.de>
References: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42095 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab2GTLL4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jul 2012 07:11:56 -0400
In-Reply-To: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

If the bus error quota is set to infinite and the host CPU cannot keep
up, the Janz VMOD-ICAN3 firmware will stop responding to control
messages until the controller is reset.

The firmware will automatically stop sending bus error messages when the
quota is reached, and will only resume sending bus error messages when
the quota is re-set to a positive value.

This limitation is worked around by setting the bus error quota to one
message, and then re-setting the quota to one message every time a bus
error message is received. By doing this, the firmware never stops
responding to control messages. The CAN bus can be reset without a
hard-reset of the controller card.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/janz-ican3.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 47f8f6b..e06ec40 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -972,6 +972,16 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 			stats->rx_errors++;
 		}
 
+		/*
+		 * The controller automatically disables bus-error interrupts
+		 * and therefore we must re-enable them.
+		 */
+		ret = ican3_set_buserror(mod, 1);
+		if (ret) {
+			dev_err(mod->dev, "unable to re-enable bus-error\n");
+			return ret;
+		}
+
 		/* bus error reporting is off, return immediately */
 		if (!(mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
 			return 0;
@@ -1451,7 +1461,7 @@ static int __devinit ican3_startup_module(struct ican3_dev *mod)
 	}
 
 	/* default to "bus errors enabled" */
-	ret = ican3_set_buserror(mod, ICAN3_BUSERR_QUOTA_MAX);
+	ret = ican3_set_buserror(mod, 1);
 	if (ret) {
 		dev_err(mod->dev, "unable to set bus-error\n");
 		return ret;
-- 
1.7.10

