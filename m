From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH 2/2] canbusload: Fix worst-case frame length estimation
Date: Thu, 30 Jan 2014 14:38:59 +0100
Message-ID: <1391089139-31201-2-git-send-email-sojkam1@fel.cvut.cz>
References: <87fvo5k2w2.fsf@steelpick.2x.cz>
 <1391089139-31201-1-git-send-email-sojkam1@fel.cvut.cz>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:41531 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbaA3NjM (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 30 Jan 2014 08:39:12 -0500
In-Reply-To: <1391089139-31201-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, Michal Sojka <sojkam1@fel.cvut.cz>

The Tindell's method used previously is incorrect. It does not account for
the fact that the stuffed bits are themselves also subject to bit stuffing.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 canframelen.c |  2 +-
 canframelen.h | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/canframelen.c b/canframelen.c
index 46671a1..388295a 100644
--- a/canframelen.c
+++ b/canframelen.c
@@ -246,7 +246,7 @@ unsigned can_frame_length(struct canfd_frame *frame, enum cfl_mode mode, int mtu
 	case CFL_NO_BITSTUFFING:
 		return (eff ? 67 : 47) + frame->len * 8;
 	case CFL_WORSTCASE:
-		return ((eff ? 389 : 269) + frame->len * 48) / 5;
+		return (eff ? 80 : 55) + frame->len * 10;
 	case CFL_EXACT:
 		return cfl_exact((struct can_frame*)frame);
 	}
diff --git a/canframelen.h b/canframelen.h
index 225bc09..39b7706 100644
--- a/canframelen.h
+++ b/canframelen.h
@@ -6,20 +6,23 @@
 /**
  * Frame length calculation modes.
  *
- * CFL_WORSTCASE corresponds to Ken Tindells *worst* case calculation
- * for stuff-bits (see "Guaranteeing Message Latencies on Controller
- * Area Network" 1st ICC'94) the needed bits on the wire can be
- * calculated as:
+ * CFL_WORSTCASE corresponds to *worst* case calculation for
+ * stuff-bits - see (1)-(3) in [1]. The worst case number of bits on
+ * the wire can be calculated as:
  *
- * (34 + 8n)/5 + 47 + 8n for SFF frames (11 bit CAN-ID) => (269 + 48n)/5
- * (54 + 8n)/5 + 67 + 8n for EFF frames (29 bit CAN-ID) => (389 + 48n)/5
+ * (34 + 8n - 1)/4 + 34 + 8n + 13 for SFF frames (11 bit CAN-ID) => 55 + 10n
+ * (54 + 8n - 1)/4 + 54 + 8n + 13 for EFF frames (29 bit CAN-ID) => 80 + 10n
  *
  * while 'n' is the data length code (number of payload bytes)
  *
+ * [1] "Controller Area Network (CAN) schedulability analysis:
+ *     Refuted, revisited and revised", Real-Time Syst (2007)
+ *     35:239-272.
+ *
  */
 enum cfl_mode {
 	CFL_NO_BITSTUFFING, /* plain bit calculation without bitstuffing */
-	CFL_WORSTCASE, /* with bitstuffing following Tindells estimation */
+	CFL_WORSTCASE, /* worst case estimation - see above */
 	CFL_EXACT, /* exact calculation of stuffed bits based on frame
 		    * content and CRC */
 };
-- 
1.8.5.2

