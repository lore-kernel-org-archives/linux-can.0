From: David Jander <david@protonic.nl>
Subject: [PATCH 10/14] can: flexcan: add documentation about mailbox organizaiton
Date: Thu,  6 Nov 2014 09:34:09 +0100
Message-ID: <1415262853-22907-11-git-send-email-david@protonic.nl>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26404 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbaKFIeH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 03:34:07 -0500
In-Reply-To: <1415262853-22907-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

From: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a short documentation snippet about the mailbox organization as
it's regularly not correct in freescale's datasheets.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 172065c..2e70a27 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -230,6 +230,16 @@ struct flexcan_regs {
 	u32 rxfir;		/* 0x4c */
 	u32 _reserved3[12];	/* 0x50 */
 	struct flexcan_mb cantxfg[64];	/* 0x80 */
+	/* FIFO-mode:
+	 *			MB
+	 * 0x080...0x08f	0	RX message buffer
+	 * 0x090...0x0df	1-5	reserverd
+	 * 0x0e0...0x0ff	6-7	8 entry ID table
+	 *				(mx25, mx28, mx35, mx53)
+	 * 0x0e0...0x2df	6-7..37	8..128 entry ID table
+	 *			  	size conf'ed via ctrl2::RFFN
+	 *				(mx6, vf610)
+	 */
 	u32 _reserved4[408];
 	u32 mecr;		/* 0xae0 */
 	u32 erriar;		/* 0xae4 */
-- 
1.9.1

