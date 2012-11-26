From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/5] can-calc-bit-timing: add support for ti_hecc
Date: Mon, 26 Nov 2012 21:44:49 +0100
Message-ID: <1353962689-18669-6-git-send-email-mkl@pengutronix.de>
References: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57749 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756499Ab2KZUow (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 15:44:52 -0500
In-Reply-To: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 can-calc-bit-timing.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
index d97ebe6..a9fb992 100644
--- a/can-calc-bit-timing.c
+++ b/can-calc-bit-timing.c
@@ -199,6 +199,23 @@ static void printf_btr_mcp251x(struct can_bittiming *bt, int hdr)
 	}
 }
 
+static void printf_btr_ti_hecc(struct can_bittiming *bt, int hdr)
+{
+	if (hdr) {
+		printf("%10s", "CANBTC");
+	} else {
+		uint32_t can_btc;
+
+		can_btc = (bt->phase_seg2 - 1) & 0x7;
+		can_btc |= ((bt->phase_seg1 + bt->prop_seg - 1)
+			    & 0xF) << 3;
+		can_btc |= ((bt->sjw - 1) & 0x3) << 8;
+		can_btc |= ((bt->brp - 1) & 0xFF) << 16;
+
+		printf("0x%08x", can_btc);
+	}
+}
+
 static struct can_bittiming_const can_calc_consts[] = {
 	{
 		.name = "sja1000",
@@ -397,6 +414,20 @@ static struct can_bittiming_const can_calc_consts[] = {
 		.ref_clk = 16000000,
 		.printf_btr = printf_btr_mcp251x,
 	},
+	{
+		.name = "ti_hecc",
+		.tseg1_min = 1,
+		.tseg1_max = 16,
+		.tseg2_min = 1,
+		.tseg2_max = 8,
+		.sjw_max = 4,
+		.brp_min = 1,
+		.brp_max = 256,
+		.brp_inc = 1,
+
+		.ref_clk = 13000000,
+		.printf_btr = printf_btr_ti_hecc,
+	}
 };
 
 static long common_bitrates[] = {
-- 
1.7.10.4

