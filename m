From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [PATCH] can: Documentation: fix spelling of sample-point
Date: Wed, 19 Mar 2014 09:49:42 +0100
Message-ID: <1395218982-20306-1-git-send-email-r.schwebel@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34025 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670AbaCSIul (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Mar 2014 04:50:41 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: Robert Schwebel <r.schwebel@pengutronix.de>

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
---
 Documentation/networking/can.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 0cbe6ec..2fa44cb 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -1017,7 +1017,7 @@ solution for a couple of reasons:
 	in case of a bus-off condition after the specified delay time
 	in milliseconds. By default it's off.
 
-    "bitrate 125000 sample_point 0.875"
+    "bitrate 125000 sample-point 0.875"
 	Shows the real bit-rate in bits/sec and the sample-point in the
 	range 0.000..0.999. If the calculation of bit-timing parameters
 	is enabled in the kernel (CONFIG_CAN_CALC_BITTIMING=y), the
-- 
1.9.0

