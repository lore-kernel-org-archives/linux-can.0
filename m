From: Rostislav Lisovy <lisovy@gmail.com>
Subject: [PATCH] cangen: Enable sending of RTR CAN frames
Date: Wed, 18 Jul 2012 13:33:39 +0200
Message-ID: <1342611219-18643-1-git-send-email-lisovy@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33893 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2GRLdz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 07:33:55 -0400
Received: by bkwj10 with SMTP id j10so1274007bkw.19
        for <linux-can@vger.kernel.org>; Wed, 18 Jul 2012 04:33:54 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Rostislav Lisovy <lisovy@gmail.com>

Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
---
 cangen.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/cangen.c b/cangen.c
index 4f37808..7147f65 100644
--- a/cangen.c
+++ b/cangen.c
@@ -101,6 +101,7 @@ void print_usage(char *prg)
 		" write() syscalls)\n");
 	fprintf(stderr, "         -x            (disable local loopback of "
 		"generated CAN frames)\n");
+	fprintf(stderr, "         -R            (send RTR frame)\n");
 	fprintf(stderr, "         -v            (increment verbose level for "
 		"printing sent CAN frames)\n\n");
 	fprintf(stderr, "Generation modes:\n");
@@ -141,6 +142,7 @@ int main(int argc, char **argv)
 	unsigned char dlc_mode = MODE_RANDOM;
 	unsigned char loopback_disable = 0;
 	unsigned char verbose = 0;
+	unsigned char rtr_frame = 0;
 	int count = 0;
 	uint64_t incdata = 0;
 
@@ -165,7 +167,7 @@ int main(int argc, char **argv)
 	signal(SIGHUP, sigterm);
 	signal(SIGINT, sigterm);
 
-	while ((opt = getopt(argc, argv, "ig:eI:L:D:xp:n:vh?")) != -1) {
+	while ((opt = getopt(argc, argv, "ig:eI:L:D:xp:n:vRh?")) != -1) {
 		switch (opt) {
 
 		case 'i':
@@ -224,6 +226,10 @@ int main(int argc, char **argv)
 			loopback_disable = 1;
 			break;
 
+		case 'R':
+			rtr_frame = 1;
+			break;
+
 		case 'p':
 			polltimeout = strtoul(optarg, NULL, 10);
 			break;
@@ -268,6 +274,9 @@ int main(int argc, char **argv)
 			frame.can_id &= CAN_SFF_MASK;
 	}
 
+	if (rtr_frame)
+		frame.can_id |= CAN_RTR_FLAG;
+
 	if (extended)
 		frame.can_id |=  CAN_EFF_FLAG;
 
-- 
1.7.9.5

