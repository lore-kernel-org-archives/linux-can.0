From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 3/3] can: add documentation for CAN filter usage optimisation
Date: Wed,  2 Apr 2014 20:25:27 +0200
Message-ID: <1396463127-25541-4-git-send-email-socketcan@hartkopp.net>
References: <1396463127-25541-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:61993 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795AbaDBSZh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 14:25:37 -0400
In-Reply-To: <1396463127-25541-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

To benefit from special filters for single SFF or single EFF CAN identifier
subscriptions the CAN_EFF_FLAG bit and the CAN_RTR_FLAG bit has to be set
together with the CAN_(SFF|EFF)_MASK in can_filter.mask.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 Documentation/networking/can.txt | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 0cbe6ec..9261fe8 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -469,6 +469,41 @@ solution for a couple of reasons:
   having this 'send only' use-case we may remove the receive list in the
   Kernel to save a little (really a very little!) CPU usage.
 
+  4.1.1.1 CAN filter usage optimisation
+
+  The CAN filters are processed in per-device filter lists at CAN frame
+  reception time. To reduce the number of checks that need to be performed
+  while walking through the filter lists the CAN core provides an optimized
+  filter handling when the filter subscription focusses on a single CAN ID.
+
+  For the possible 2048 SFF CAN identifiers the identifier is used as an index
+  to access the corresponding subscription list without any further checks.
+  For the 2^29 possible EFF CAN identifiers a 10 bit XOR folding is used as
+  hash function to retrieve the EFF table index.
+
+  To benefit from the optimized filters for single CAN identifiers the
+  CAN_SFF_MASK or CAN_EFF_MASK have to be set into can_filter.mask together
+  with set CAN_EFF_FLAG and CAN_RTR_FLAG bits. A set CAN_EFF_FLAG bit in the
+  can_filter.mask makes clear that it matters whether a SFF or EFF CAN ID is
+  subscribed. E.g. in the example from above
+
+    rfilter[0].can_id   = 0x123;
+    rfilter[0].can_mask = CAN_SFF_MASK;
+
+  both SFF frames with CAN ID 0x123 and EFF frames with 0xXXXXX123 can pass.
+
+  To filter for only 0x123 (SFF) and 0x12345678 (EFF) CAN identifiers the
+  filter has to be defined in this way to benefit from the optimized filters:
+
+    struct can_filter rfilter[2];
+
+    rfilter[0].can_id   = 0x123;
+    rfilter[0].can_mask = (CAN_EFF_FLAG | CAN_RTR_FLAG | CAN_SFF_MASK);
+    rfilter[1].can_id   = 0x12345678 | CAN_EFF_FLAG;
+    rfilter[1].can_mask = (CAN_EFF_FLAG | CAN_RTR_FLAG | CAN_EFF_MASK);
+
+    setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, &rfilter, sizeof(rfilter));
+
   4.1.2 RAW socket option CAN_RAW_ERR_FILTER
 
   As described in chapter 3.4 the CAN interface driver can generate so
-- 
1.9.1

