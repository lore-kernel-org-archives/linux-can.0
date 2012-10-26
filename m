From: yegorslists@googlemail.com
Subject: [PATCH] candump: add option to ignore ENOBUFS
Date: Fri, 26 Oct 2012 11:42:49 +0200
Message-ID: <1351244569-11398-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:44614 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab2JZJnJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Oct 2012 05:43:09 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

-f option replicated -i option from cangen and allows to
ignore ENOBUFS error in bridge mode

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 candump.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/candump.c b/candump.c
index ac51192..3a6be62 100644
--- a/candump.c
+++ b/candump.c
@@ -53,6 +53,7 @@
 #include <ctype.h>
 #include <libgen.h>
 #include <time.h>
+#include <errno.h>
 
 #include <sys/time.h>
 #include <sys/types.h>
@@ -122,6 +123,7 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -r <size>   (set socket receive buffer to <size>)\n");
 	fprintf(stderr, "         -d          (monitor dropped CAN frames)\n");
 	fprintf(stderr, "         -e          (dump CAN error frames in human-readable format)\n");
+	fprintf(stderr, "         -f          (ignore -ENOBUFS return values on write() syscalls)\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "Up to %d CAN interfaces with optional filter sets can be specified\n", MAXSOCK);
 	fprintf(stderr, "on the commandline in the form: <ifname>[,filter]*\n");
@@ -211,6 +213,7 @@ int main(int argc, char **argv)
 	unsigned char view = 0;
 	unsigned char log = 0;
 	unsigned char logfrmt = 0;
+	unsigned char ignore_enobufs = 0;
 	int count = 0;
 	int rcvbuf_size = 0;
 	int opt, ret;
@@ -236,7 +239,7 @@ int main(int argc, char **argv)
 	last_tv.tv_sec  = 0;
 	last_tv.tv_usec = 0;
 
-	while ((opt = getopt(argc, argv, "t:ciaSs:b:B:u:ldLn:r:he?")) != -1) {
+	while ((opt = getopt(argc, argv, "ft:ciaSs:b:B:u:ldLn:r:he?")) != -1) {
 		switch (opt) {
 		case 't':
 			timestamp = optarg[0];
@@ -347,6 +350,10 @@ int main(int argc, char **argv)
 			}
 			break;
 
+		case 'f':
+			ignore_enobufs = 1;
+			break;
+
 		default:
 			print_usage(basename(argv[0]));
 			exit(1);
@@ -625,8 +632,14 @@ int main(int argc, char **argv)
 
 					nbytes = write(bridge, &frame, sizeof(struct can_frame));
 					if (nbytes < 0) {
-						perror("bridge write");
-						return 1;
+						if (errno != ENOBUFS) {
+							perror("bridge write");
+							return 1;
+						}
+						if (!ignore_enobufs) {
+							perror("bridge write");
+							return 1;
+						}
 					} else if ((size_t)nbytes < sizeof(struct can_frame)) {
 						fprintf(stderr,"bridge write: incomplete CAN frame\n");
 						return 1;
-- 
1.7.7

