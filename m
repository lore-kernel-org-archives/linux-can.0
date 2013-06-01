From: uescher <linux-can_ger.kernel.org@myvdr.de>
Subject: [PATCH 1/1 V2] slcanpty: Improve the data handling from pty2can()
 to avoid, incomplete messages in further processing
Date: Sat, 01 Jun 2013 21:18:50 +0200
Message-ID: <51AA491A.7060307@myvdr.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020900010109040305070301"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:53057 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760Ab3FATfk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 1 Jun 2013 15:35:40 -0400
Received: from [176.34.235.140] (helo=[0.0.0.0])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <linux-can_ger.kernel.org@myvdr.de>)
	id 1UirKZ-0002Nr-L9
	for linux-can@vger.kernel.org; Sat, 01 Jun 2013 21:19:12 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------020900010109040305070301
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

slcanpty: Improve the data handling from pty2can() to avoid
  incomplete messages in further processing

This Patch ensure that we have minimum one complete SLCAN messages from 
pty in our buf[]
before we start the processing.
Leave framgents of an messages in the buf[] and wait with processing 
until we have a '\r' in the buf[].

Signed-off-by: Ulrich Escher <git@myvdr.de>




--------------020900010109040305070301
Content-Type: text/x-patch;
 name="0001-slcanpty-Improve-the-data-handling-from-pty2can-to-a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-slcanpty-Improve-the-data-handling-from-pty2can-to-a.pa";
 filename*1="tch"

From 1ce314cb99592d4e6021717fffbe8130001f3838 Mon Sep 17 00:00:00 2001
From: ulrich <git@myvdr.de>
Date: Sat, 1 Jun 2013 21:06:49 +0200
Subject: [PATCH] slcanpty: Improve the data handling from pty2can() to avoid
 incomplete messages in further processing

This Patch ensure that we have minimum one complete SLCAN messages from pty in our buf[]
before we start the processing.
Leave framgents of an messages in the buf[] and wait with processing until we have a '\r' in the buf[].

Signed-off-by: Ulrich Escher <git@myvdr.de>
---
 slcanpty.c |   39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/slcanpty.c b/slcanpty.c
index f3628b9..8d1a6b3 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -73,12 +73,18 @@ int pty2can(int pty, int socket, struct can_filter *fi,
 	int ptr;
 	struct can_frame frame;
 	int tmp, i;
+	static int nbytes_saved = 0;
 
-	nbytes = read(pty, &buf, sizeof(buf)-1);
+	nbytes = read(pty, &buf[nbytes_saved], sizeof(buf)-nbytes_saved-1);
 	if (nbytes < 0) {
 		perror("read pty");
 		return 1;
 	}
+#ifdef DEBUG
+	printf("read %d bytes from pty\n",nbytes);
+#endif
+	nbytes = nbytes_saved + nbytes;
+	nbytes_saved = 0;
 
 rx_restart:
 	/* remove trailing '\r' characters to be robust against some apps */
@@ -91,6 +97,19 @@ rx_restart:
 	if (!nbytes)
 		return 0;
 
+	for (tmp = 0; tmp <= nbytes; tmp++) {
+		if (tmp == nbytes) {
+			nbytes_saved = nbytes;
+#ifdef DEBUG
+			printf("nbytes_saveds ist nun: %d return\n", nbytes);
+#endif
+			return 0;
+		}
+		if (buf[tmp] == '\r') {
+			break;
+		}
+	}
+
 	cmd = buf[0];
 	buf[nbytes] = 0;
 
@@ -359,7 +378,9 @@ int can2pty(int pty, int socket, int *tstamp)
 		return 1;
 	}
 	fflush(NULL);
-
+#ifdef DEBUG
+	printf("%s\n",buf);
+#endif
 	return 0;
 }
 
@@ -478,16 +499,18 @@ int main(int argc, char **argv)
 			continue;
 		}
 
-		if (FD_ISSET(p, &rdfs))
+		if (FD_ISSET(p, &rdfs)) {
 			if (pty2can(p, s, &fi, &is_open, &tstamp)) {
-			running = 0;
-			continue;
+				running = 0;
+				continue;
+			}
 		}
 
-		if (FD_ISSET(s, &rdfs))
+		if (FD_ISSET(s, &rdfs)) {
 			if (can2pty(p, s, &tstamp)) {
-			running = 0;
-			continue;
+				running = 0;
+				continue;
+			}
 		}
 	}
 
-- 
1.7.9.5


--------------020900010109040305070301--
