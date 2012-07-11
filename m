From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] cangen: allow double value for gap
Date: Wed, 11 Jul 2012 16:23:12 +0200
Message-ID: <1342016592-1401-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:56564 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755233Ab2GKOXS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jul 2012 10:23:18 -0400
Received: from comm.systec-electronic.de (95-91-85-164-dynip.superkabel.de [95.91.85.164])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 167FE27A555
	for <linux-can@vger.kernel.org>; Wed, 11 Jul 2012 16:33:03 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

This way a user can specify a gap below 1ms. This is somehwat similar
to setting the gap to 0, but the ENOBUFS are greatly reduced, so a given
amount of CAN messages by -n is still usefull and useable.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 cangen.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cangen.c b/cangen.c
index 20cc921..4f37808 100644
--- a/cangen.c
+++ b/cangen.c
@@ -132,7 +132,7 @@ void sigterm(int signo)
 
 int main(int argc, char **argv)
 {
-	unsigned long gap = DEFAULT_GAP; 
+	double gap = DEFAULT_GAP;
 	unsigned long polltimeout = 0;
 	unsigned char ignore_enobufs = 0;
 	unsigned char extended = 0;
@@ -173,7 +173,7 @@ int main(int argc, char **argv)
 			break;
 
 		case 'g':
-			gap = strtoul(optarg, NULL, 10);
+			gap = strtod(optarg, NULL);
 			break;
 
 		case 'e':
@@ -251,7 +251,7 @@ int main(int argc, char **argv)
 	}
 
 	ts.tv_sec = gap / 1000;
-	ts.tv_nsec = (gap % 1000) * 1000000;
+	ts.tv_nsec = ((int)(gap * 1000000)) % 1000000000;
 
 	if (id_mode == MODE_FIX) {
 
-- 
1.7.8.6

