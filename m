From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 5/5] can: bcm: add documentation for CAN FD support
Date: Mon, 30 May 2016 20:36:30 +0200
Message-ID: <1464633390-24299-6-git-send-email-socketcan@hartkopp.net>
References: <1464633390-24299-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:25581 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161721AbcE3Sgq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 May 2016 14:36:46 -0400
In-Reply-To: <1464633390-24299-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 Documentation/networking/can.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index d58ff84..3ec4375 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -852,6 +852,28 @@ solution for a couple of reasons:
 
     write(s, &msg, sizeof(msg));
 
+  4.2.6 Broadcast Manager CAN FD support
+
+  The programming API of the CAN_BCM depends on struct can_frame which is
+  given as array directly behind the bcm_msg_head structure. To follow this
+  schema for the CAN FD frames a new flag 'CAN_FD_FRAME' in the bcm_msg_head
+  flags indicates that the concatenated CAN frame structures behind the
+  bcm_msg_head are defined as struct canfd_frame.
+
+    struct {
+            struct bcm_msg_head msg_head;
+            struct canfd_frame frame[5];
+    } msg;
+
+    msg.msg_head.opcode  = RX_SETUP;
+    msg.msg_head.can_id  = 0x42;
+    msg.msg_head.flags   = CAN_FD_FRAME;
+    msg.msg_head.nframes = 5;
+    (..)
+
+  When using CAN FD frames for multiplex filtering the MUX mask is still
+  expected in the first 64 bit of the struct canfd_frame data section.
+
   4.3 connected transport protocols (SOCK_SEQPACKET)
   4.4 unconnected transport protocols (SOCK_DGRAM)
 
-- 
2.8.1

