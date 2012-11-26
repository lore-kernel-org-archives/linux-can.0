From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/5] can-calc-bit-timing: add 66.66 MHz mscan refclock
Date: Mon, 26 Nov 2012 21:44:48 +0100
Message-ID: <1353962689-18669-5-git-send-email-mkl@pengutronix.de>
References: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57747 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563Ab2KZUow (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 15:44:52 -0500
In-Reply-To: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 can-calc-bit-timing.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
index f49ba09..d97ebe6 100644
--- a/can-calc-bit-timing.c
+++ b/can-calc-bit-timing.c
@@ -271,6 +271,20 @@ static struct can_bittiming_const can_calc_consts[] = {
 		.printf_btr = printf_btr_sja1000,
 	},
 	{
+		.name = "mscan",
+		.tseg1_min = 4,
+		.tseg1_max = 16,
+		.tseg2_min = 2,
+		.tseg2_max = 8,
+		.sjw_max = 4,
+		.brp_min = 1,
+		.brp_max = 64,
+		.brp_inc = 1,
+
+		.ref_clk = 66660000,	/* mpc5121 */
+		.printf_btr = printf_btr_sja1000,
+	},
+	{
 		.name = "at91",
 		.tseg1_min = 4,
 		.tseg1_max = 16,
-- 
1.7.10.4

