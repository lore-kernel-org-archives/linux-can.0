From: uescher <linux-can_ger.kernel.org@myvdr.de>
Subject: [PATCH 1/2] slcanpty: Improve the reading from pty to avoid incomplete
 messages in the reading buf[]
Date: Sun, 24 Feb 2013 16:30:35 +0100
Message-ID: <512A321B.7090201@myvdr.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020403030201030107070709"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:57182 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758035Ab3BXPhG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Feb 2013 10:37:06 -0500
Received: from [176.34.235.140] (helo=[0.0.0.0])
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <linux-can_ger.kernel.org@myvdr.de>)
	id 1U9dXA-0004kN-Ot
	for linux-can@vger.kernel.org; Sun, 24 Feb 2013 16:30:37 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------020403030201030107070709
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

slcanpty: Improve the reading from pty to avoid incomplete messages in 
the reading buf[]

This Patch ensure that we read the maximum of complete SLCAN messages 
from pty.
Leave messages at the pty if is not possible to read it complete in the buf.

Signed-off-by: Ulrich Escher <git@myvdr.de>


--------------020403030201030107070709
Content-Type: text/x-patch;
 name="0001-slcanpty-Improve-the-reading-from-pty-to-avoid-incom.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-slcanpty-Improve-the-reading-from-pty-to-avoid-incom.pa";
 filename*1="tch"

From 13e8e6ad85e42f68816d14eb74c0f3fabcd28465 Mon Sep 17 00:00:00 2001
From: ulrich <git@myvdr.de>
Date: Sun, 24 Feb 2013 15:55:19 +0100
Subject: [PATCH 1/2] slcanpty: Improve the reading from pty to avoid
 incomplete messages in the reading buf[]

This Patch ensure that we read the maximum of complete SLCAN messages from pty.
Leave messages at the pty if is not possible to read it complete in the buf.

Signed-off-by: Ulrich Escher <git@myvdr.de>
---
 slcanpty.c |   32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/slcanpty.c b/slcanpty.c
index f3628b9..037edf5 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -31,6 +31,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <termios.h>
+#include <poll.h>
 
 #include <net/if.h>
 #include <sys/socket.h>
@@ -74,12 +75,41 @@ int pty2can(int pty, int socket, struct can_filter *fi,
 	struct can_frame frame;
 	int tmp, i;
 
-	nbytes = read(pty, &buf, sizeof(buf)-1);
+	nbytes = read(pty, &buf, sizeof(buf)-SLC_MTU-1);
 	if (nbytes < 0) {
 		perror("read pty");
 		return 1;
 	}
 
+	if (nbytes == sizeof(buf)-SLC_MTU-1) {
+		struct pollfd fds;
+		fds.fd = pty;
+		fds.events = POLLIN;
+
+		while (buf[nbytes-1] != '\r' && nbytes < (sizeof(buf)-1)) {
+			tmp = poll(&fds, 1, 0);
+			if (tmp < 0) {
+				perror("poll pty");
+				return 1;
+			}
+
+			if (fds.revents & POLLIN) {
+				tmp = read(pty, &buf[nbytes++], 1);
+				if (tmp < 0) {
+					perror("read pty");
+					return 1;
+				}
+			} else {
+				/* No further Data available */
+				break;
+			}
+		}
+	}
+
+#ifdef DEBUG
+	printf("read %d bytes from pty\n",nbytes);
+#endif
+
 rx_restart:
 	/* remove trailing '\r' characters to be robust against some apps */
 	while (buf[0] == '\r' && nbytes > 0) {
-- 
1.7.9.5


--------------020403030201030107070709--
