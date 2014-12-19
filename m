From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 4/5] use line discipline number from linux/tty.h
Date: Fri, 19 Dec 2014 07:22:19 -0800
Message-ID: <1419002540-2208-5-git-send-email-jmmahler@gmail.com>
References: <1419002540-2208-1-git-send-email-jmmahler@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:57961 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbaLSPXN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 19 Dec 2014 10:23:13 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so1359667pab.26
        for <linux-can@vger.kernel.org>; Fri, 19 Dec 2014 07:23:13 -0800 (PST)
In-Reply-To: <1419002540-2208-1-git-send-email-jmmahler@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>

The line discipline number is provided in include/linux/tty.h.
Use that instead of a #define in each program.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 slcan_attach.c | 5 ++---
 slcand.c       | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/slcan_attach.c b/slcan_attach.c
index 2c95d22..ab8ff0a 100644
--- a/slcan_attach.c
+++ b/slcan_attach.c
@@ -51,8 +51,7 @@
 #include <sys/ioctl.h>
 #include <net/if.h>
 #include <termios.h>
-
-#define LDISC_N_SLCAN 17 /* default slcan line discipline since Kernel 2.6.25 */
+#include <linux/tty.h>
 
 void print_usage(char *prg)
 {
@@ -77,7 +76,7 @@ void print_usage(char *prg)
 int main(int argc, char **argv)
 {
 	int fd;
-	int ldisc = LDISC_N_SLCAN;
+	int ldisc = N_SLCAN;
 	int detach = 0;
 	int waitkey = 0;
 	int send_open = 0;
diff --git a/slcand.c b/slcand.c
index b72fa4e..e5e4752 100644
--- a/slcand.c
+++ b/slcand.c
@@ -37,9 +37,7 @@
 #include <sys/ioctl.h>
 #include <net/if.h>
 #include <termios.h>
-
-/* default slcan line discipline since Kernel 2.6.25 */
-#define LDISC_N_SLCAN 17
+#include <linux/tty.h>
 
 /* Change this to whatever your daemon is called */
 #define DAEMON_NAME "slcand"
@@ -180,7 +178,7 @@ int main(int argc, char *argv[])
 	char *btr = NULL;
 	int run_as_daemon = 1;
 	char *pch;
-	int ldisc = LDISC_N_SLCAN;
+	int ldisc = N_SLCAN;
 	int fd;
 
 	ttypath[0] = '\0';
-- 
2.1.3

