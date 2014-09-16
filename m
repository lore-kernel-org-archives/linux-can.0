From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 5/5] can: flexcan: increase FLEXCAN_MCR_MAXMB() macro to 7 bits
Date: Tue, 16 Sep 2014 16:20:34 +0200
Message-ID: <1410877234-29751-5-git-send-email-mkl@pengutronix.de>
References: <1410877234-29751-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34286 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbaIPOUk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 10:20:40 -0400
In-Reply-To: <1410877234-29751-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch increases the mask in the FLEXCAN_MCR_MAXMB() to 7 bits as in the
newer flexcan cores the MAXMB field is 7 bits wide.

Reported-by: David Jander <david@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index c17ae9e..6586309 100644
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

