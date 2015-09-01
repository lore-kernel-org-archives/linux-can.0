From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/8] can: flexcan: add missing register definitions
Date: Tue,  1 Sep 2015 12:31:55 +0200
Message-ID: <1441103522-15593-2-git-send-email-mkl@pengutronix.de>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34002 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302AbbIAKcK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 06:32:10 -0400
In-Reply-To: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds some missing register definitions, which are needed in an
upcoming patch.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 57eb6537799f..457688f2929e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -56,7 +56,7 @@
 #define FLEXCAN_MCR_WAK_SRC		BIT(19)
 #define FLEXCAN_MCR_DOZE		BIT(18)
 #define FLEXCAN_MCR_SRX_DIS		BIT(17)
-#define FLEXCAN_MCR_BCC			BIT(16)
+#define FLEXCAN_MCR_IRMQ		BIT(16)
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
 #define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
@@ -211,7 +211,10 @@ struct flexcan_regs {
 	u32 imask1;		/* 0x28 */
 	u32 iflag2;		/* 0x2c */
 	u32 iflag1;		/* 0x30 */
-	u32 ctrl2;		/* 0x34 */
+	union {			/* 0x34 */
+		u32 gfwr_mx28;	/* MX28, MX53 */
+		u32 ctrl2;	/* MX6, VF610 */
+	};
 	u32 esr2;		/* 0x38 */
 	u32 imeur;		/* 0x3c */
 	u32 lrfr;		/* 0x40 */
@@ -230,7 +233,11 @@ struct flexcan_regs {
 	 *				size conf'ed via ctrl2::RFFN
 	 *				(mx6, vf610)
 	 */
-	u32 _reserved4[408];
+	u32 _reserved4[256];	/* 0x480 */
+	u32 rximr[64];		/* 0x880 */
+	u32 _reserved5[24];	/* 0x980 */
+	u32 gfwr_mx6;		/* 0x9e0 - MX6 */
+	u32 _reserved6[63];	/* 0x9e4 */
 	u32 mecr;		/* 0xae0 */
 	u32 erriar;		/* 0xae4 */
 	u32 erridpr;		/* 0xae8 */
-- 
2.5.0

