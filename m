From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2] candump: Add timeout option if no message has been received
Date: Tue, 12 Feb 2013 15:17:52 +0100
Message-ID: <1360678672-31881-1-git-send-email-alexander.stein@systec-electronic.com>
References: <511A4C8B.3030605@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:49436 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759860Ab3BLOR4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Feb 2013 09:17:56 -0500
In-Reply-To: <511A4C8B.3030605@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Chanes in v2:
* Use strtol instead of atoi
* Change memcpy to direct struct copy

 candump.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/candump.c b/candump.c
index bf3e8bb..7fce1d3 100644
--- a/candump.c
+++ b/candump.c
@@ -121,6 +121,7 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -d          (monitor dropped CAN frames)\n");
 	fprintf(stderr, "         -e          (dump CAN error frames in human-readable format)\n");
 	fprintf(stderr, "         -x          (print extra message infos, rx/tx brs esi)\n");
+	fprintf(stderr, "         -T <msecs>  (terminate after <msecs> without any reception)\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "Up to %d CAN interfaces with optional filter sets can be specified\n", MAXSOCK);
 	fprintf(stderr, "on the commandline in the form: <ifname>[,filter]*\n");
@@ -227,6 +228,7 @@ int main(int argc, char **argv)
 	int nbytes, i, maxdlen;
 	struct ifreq ifr;
 	struct timeval tv, last_tv;
+	struct timeval timeout, timeout_config, *timeout_current = NULL;
 	FILE *logfile = NULL;
 
 	signal(SIGTERM, sigterm);
@@ -236,7 +238,7 @@ int main(int argc, char **argv)
 	last_tv.tv_sec  = 0;
 	last_tv.tv_usec = 0;
 
-	while ((opt = getopt(argc, argv, "t:ciaSs:b:B:u:ldxLn:r:he?")) != -1) {
+	while ((opt = getopt(argc, argv, "t:ciaSs:b:B:u:ldxLn:r:heT:?")) != -1) {
 		switch (opt) {
 		case 't':
 			timestamp = optarg[0];
@@ -351,6 +353,16 @@ int main(int argc, char **argv)
 			}
 			break;
 
+		case 'T':
+			timeout_config.tv_usec = atoi(optarg);
+			if (timeout_config.tv_usec < 1) {
+				print_usage(basename(argv[0]));
+				exit(1);
+			}
+			timeout_config.tv_sec = timeout_config.tv_usec / 1000;
+			timeout_config.tv_usec = (timeout_config.tv_usec % 1000) * 1000;
+			timeout_current = &timeout;
+			break;
 		default:
 			print_usage(basename(argv[0]));
 			exit(1);
@@ -594,7 +606,10 @@ int main(int argc, char **argv)
 		for (i=0; i<currmax; i++)
 			FD_SET(s[i], &rdfs);
 
-		if ((ret = select(s[currmax-1]+1, &rdfs, NULL, NULL, NULL)) < 0) {
+		if (timeout_current)
+			memcpy(timeout_current, &timeout_config, sizeof(timeout_config));
+
+		if ((ret = select(s[currmax-1]+1, &rdfs, NULL, NULL, timeout_current)) <= 0) {
 			//perror("select");
 			running = 0;
 			continue;
-- 
1.8.1.2

