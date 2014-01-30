From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH 2/2] canbusload: Fix worst-case frame length estimation
Date: Thu, 30 Jan 2014 11:05:02 +0100
Message-ID: <1391076302-12053-2-git-send-email-sojkam1@fel.cvut.cz>
References: <id:87ob2tkcts.fsf@steelpick.2x.cz>
 <1391076302-12053-1-git-send-email-sojkam1@fel.cvut.cz>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:48825 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004AbaA3KF4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 30 Jan 2014 05:05:56 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id B1A7419F364B
	for <linux-can@vger.kernel.org>; Thu, 30 Jan 2014 11:05:55 +0100 (CET)
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id 9voHryoVNaVa for <linux-can@vger.kernel.org>;
	Thu, 30 Jan 2014 11:05:51 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 78C5F19F3639
	for <linux-can@vger.kernel.org>; Thu, 30 Jan 2014 11:05:51 +0100 (CET)
In-Reply-To: <1391076302-12053-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Michal Sojka <sojkam1@fel.cvut.cz>

The Tindell's method used previously is incorrect. It does not account for
the fact that the stuffed bits are themselves also subject to bit stuffing.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 canframelen.c |  2 +-
 canframelen.h | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/canframelen.c b/canframelen.c
index d54cf6e..299e8d1 100644
--- a/canframelen.c
+++ b/canframelen.c
@@ -237,7 +237,7 @@ unsigned can_frame_length(struct canfd_frame *frame, enum cfl_mode mode, int mtu
 	case CFL_NO_BITSTUFFING:
 		return (eff ? 67 : 47) + frame->len*8;
 	case CFL_WORSTCASE:
-		return ((eff ? 389 : 269) + frame->len*48)/5;
+		return ((eff ? 80 : 55) + frame->len*10;
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

