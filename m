From: David Jander <david@protonic.nl>
Subject: [PATCH 03/15] can: flexcan: replace open coded mailbox code by proper defines
Date: Fri, 10 Oct 2014 17:46:48 +0200
Message-ID: <1412956020-21489-4-git-send-email-david@protonic.nl>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18366 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbaJJPrA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:00 -0400
In-Reply-To: <1412956020-21489-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

From: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index b287367..20f5c0e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -158,7 +158,6 @@
 	 FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID))
 
 /* FLEXCAN message buffers */
-#define FLEXCAN_MB_CNT_CODE(x)		(((x) & 0xf) << 24)
 #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
 #define FLEXCAN_MB_CODE_RX_EMPTY	(0x4 << 24)
 #define FLEXCAN_MB_CODE_RX_FULL		(0x2 << 24)
@@ -479,7 +478,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 can_id;
-	u32 ctrl = FLEXCAN_MB_CNT_CODE(0xc) | (cf->can_dlc << 16);
+	u32 ctrl = FLEXCAN_MB_CODE_TX_DATA | (cf->can_dlc << 16);
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
-- 
1.9.1

