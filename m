From: Armin Burchardt <armin@uni-bremen.de>
Subject: [PATCH 1/3] slcand: daemonize _after_ interface is created, renamed and up.
Date: Mon,  8 Jun 2015 13:55:38 +0200
Message-ID: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gabriel-3.zfn.uni-bremen.de ([134.102.50.3]:44918 "EHLO
	smtp.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752013AbbFHLzp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 07:55:45 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Armin Burchardt <armin@uni-bremen.de>

Create interface, then daemonize to avoid race-conditions,
ie. in init.d-scripts.

Signed-off-by: Armin Burchardt <armin@uni-bremen.de>
---
 slcand.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/slcand.c b/slcand.c
index e5e4752..af7ca98 100644
--- a/slcand.c
+++ b/slcand.c
@@ -255,23 +255,7 @@ int main(int argc, char *argv[])
 
 	syslog(LOG_INFO, "starting on TTY device %s", ttypath);
 
-	/* Daemonize */
-	if (run_as_daemon) {
-		if (daemon(0, 0)) {
-			syslog(LOG_ERR, "failed to daemonize");
-			exit(EXIT_FAILURE);
-		}
-	}
-	else {
-		/* Trap signals that we expect to receive */
-		signal(SIGINT, child_handler);
-		signal(SIGTERM, child_handler);
-	}
-
-	/* */
-	slcand_running = 1;
-
-	/* Now we are a daemon -- do the work for which we were paid */
+	/* Create file handle for tty device. */
 	fd = open(ttypath, O_RDWR | O_NONBLOCK | O_NOCTTY);
 	if (fd < 0) {
 		syslog(LOG_NOTICE, "failed to open TTY device %s\n", ttypath);
@@ -365,6 +349,23 @@ int main(int argc, char *argv[])
 		}	
 	}
 
+	/* Daemonize (_after_ interface is up to avoid race-conditions,
+	 * ie. between init.d-scripts). */
+	if (run_as_daemon) {
+		if (daemon(0, 0)) {
+			syslog(LOG_ERR, "failed to daemonize");
+			exit(EXIT_FAILURE);
+		}
+	}
+	else {
+		/* Trap signals that we expect to receive */
+		signal(SIGINT, child_handler);
+		signal(SIGTERM, child_handler);
+	}
+
+	/* */
+	slcand_running = 1;
+
 	/* The Big Loop */
 	while (slcand_running)
 		sleep(1); /* wait 1 second */
-- 
1.9.1

