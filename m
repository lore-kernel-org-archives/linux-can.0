From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] canplayer: convert skipgap to unsigned long
Date: Thu,  9 Apr 2015 23:01:21 +0200
Message-ID: <1428613281-21827-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35043 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933406AbbDIVBk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2015 17:01:40 -0400
Received: by wgyo15 with SMTP id o15so122055260wgy.2
        for <linux-can@vger.kernel.org>; Thu, 09 Apr 2015 14:01:39 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Yegor Yefremov <yegorslists@googlemail.com>

The result of (last_log_tv.tv_sec - log_tv.tv_sec) is
unsigned long, so use labs() in order not to trim the
value to int. Make skipgap to unsigned long for the same
reason.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 canplayer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/canplayer.c b/canplayer.c
index f74668e..437ed4b 100644
--- a/canplayer.c
+++ b/canplayer.c
@@ -86,7 +86,7 @@ void print_usage(char *prg)
 		"send frames immediately)\n");
 	fprintf(stderr, "                      -g <ms>      (gap in milli "
 		"seconds - default: %d ms)\n", DEFAULT_GAP);
-	fprintf(stderr, "                      -s <s>      (skip gaps in "
+	fprintf(stderr, "                      -s <s>       (skip gaps in "
 		"timestamps > 's' seconds)\n");
 	fprintf(stderr, "                      -x           (disable local "
 		"loopback of sent CAN frames)\n");
@@ -241,7 +241,8 @@ int main(int argc, char **argv)
 	FILE *infile = stdin;
 	unsigned long gap = DEFAULT_GAP; 
 	int use_timestamps = 1;
-	static int verbose, opt, delay_loops, skipgap;
+	static int verbose, opt, delay_loops;
+	static unsigned long skipgap;
 	static int loopback_disable = 0;
 	static int infinite_loops = 0;
 	static int loops = DEFAULT_LOOPS;
@@ -482,7 +483,7 @@ int main(int argc, char **argv)
 					/* test for logfile timestamps jumping backwards OR      */
 					/* if the user likes to skip long gaps in the timestamps */
 					if ((last_log_tv.tv_sec > log_tv.tv_sec) ||
-					    (skipgap && abs(last_log_tv.tv_sec - log_tv.tv_sec) > skipgap))
+					    (skipgap && labs(last_log_tv.tv_sec - log_tv.tv_sec) > skipgap))
 						create_diff_tv(&today_tv, &diff_tv, &log_tv);
 
 					last_log_tv = log_tv;
-- 
2.1.0

