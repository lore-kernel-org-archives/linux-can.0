From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/5] can-calc-bit-timing: add 24 and 66 MHz flexcan ref clock
Date: Mon, 26 Nov 2012 21:44:47 +0100
Message-ID: <1353962689-18669-4-git-send-email-mkl@pengutronix.de>
References: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57746 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449Ab2KZUow (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 15:44:52 -0500
In-Reply-To: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

as found on some imx boards.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 can-calc-bit-timing.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
index c5c66b0..f49ba09 100644
--- a/can-calc-bit-timing.c
+++ b/can-calc-bit-timing.c
@@ -310,6 +310,20 @@ static struct can_bittiming_const can_calc_consts[] = {
 		.brp_max = 256,
 		.brp_inc = 1,
 
+		.ref_clk = 24000000,	/* mx28 */
+		.printf_btr = printf_btr_flexcan,
+	},
+	{
+		.name = "flexcan",
+		.tseg1_min = 4,
+		.tseg1_max = 16,
+		.tseg2_min = 2,
+		.tseg2_max = 8,
+		.sjw_max = 4,
+		.brp_min = 1,
+		.brp_max = 256,
+		.brp_inc = 1,
+
 		.ref_clk = 49875000,
 		.printf_btr = printf_btr_flexcan,
 	},
@@ -324,6 +338,20 @@ static struct can_bittiming_const can_calc_consts[] = {
 		.brp_max = 256,
 		.brp_inc = 1,
 
+		.ref_clk = 66000000,
+		.printf_btr = printf_btr_flexcan,
+	},
+	{
+		.name = "flexcan",
+		.tseg1_min = 4,
+		.tseg1_max = 16,
+		.tseg2_min = 2,
+		.tseg2_max = 8,
+		.sjw_max = 4,
+		.brp_min = 1,
+		.brp_max = 256,
+		.brp_inc = 1,
+
 		.ref_clk = 66500000,
 		.printf_btr = printf_btr_flexcan,
 	},
-- 
1.7.10.4

