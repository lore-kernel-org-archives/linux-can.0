From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] add 'v' command response
Date: Thu,  7 May 2015 16:20:28 +0200
Message-ID: <1431008428-22567-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50234 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbbEGOUb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 May 2015 10:20:31 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bombilee <chenglung@gmail.com>

From: bombilee <chenglung@gmail.com>

add v command response. Some software like USBtinViewer using v for software version.
Tested on USBtinViewer 1.0
---
Hello,

this just came in via gibhub.

Marc

 slcanpty.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/slcanpty.c b/slcanpty.c
index c062a027da41..f485ac775a53 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -185,6 +185,13 @@ rx_restart:
 		ptr = 1;
 		goto rx_out;
 	}
+	/* check for 'v'ersion command */
+	if (cmd == 'v') {
+		sprintf(replybuf, "v1014\r");
+		tmp = strlen(replybuf);
+		ptr = 1;
+		goto rx_out;
+	}
 
 	/* check for serial 'N'umber command */
 	if (cmd == 'N') {
-- 
2.1.4

