From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] candump: Add possibility to specify logfile
Date: Wed, 21 Aug 2013 10:17:06 +0200
Message-ID: <1377073026-30202-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:52532 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447Ab3HUIVF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2013 04:21:05 -0400
Received: from comm.systec-electronic.de (unknown [212.185.67.146])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 9C81B27A6BE
	for <linux-can@vger.kernel.org>; Wed, 21 Aug 2013 09:49:37 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

You need to use -l/tmp/logfile (wihtout space!) because -l takes an
optional parameter.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 candump.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/candump.c b/candump.c
index c865bd7..72193fc 100644
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
+	const char* fname = NULL;
 
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
@@ -566,22 +568,27 @@ int main(int argc, char **argv)
 	if (log) {
 		time_t currtime;
 		struct tm now;
-		char fname[sizeof("candump-2006-11-20_202026.log")+1];
+		char filename[sizeof("candump-2006-11-20_202026.log")+1];
 
-		if (time(&currtime) == (time_t)-1) {
-			perror("time");
-			return 1;
-		}
+		if (fname == NULL)
+		{
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

