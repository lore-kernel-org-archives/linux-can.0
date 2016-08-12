From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: introduce CANFD_USE flag for mixed content in struct canfd_frame
Date: Fri, 12 Aug 2016 10:31:00 +0200
Message-ID: <1470990660-4810-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:29625 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbcHLIeT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Aug 2016 04:34:19 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The struct can_frame and struct canfd_frame intentionaly share the same
layout to be able to write CAN frame content into a CAN FD frame structure.
When this is done the former differentiation via CAN_MTU / CANFD_MTU gets
lost. CANFD_USE allows programmers to mark CAN FD frames in the case of
using struct canfd_frame for mixed CAN / CAN FD content (dual use).
N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside of
struct canfd_frame therefore the CANFD_USE flag is disregarded by Linux.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 9692cda..698ffc5 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -124,9 +124,18 @@ struct can_frame {
  * controller only the CANFD_BRS bit is relevant for real CAN controllers when
  * building a CAN FD frame for transmission. Setting the CANFD_ESI bit can make
  * sense for virtual CAN interfaces to test applications with echoed frames.
+ *
+ * The struct can_frame and struct canfd_frame intentionaly share the same
+ * layout to be able to write CAN frame content into a CAN FD frame structure.
+ * When this is done the former differentiation via CAN_MTU / CANFD_MTU gets
+ * lost. CANFD_USE allows programmers to mark CAN FD frames in the case of
+ * using struct canfd_frame for mixed CAN / CAN FD content (dual use).
+ * N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside of
+ * struct canfd_frame therefore the CANFD_USE flag is disregarded by Linux.
  */
 #define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
 #define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
+#define CANFD_USE 0x04 /* mark CAN FD for dual use of struct canfd_frame */
 
 /**
  * struct canfd_frame - CAN flexible data rate frame structure
-- 
2.8.1

