From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] cansniffer: totally untested hack to reduce display update by factor of 10
Date: Tue, 24 Jun 2014 18:24:05 +0200
Message-ID: <1403627045-27811-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60007 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470AbaFXQYK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 12:24:10 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: felix.seitz@thm-motorsport.de
Cc: linux-can@vger.kernel.org, socketcan@hartkopp.net, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 cansniffer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cansniffer.c b/cansniffer.c
index c8ee58e..81806b3 100644
--- a/cansniffer.c
+++ b/cansniffer.c
@@ -86,9 +86,9 @@
 
 /* time defaults */
 
-#define TIMEOUT 50 /* in 100ms */
-#define HOLD    10 /* in 100ms */
-#define LOOP     2 /* in 100ms */
+#define TIMEOUT 500 /* in 10ms */
+#define HOLD    100 /* in 10ms */
+#define LOOP      2 /* in 10ms */
 
 #define MAXANI 8
 const char anichar[MAXANI] = {'|', '/', '-', '\\', '|', '/', '-', '\\'};
@@ -174,7 +174,7 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -f         (filter on CAN-ID only)\n");
 	fprintf(stderr, "         -t <time>  (timeout for ID display [x100ms] default: %d, 0 = OFF)\n", TIMEOUT);
 	fprintf(stderr, "         -h <time>  (hold marker on changes [x100ms] default: %d)\n", HOLD);
-	fprintf(stderr, "         -l <time>  (loop time (display) [x100ms] default: %d)\n", LOOP);
+	fprintf(stderr, "         -l <time>  (loop time (display) [x10ms] default: %d)\n", LOOP);
 	fprintf(stderr, "Use interface name '%s' to receive from all can-interfaces\n", ANYDEV);
 	fprintf(stderr, "\n");
 	fprintf(stderr, "%s", manual);
@@ -329,7 +329,7 @@ int main(int argc, char **argv)
 		FD_SET(s, &rdfs);
 
 		timeo.tv_sec  = 0;
-		timeo.tv_usec = 100000 * loop;
+		timeo.tv_usec = 10000 * loop;
 
 		if ((ret = select(s+1, &rdfs, NULL, NULL, &timeo)) < 0) {
 			//perror("select");
@@ -338,7 +338,7 @@ int main(int argc, char **argv)
 		}
 
 		gettimeofday(&tv, NULL);
-		currcms = (tv.tv_sec - start_tv.tv_sec) * 10 + (tv.tv_usec / 100000);
+		currcms = (tv.tv_sec - start_tv.tv_sec) * 100 + (tv.tv_usec / 10000);
 
 		if (FD_ISSET(0, &rdfs))
 			running &= handle_keyb(s);
-- 
2.0.0

