From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 5/6] can: janz-ican3: avoid firmware lockup caused by infinite bus error quota
Date: Wed, 18 Jul 2012 15:33:17 -0700
Message-ID: <1342650798-2991-6-git-send-email-iws@ovro.caltech.edu>
References: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:50097 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab2GRWdX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 18:33:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 7E99B21FCD
	for <linux-can@vger.kernel.org>; Wed, 18 Jul 2012 15:33:23 -0700 (PDT)
In-Reply-To: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

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
---
 drivers/net/can/janz-ican3.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 1304712..df3ba07 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -960,6 +960,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 	 * skb allocation when it will just be freed immediately.
 	 */
 	if (isrc == CEVTIND_BEI) {
+		int ret;
 		dev_dbg(mod->dev, "bus error interrupt, part 1\n");
 
 		/* TX error */
@@ -970,6 +971,16 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
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
@@ -1447,7 +1458,7 @@ static int __devinit ican3_startup_module(struct ican3_dev *mod)
 	}
 
 	/* default to "bus errors enabled" */
-	ret = ican3_set_buserror(mod, ICAN3_BUSERR_QUOTA_MAX);
+	ret = ican3_set_buserror(mod, 1);
 	if (ret) {
 		dev_err(mod->dev, "unable to set bus-error\n");
 		return ret;
-- 
1.7.8.6

