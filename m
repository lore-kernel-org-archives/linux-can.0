From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] cansniffer: increase resolution for timeout values
Date: Tue, 24 Jun 2014 21:31:03 +0200
Message-ID: <1403638263-4019-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:57762 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaFXTbO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 15:31:14 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

From: Marc Kleine-Budde <mkl@pengutronix.de>

As requested by Felix Seitz the timeout for screen updates should be
configurable to values smaller than 100ms. Marc Kleine-Budde provided the
original patch to increase the resolution of the timing relevant variables.

The rotating animation was replaced by a rolling screen update counter.
Additionally the CAN-ID is now printed in the same ASCII hex representation
as the CAN data.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 cansniffer.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/cansniffer.c b/cansniffer.c
index c8ee58e..39b3e2b 100644
--- a/cansniffer.c
+++ b/cansniffer.c
@@ -86,16 +86,13 @@
 
 /* time defaults */
 
-#define TIMEOUT 50 /* in 100ms */
-#define HOLD    10 /* in 100ms */
-#define LOOP     2 /* in 100ms */
-
-#define MAXANI 8
-const char anichar[MAXANI] = {'|', '/', '-', '\\', '|', '/', '-', '\\'};
+#define TIMEOUT 500 /* in 10ms */
+#define HOLD    100 /* in 10ms */
+#define LOOP     20 /* in 10ms */
 
 #define ATTCOLOR ATTBOLD FGRED
 
-#define STARTLINESTR "X  time    ID  data ... "
+#define STARTLINESTR "XX delta   ID  data ... "
 
 struct snif {
 	int flags;
@@ -172,9 +169,9 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -B         (start with binary mode with gap - exceeds 80 chars!)\n");
 	fprintf(stderr, "         -c         (color changes)\n");
 	fprintf(stderr, "         -f         (filter on CAN-ID only)\n");
-	fprintf(stderr, "         -t <time>  (timeout for ID display [x100ms] default: %d, 0 = OFF)\n", TIMEOUT);
-	fprintf(stderr, "         -h <time>  (hold marker on changes [x100ms] default: %d)\n", HOLD);
-	fprintf(stderr, "         -l <time>  (loop time (display) [x100ms] default: %d)\n", LOOP);
+	fprintf(stderr, "         -t <time>  (timeout for ID display [x10ms] default: %d, 0 = OFF)\n", TIMEOUT);
+	fprintf(stderr, "         -h <time>  (hold marker on changes [x10ms] default: %d)\n", HOLD);
+	fprintf(stderr, "         -l <time>  (loop time (display) [x10ms] default: %d)\n", LOOP);
 	fprintf(stderr, "Use interface name '%s' to receive from all can-interfaces\n", ANYDEV);
 	fprintf(stderr, "\n");
 	fprintf(stderr, "%s", manual);
@@ -329,7 +326,7 @@ int main(int argc, char **argv)
 		FD_SET(s, &rdfs);
 
 		timeo.tv_sec  = 0;
-		timeo.tv_usec = 100000 * loop;
+		timeo.tv_usec = 10000 * loop;
 
 		if ((ret = select(s+1, &rdfs, NULL, NULL, &timeo)) < 0) {
 			//perror("select");
@@ -338,7 +335,7 @@ int main(int argc, char **argv)
 		}
 
 		gettimeofday(&tv, NULL);
-		currcms = (tv.tv_sec - start_tv.tv_sec) * 10 + (tv.tv_usec / 100000);
+		currcms = (tv.tv_sec - start_tv.tv_sec) * 100 + (tv.tv_usec / 10000);
 
 		if (FD_ISSET(0, &rdfs))
 			running &= handle_keyb(s);
@@ -538,6 +535,7 @@ int handle_timeo(int fd, long currcms){
 
 	int i;
 	int force_redraw = 0;
+	static unsigned int frame_count;
 
 	if (clearscreen) {
 		char startline[80];
@@ -555,7 +553,8 @@ int handle_timeo(int fd, long currcms){
 	}
 
 	printf("%s", CSR_HOME);
-	printf("%c\n", anichar[currcms % MAXANI]); /* funny animation */
+	printf("%02d\n", frame_count++); /* rolling display update counter */
+	frame_count %= 100;
 
 	for (i=0; i < 2048; i++) {
 
@@ -608,7 +607,7 @@ void print_snifline(int id){
 	if (diffsec > 10)
 		diffsec = 9, diffusec = 999999;
 
-	printf("%ld.%06ld  %3x  ", diffsec, diffusec, id);
+	printf("%ld.%06ld  %3X  ", diffsec, diffusec, id);
 
 	if (binary) {
 
-- 
2.0.0

