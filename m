From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [PATCH] can-calc-bit-timing: add support for rcar_can
Date: Mon, 29 Feb 2016 10:18:45 +0000
Message-ID: <1456741125-50017-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:30592 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752304AbcB2KX2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Feb 2016 05:23:28 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, wg@grandegger.com
Cc: linux-can@vger.kernel.org, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
Hi Mark,

   This patch is generated on top of can-utils master

   commit:
   cda6117 can: avoid using timeval for uapi

   in response to https://www.mail-archive.com/netdev@vger.kernel.org/msg99549.html

 can-calc-bit-timing.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
index 9031a78..b6236f0 100644
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
@@ -472,6 +492,21 @@ static struct can_bittiming_const can_calc_consts[] = {
 
 		.ref_clk = 13000000,
 		.printf_btr = printf_btr_ti_hecc,
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
 	}
 };
 
-- 
1.9.1

