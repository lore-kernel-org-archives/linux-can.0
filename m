From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [iproute2 2/2] iplink: Support for CAN presume-ack feature
Date: Mon, 21 Jul 2014 13:43:18 +0400
Message-ID: <1405935800-26622-3-git-send-email-nebaruzdin@gmail.com>
References: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34945 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbaGUJnf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Jul 2014 05:43:35 -0400
Received: by mail-lb0-f171.google.com with SMTP id l4so4599362lbv.30
        for <linux-can@vger.kernel.org>; Mon, 21 Jul 2014 02:43:32 -0700 (PDT)
Received: from localhost.localdomain (lvk-gate.cs.msu.ru. [188.44.42.233])
        by mx.google.com with ESMTPSA id ks4sm10999632lac.18.2014.07.21.02.43.31
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jul 2014 02:43:31 -0700 (PDT)
In-Reply-To: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This patch makes the newly introduced CAN_CTRLMODE_PRESUME_ACK netlink
feature configurable. When enabled, the feature sets CAN controller in
mode in which acknowledgement absence is ignored.

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 ip/iplink_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 5674358..01d8131 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -32,6 +32,7 @@ static void usage(void)
 	        "\t[ triple-sampling { on | off } ]\n"
 	        "\t[ one-shot { on | off } ]\n"
 	        "\t[ berr-reporting { on | off } ]\n"
+	        "\t[ presume-ack { on | off } ]\n"
 		"\n"
 	        "\t[ restart-ms TIME-MS ]\n"
 	        "\t[ restart ]\n"
@@ -88,6 +89,7 @@ static void print_ctrlmode(FILE *f, __u32 cm)
 	_PF(CAN_CTRLMODE_3_SAMPLES, "TRIPLE-SAMPLING");
 	_PF(CAN_CTRLMODE_ONE_SHOT, "ONE-SHOT");
 	_PF(CAN_CTRLMODE_BERR_REPORTING, "BERR-REPORTING");
+	_PF(CAN_CTRLMODE_PRESUME_ACK, "PRESUME-ACK");
 #undef _PF
 	if (cm)
 		fprintf(f, "%x", cm);
@@ -154,6 +156,10 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			set_ctrlmode("berr-reporting", *argv, &cm,
 				     CAN_CTRLMODE_BERR_REPORTING);
+		} else if (matches(*argv, "presume-ack") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("presume-ack", *argv, &cm,
+				     CAN_CTRLMODE_PRESUME_ACK);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
-- 
2.0.2

