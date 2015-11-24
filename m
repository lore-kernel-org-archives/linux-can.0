From: Stefan Tatschner <rumpelsepp@sevenbyte.org>
Subject: [PATCH] can-doc: Add hint about getting timestamps
Date: Tue, 24 Nov 2015 15:06:29 +0100
Message-ID: <1448373989-7241-1-git-send-email-rumpelsepp@sevenbyte.org>
References: <56546954.1070005@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.sevenbyte.org ([5.9.90.188]:33142 "EHLO mail.sevenbyte.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbbKXOGi (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 24 Nov 2015 09:06:38 -0500
In-Reply-To: <56546954.1070005@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-can@vger.kernel.org, Stefan Tatschner <rumpelsepp@sevenbyte.org>

This patch adds a hint about how to get timestamps of received
CAN frames with ioctl(2). This hint has been applied to the
former SocketCAN Documentation, but it got lost during mainlining
the first bits and pieces to linux kernel.

Signed-off-by: Stefan Tatschner <rumpelsepp@sevenbyte.org>
---
 Documentation/networking/can.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 05fd83b..6ab619f 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -372,6 +372,15 @@ solution for a couple of reasons:
     nbytes = sendto(s, &frame, sizeof(struct can_frame),
                     0, (struct sockaddr*)&addr, sizeof(addr));
 
+  An accurate timestamp can be obtained with an ioctl(2) call after reading
+  a message from the socket:
+
+    struct timeval tv;
+    ioctl(s, SIOCGSTAMP, &tv);
+
+  The timestamp has a resolution of one microsecond and is set automatically
+  at the reception of a CAN frame.
+
   Remark about CAN FD (flexible data rate) support:
 
   Generally the handling of CAN FD is very similar to the formerly described
-- 
2.6.2

