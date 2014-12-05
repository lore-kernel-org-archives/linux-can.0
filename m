From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [PATCH] iproute2: Add support for CAN presume-ack feature
Date: Fri,  5 Dec 2014 10:59:50 +0300
Message-ID: <1417766390-4587-2-git-send-email-nebaruzdin@gmail.com>
References: <1417766390-4587-1-git-send-email-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:65146 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbaLEIA3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Dec 2014 03:00:29 -0500
In-Reply-To: <1417766390-4587-1-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, linux-netdev@vger.kernel.org

This patch makes CAN_CTRLMODE_PRESUME_ACK netlink feature configurable.
When enabled, the feature sets CAN controller in mode in which
acknowledgement absence is ignored.

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 ip/iplink_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 5b92426..fb50332 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -37,6 +37,7 @@ static void print_usage(FILE *f)
 		"\t[ one-shot { on | off } ]\n"
 		"\t[ berr-reporting { on | off } ]\n"
 		"\t[ fd { on | off } ]\n"
+		"\t[ presume-ack { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
@@ -99,6 +100,7 @@ static void print_ctrlmode(FILE *f, __u32 cm)
 	_PF(CAN_CTRLMODE_ONE_SHOT, "ONE-SHOT");
 	_PF(CAN_CTRLMODE_BERR_REPORTING, "BERR-REPORTING");
 	_PF(CAN_CTRLMODE_FD, "FD");
+	_PF(CAN_CTRLMODE_PRESUME_ACK, "PRESUME-ACK");
 #undef _PF
 	if (cm)
 		fprintf(f, "%x", cm);
@@ -201,6 +203,10 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			set_ctrlmode("fd", *argv, &cm,
 				     CAN_CTRLMODE_FD);
+		} else if (matches(*argv, "presume-ack") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("presume-ack", *argv, &cm,
+				     CAN_CTRLMODE_PRESUME_ACK);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
-- 
2.1.3

