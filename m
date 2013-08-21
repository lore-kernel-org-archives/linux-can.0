From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2] candump: Add possibility to specify logfile
Date: Wed, 21 Aug 2013 11:21:08 +0200
Message-ID: <1377076868-31679-1-git-send-email-alexander.stein@systec-electronic.com>
References: <52147A71.2080200@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:54787 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751422Ab3HUJVM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2013 05:21:12 -0400
Received: from comm.systec-electronic.de (unknown [212.185.67.146])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 4B70D27A563
	for <linux-can@vger.kernel.org>; Wed, 21 Aug 2013 10:49:44 +0200 (CEST)
In-Reply-To: <52147A71.2080200@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

You need to use -l/tmp/logfile (wihtout space!) because -l takes an
optional parameter.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Changes in v2:
* Fixed some coding style issues

 candump.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/candump.c b/candump.c
index c865bd7..35ccaad 100644
--- a/candump.c
+++ b/candump.c
@@ -115,7 +115,7 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -b <can>    (bridge mode - send received frames to <can>)\n");
 	fprintf(stderr, "         -B <can>    (bridge mode - like '-b' with disabled loopback)\n");
 	fprintf(stderr, "         -u <usecs>  (delay bridge forwarding by <usecs> microseconds)\n");
-	fprintf(stderr, "         -l          (log CAN-frames into file. Sets '-s %d' by default)\n", SILENT_ON);
+	fprintf(stderr, "         -l[logfile] (log CAN-frames into file. Sets '-s %d' by default)\n", SILENT_ON);
 	fprintf(stderr, "         -L          (use log file format on stdout)\n");
 	fprintf(stderr, "         -n <count>  (terminate after receiption of <count> CAN frames)\n");
 	fprintf(stderr, "         -r <size>   (set socket receive buffer to <size>)\n");
@@ -231,6 +231,7 @@ int main(int argc, char **argv)
 	struct timeval tv, last_tv;
 	struct timeval timeout, timeout_config = { 0, 0 }, *timeout_current = NULL;
 	FILE *logfile = NULL;
+	const char *fname = NULL;
 
 	signal(SIGTERM, sigterm);
 	signal(SIGHUP, sigterm);
@@ -239,7 +240,7 @@ int main(int argc, char **argv)
 	last_tv.tv_sec  = 0;
 	last_tv.tv_usec = 0;
 
-	while ((opt = getopt(argc, argv, "t:ciaSs:b:B:u:ldxLn:r:heT:?")) != -1) {
+	while ((opt = getopt(argc, argv, "t:ciaSs:b:B:u:l::dxLn:r:heT:?")) != -1) {
 		switch (opt) {
 		case 't':
 			timestamp = optarg[0];
@@ -324,6 +325,7 @@ int main(int argc, char **argv)
 
 		case 'l':
 			log = 1;
+			fname = optarg;
 			break;
 
 		case 'd':
@@ -566,22 +568,26 @@ int main(int argc, char **argv)
 	if (log) {
 		time_t currtime;
 		struct tm now;
-		char fname[sizeof("candump-2006-11-20_202026.log")+1];
+		char filename[sizeof("candump-2006-11-20_202026.log") + 1];
 
-		if (time(&currtime) == (time_t)-1) {
-			perror("time");
-			return 1;
-		}
+		if (fname == NULL) {
+			if (time(&currtime) == (time_t)-1) {
+				perror("time");
+				return 1;
+			}
+
+			localtime_r(&currtime, &now);
 
-		localtime_r(&currtime, &now);
+			sprintf(filename, "candump-%04d-%02d-%02d_%02d%02d%02d.log",
+				now.tm_year + 1900,
+				now.tm_mon + 1,
+				now.tm_mday,
+				now.tm_hour,
+				now.tm_min,
+				now.tm_sec);
 
-		sprintf(fname, "candump-%04d-%02d-%02d_%02d%02d%02d.log",
-			now.tm_year + 1900,
-			now.tm_mon + 1,
-			now.tm_mday,
-			now.tm_hour,
-			now.tm_min,
-			now.tm_sec);
+			fname = filename;
+		}
 
 		if (silent != SILENT_ON)
 			printf("\nWarning: console output active while logging!");
-- 
1.8.1.5

