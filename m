From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [PATCH v2] can-calc-bit-timing: add support for rcar_can
Date: Mon, 29 Feb 2016 10:41:49 +0000
Message-ID: <1456742509-62609-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <56D41D7F.2020705@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:16974 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752054AbcB2KqS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Feb 2016 05:46:18 -0500
In-Reply-To: <56D41D7F.2020705@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, wg@grandegger.com
Cc: linux-can@vger.kernel.org, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
Hi Marc,

   Thanks. Missed it while removing the hacks. This v2 patch corrects it.

 can-calc-bit-timing.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
index 9031a78..b89536b 100644
--- a/can-calc-bit-timing.c
+++ b/can-calc-bit-timing.c
@@ -219,6 +219,26 @@ static void printf_btr_ti_hecc(struct can_bittiming *bt, int hdr)
 	}
 }
 
+static void printf_btr_rcar_can(struct can_bittiming *bt, int hdr)
+{
+	if (hdr) {
+		printf("%10s", "CiBCR");
+	} else {
+		uint32_t bcr;
+#define RCAR_CAN_BCR_TSEG1(x)   (((x) & 0x0f) << 20)
+#define RCAR_CAN_BCR_BPR(x)     (((x) & 0x3ff) << 8)
+#define RCAR_CAN_BCR_SJW(x)     (((x) & 0x3) << 4)
+#define RCAR_CAN_BCR_TSEG2(x)   ((x) & 0x07)
+
+		bcr = RCAR_CAN_BCR_TSEG1(bt->phase_seg1 + bt->prop_seg - 1) |
+			RCAR_CAN_BCR_BPR(bt->brp - 1) |
+			RCAR_CAN_BCR_SJW(bt->sjw - 1) |
+			RCAR_CAN_BCR_TSEG2(bt->phase_seg2 - 1);
+
+		printf("0x%08x", bcr<<8);
+	}
+}
+
 static struct can_bittiming_const can_calc_consts[] = {
 	{
 		.name = "sja1000",
@@ -472,7 +492,21 @@ static struct can_bittiming_const can_calc_consts[] = {
 
 		.ref_clk = 13000000,
 		.printf_btr = printf_btr_ti_hecc,
-	}
+	},
+	{
+		.name = "rcar_can",
+		.tseg1_min = 4,
+		.tseg1_max = 16,
+		.tseg2_min = 2,
+		.tseg2_max = 8,
+		.sjw_max = 4,
+		.brp_min = 1,
+		.brp_max = 1024,
+		.brp_inc = 1,
+
+		.ref_clk = 65000000,
+		.printf_btr = printf_btr_rcar_can,
+	},
 };
 
 static long common_bitrates[] = {
-- 
1.9.1

