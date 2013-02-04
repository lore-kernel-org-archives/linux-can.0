From: yegorslists@googlemail.com
Subject: [PATCH] slcand: fix build warnings
Date: Mon,  4 Feb 2013 10:10:22 +0100
Message-ID: <1359969022-4620-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:40961 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201Ab3BDJKw (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 4 Feb 2013 04:10:52 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Remove unused variable name.

Fix FILE pointer check (fopen() returns a pointer not an integer).

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 slcand.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/slcand.c b/slcand.c
index 2353c99..807ffaa 100644
--- a/slcand.c
+++ b/slcand.c
@@ -95,7 +95,7 @@ static void child_handler (int signum)
 	}
 }
 
-static void daemonize (const char *lockfile, char *tty, char *name)
+static void daemonize (const char *lockfile, char *tty)
 {
 	pid_t pid, sid, parent;
 	int lfp = -1;
@@ -182,7 +182,7 @@ static void daemonize (const char *lockfile, char *tty, char *name)
 	}
 
 	pFile = fopen (pidfile,"w");
-	if (pFile < 0)
+	if (pFile == NULL)
 	{
 		syslog (LOG_ERR, "unable to create pid file %s, code=%d (%s)",
 			pidfile, errno, strerror (errno));
@@ -243,7 +243,7 @@ int main (int argc, char *argv[])
 	syslog (LOG_INFO, "starting on TTY device %s", ttypath);
 
 	/* Daemonize */
-	daemonize ("/var/lock/" DAEMON_NAME, tty, name);
+	daemonize ("/var/lock/" DAEMON_NAME, tty);
 
 	/* Now we are a daemon -- do the work for which we were paid */
 	int fd;
-- 
1.7.7

