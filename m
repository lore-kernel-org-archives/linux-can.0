From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 08/12] can: flexcan: add missing register definitions
Date: Mon,  4 Jul 2016 20:32:13 +0200
Message-ID: <1467657137-18891-9-git-send-email-mkl@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40013 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753366AbcGDScW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2016 14:32:22 -0400
In-Reply-To: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds some missing register definitions, which are needed in an
upcoming patch.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index adad38d17b0e..ae16add589a8 100644
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
2.8.1

