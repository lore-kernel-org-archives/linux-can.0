From: yegorslists@googlemail.com
Subject: [PATCH] slcand: accept both tty* and /dev/tty* device names
Date: Thu, 23 Jan 2014 09:49:23 +0100
Message-ID: <1390466963-9519-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:37407 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbaAWItu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 03:49:50 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 slcand.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/slcand.c b/slcand.c
index 69d30f7..f682645 100644
--- a/slcand.c
+++ b/slcand.c
@@ -251,10 +251,12 @@ int main(int argc, char *argv[])
 
 	/* Prepare the tty device name string */
 	pch = strstr(tty, devprefix);
-	if (pch == tty)
-		print_usage(argv[0]);
+	if (pch != tty) {
+		snprintf(ttypath, TTYPATH_LENGTH, "%s%s", devprefix, tty);
+	} else {
+		snprintf(ttypath, TTYPATH_LENGTH, "%s", tty);
+	}
 
-	snprintf(ttypath, TTYPATH_LENGTH, "%s%s", devprefix, tty);
 	syslog(LOG_INFO, "starting on TTY device %s", ttypath);
 
 	/* Daemonize */
-- 
1.7.7

