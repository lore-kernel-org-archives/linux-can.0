From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 9/9] can: janz-ican3: add support for one shot mode
Date: Fri, 20 Jul 2012 13:11:49 +0200
Message-ID: <1342782709-4868-10-git-send-email-mkl@pengutronix.de>
References: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42100 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab2GTLL4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jul 2012 07:11:56 -0400
In-Reply-To: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

The Janz VMOD-ICAN3 hardware has support for one shot packet
transmission. This means that a packet will be attempted to be sent
once, with no automatic retries.

The SocketCAN core has a controller-wide setting for this mode:
CAN_CTRLMODE_ONE_SHOT. The Janz VMOD-ICAN3 hardware supports this flag
on a per-packet level, but the SocketCAN core does not.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/janz-ican3.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index e06ec40..98ee438 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -116,6 +116,7 @@
 #define ICAN3_BUSERR_QUOTA_MAX	255
 
 /* Janz ICAN3 CAN Frame Conversion */
+#define ICAN3_SNGL	0x02
 #define ICAN3_ECHO	0x10
 #define ICAN3_EFF_RTR	0x40
 #define ICAN3_SFF_RTR	0x10
@@ -848,6 +849,10 @@ static void can_frame_to_ican3(struct ican3_dev *mod,
 	desc->data[0] |= cf->can_dlc;
 	desc->data[1] |= ICAN3_ECHO;
 
+	/* support single transmission (no retries) mode */
+	if (mod->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		desc->data[1] |= ICAN3_SNGL;
+
 	if (cf->can_id & CAN_RTR_FLAG)
 		desc->data[0] |= ICAN3_EFF_RTR;
 
@@ -1810,7 +1815,8 @@ static int __devinit ican3_probe(struct platform_device *pdev)
 	mod->can.do_set_mode = ican3_set_mode;
 	mod->can.do_get_berr_counter = ican3_get_berr_counter;
 	mod->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES
-				    | CAN_CTRLMODE_BERR_REPORTING;
+				    | CAN_CTRLMODE_BERR_REPORTING
+				    | CAN_CTRLMODE_ONE_SHOT;
 
 	/* find our IRQ number */
 	mod->irq = platform_get_irq(pdev, 0);
-- 
1.7.10

