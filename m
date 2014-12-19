From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 3/5] slcand: consistent use of exit(EXIT_FAILURE)
Date: Fri, 19 Dec 2014 07:22:18 -0800
Message-ID: <1419002540-2208-4-git-send-email-jmmahler@gmail.com>
References: <1419002540-2208-1-git-send-email-jmmahler@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62274 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbaLSPXL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 19 Dec 2014 10:23:11 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so1384623pab.33
        for <linux-can@vger.kernel.org>; Fri, 19 Dec 2014 07:23:11 -0800 (PST)
In-Reply-To: <1419002540-2208-1-git-send-email-jmmahler@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>

Some places used exit(1) and others used exit(EXIT_FAILURE).
Be consistent and use exit(EXIT_FAILURE) for all of these instances.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 slcand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/slcand.c b/slcand.c
index c4c81c5..b72fa4e 100644
--- a/slcand.c
+++ b/slcand.c
@@ -334,13 +334,13 @@ int main(int argc, char *argv[])
 	/* set slcan like discipline on given tty */
 	if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
 		perror("ioctl TIOCSETD");
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 	
 	/* retrieve the name of the created CAN netdevice */
 	if (ioctl(fd, SIOCGIFNAME, buf) < 0) {
 		perror("ioctl SIOCGIFNAME");
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 
 	syslog(LOG_NOTICE, "attached TTY %s to netdevice %s\n", ttypath, buf);
@@ -359,7 +359,7 @@ int main(int argc, char *argv[])
 			if (ioctl(s, SIOCSIFNAME, &ifr) < 0) {
 				syslog(LOG_NOTICE, "netdevice %s rename to %s failed\n", buf, name);
 				perror("ioctl SIOCSIFNAME rename");
-				exit(1);
+				exit(EXIT_FAILURE);
 			} else
 				syslog(LOG_NOTICE, "netdevice %s renamed to %s\n", buf, name);
 
-- 
2.1.3

