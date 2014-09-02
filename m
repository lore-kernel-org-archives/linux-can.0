From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RFC: [PATCH v2 2/2] can: flexcan: increase FLEXCAN_MCR_MAXMB() macro to 7 bits
Date: Tue,  2 Sep 2014 17:03:36 +0200
Message-ID: <1409670216-25674-3-git-send-email-mkl@pengutronix.de>
References: <1409670216-25674-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55032 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbaIBPDk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 11:03:40 -0400
In-Reply-To: <1409670216-25674-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch increases the mask in the FLEXCAN_MCR_MAXMB() to 7 bits as in the
newer flexcan cores the MAXMB field is 7 bits wide.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Changes since v1:
- new

 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 6ec49bd..44ba836 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -62,7 +62,7 @@
 #define FLEXCAN_MCR_BCC			BIT(16)
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
-#define FLEXCAN_MCR_MAXMB(x)		((x) & 0x1f)
+#define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
 #define FLEXCAN_MCR_IDAM_A		(0 << 8)
 #define FLEXCAN_MCR_IDAM_B		(1 << 8)
 #define FLEXCAN_MCR_IDAM_C		(2 << 8)
-- 
2.1.0

