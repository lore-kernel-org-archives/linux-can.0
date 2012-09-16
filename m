From: uescher <linux-can_ger.kernel.org@myvdr.de>
Subject: [Patch] can-utils/slcanpty.c pseudo-terminal interface
Date: Mon, 17 Sep 2012 00:12:23 +0200
Message-ID: <50564EC7.7020005@myvdr.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000504030805030708070207"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:40808 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab2IPWRd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 16 Sep 2012 18:17:33 -0400
Received: from [176.34.235.140] (helo=[0.0.0.0])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <linux-can_ger.kernel.org@myvdr.de>)
	id 1TDN4j-0004VP-03
	for linux-can@vger.kernel.org; Mon, 17 Sep 2012 00:12:25 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------000504030805030708070207
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Add Support for the Unix 98 pseudo-terminal interface /dev/ptmx /dev/pts/N

please take a look over the little Patch.
Thanks

--------------000504030805030708070207
Content-Type: text/x-patch;
 name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch.diff"

diff --git a/slcanpty.c b/slcanpty.c
index 67dcf35..e3b7304 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -26,6 +26,11 @@
  *
  */
 
+#ifndef _GNU_SOURCE  
+// To get ptsname grantpt and unlockpt definitions from stdlib.h  
+#define _GNU_SOURCE  
+#endif  
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -45,6 +50,8 @@
 /* maximum rx buffer len: extended CAN frame with timestamp */
 #define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
 
+#define DEVICE_NAME_PTMX "/dev/ptmx"
+
 #define DEBUG
 
 static int asc2nibble(char c)
@@ -387,6 +394,8 @@ int main(int argc, char **argv)
 		fprintf(stderr, "Usage: %s <pty> <can interface>\n", argv[0]);
 		fprintf(stderr, "e.g. '%s /dev/ptyc0 can0' creates"
 			" /dev/ttyc0 for the slcan application\n", argv[0]);
+		fprintf(stderr, "e.g. for pseudo-terminal '%s /dev/ptmx can0' creates"
+			" /dev/pts/N\n", argv[0]);
 		fprintf(stderr, "\n");
 		return 1;
 	}
@@ -408,6 +417,27 @@ int main(int argc, char **argv)
 			   ECHONL | ECHOPRT | ECHOKE | ICRNL);
 	tcsetattr(p, TCSANOW, &topts);
 
+	//Support for the Unix 98 pseudo-terminal interface /dev/ptmx /dev/pts/N
+	if  (strcmp(argv[1],DEVICE_NAME_PTMX) == 0) {
+		if (grantpt(p) < 0) {
+			perror("grantpt");
+			return 1;
+		}
+
+		if (unlockpt(p) < 0) {
+			perror("unlockpt");
+			return 1;
+		}
+
+		char* name_pts = NULL;	/* slave pseudo-terminal device name */
+		name_pts = ptsname(p);
+		if (name_pts == NULL) {
+			perror("ptsname");
+			return 1;
+		}
+		printf("open: %s: slave pseudo-terminal is %s\n", argv[1], name_pts);
+	}
+
 	/* open socket */
 	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
 	if (s < 0) {

--------------000504030805030708070207--
