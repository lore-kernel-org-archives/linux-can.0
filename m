From: Oleksandr Tyshchenko <oleksandr.tyshchenko@globallogic.com>
Subject: [PATCH v1] can: c_can: Enable interrupts only when initialization has been completed
Date: Wed,  2 Apr 2014 20:28:05 +0300
Message-ID: <1396459685-8133-1-git-send-email-oleksandr.tyshchenko@globallogic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:40446 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbaDARgD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 13:36:03 -0400
Received: by mail-wg0-f46.google.com with SMTP id b13so7870679wgh.5
        for <linux-can@vger.kernel.org>; Tue, 01 Apr 2014 10:36:00 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de

In current driver realization we enable interrupts twice from c_can_start().
First time in c_can_start()->c_can_chip_config() during set operating mode.
Second time in the end of c_can_start() after finish basic controller
configuration.

Enabling interrupts in first place (while initialization is ongoing)
may cause to interrupts when the CAN chip is not completely initialized.
Also if basic controller configuration failed with error,
we will leave initialization sequence with interrupts enabled.

We have to enable interrupts only when initialization has been completed.
So, don't enable interrupts while initialization is ongoing.

Signed-off-by: Oleksandr Tyshchenko <oleksandr.tyshchenko@globallogic.com>
---
 drivers/net/can/c_can/c_can.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 6883938..3ce776e8 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -642,24 +642,18 @@ static int c_can_chip_config(struct net_device *dev)
 	if ((priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)) {
 		/* loopback + silent mode : useful for hot self-test */
-		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_EIE |
-				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
 		priv->write_reg(priv, C_CAN_TEST_REG,
 				TEST_LBACK | TEST_SILENT);
 	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
 		/* loopback mode : useful for self-test function */
-		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_EIE |
-				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
 		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK);
 	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
 		/* silent mode : bus-monitoring mode */
-		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_EIE |
-				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
 		priv->write_reg(priv, C_CAN_TEST_REG, TEST_SILENT);
-	} else
-		/* normal mode*/
-		priv->write_reg(priv, C_CAN_CTRL_REG,
-				CONTROL_EIE | CONTROL_SIE | CONTROL_IE);
+	}
 
 	/* configure message objects */
 	c_can_configure_msg_objects(dev);
-- 
1.7.9.5

