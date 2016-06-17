From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v5 5/5] can: bcm: add documentation for CAN FD support
Date: Fri, 17 Jun 2016 15:35:28 +0200
Message-ID: <1466170528-10193-6-git-send-email-socketcan@hartkopp.net>
References: <1466170528-10193-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:33586 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554AbcFQNfm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 09:35:42 -0400
In-Reply-To: <1466170528-10193-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 Documentation/networking/can.txt | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index d58ff84..aa15b9e 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -31,6 +31,7 @@ This file contains
       4.2.4 Broadcast Manager message sequence transmission
       4.2.5 Broadcast Manager receive filter timers
       4.2.6 Broadcast Manager multiplex message receive filter
+      4.2.7 Broadcast Manager CAN FD support
     4.3 connected transport protocols (SOCK_SEQPACKET)
     4.4 unconnected transport protocols (SOCK_DGRAM)
 
@@ -799,7 +800,7 @@ solution for a couple of reasons:
     } mytxmsg;
 
     (..)
-    mytxmsg.nframes = 4;
+    mytxmsg.msg_head.nframes = 4;
     (..)
 
     write(s, &mytxmsg, sizeof(mytxmsg));
@@ -852,6 +853,28 @@ solution for a couple of reasons:
 
     write(s, &msg, sizeof(msg));
 
+  4.2.7 Broadcast Manager CAN FD support
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

