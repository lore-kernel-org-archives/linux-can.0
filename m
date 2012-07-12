From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 3/3] can: janz-ican3: add support for one shot mode
Date: Thu, 12 Jul 2012 09:15:32 -0700
Message-ID: <1342109732-4995-4-git-send-email-iws@ovro.caltech.edu>
References: <1342109732-4995-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:43747 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab2GLQPg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Jul 2012 12:15:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 77A142229C
	for <linux-can@vger.kernel.org>; Thu, 12 Jul 2012 09:15:36 -0700 (PDT)
In-Reply-To: <1342109732-4995-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

The Janz VMOD-ICAN3 hardware has support for one shot packet
transmission. This means that a packet will be attempted to be sent
once, with no automatic retries.

The SocketCAN core supports this mode using CAN_CTRLMODE_ONE_SHOT.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

This is trivial, and the driver might as well support this option.

 drivers/net/can/janz-ican3.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 5fff829..d42f6f6 100644
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
 
@@ -1791,7 +1796,8 @@ static int __devinit ican3_probe(struct platform_device *pdev)
 	mod->can.do_set_mode = ican3_set_mode;
 	mod->can.do_get_berr_counter = ican3_get_berr_counter;
 	mod->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES
-				    | CAN_CTRLMODE_BERR_REPORTING;
+				    | CAN_CTRLMODE_BERR_REPORTING
+				    | CAN_CTRLMODE_ONE_SHOT;
 
 	/* find our IRQ number */
 	mod->irq = platform_get_irq(pdev, 0);
-- 
1.7.8.6

