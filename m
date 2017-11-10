From: Marek Vasut <marex@denx.de>
Subject: [PATCH] can: ifi: Fix transmitter delay calculation
Date: Fri, 10 Nov 2017 11:22:39 +0100
Message-ID: <20171110102239.6864-1-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:50989 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbdKJKWq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Nov 2017 05:22:46 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Markus Marb <markus@marb.org>, Marc Kleine-Budde <mkl@pengutronix.de>

The CANFD transmitter delay calculation formula was updated in the
latest software drop from IFI and improves the behavior of the IFI
CANFD core during bitrate switching. Use the new formula to improve
stability of the CANFD operation.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Markus Marb <markus@marb.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 0e22599dfe4a..6c37f5d4fe7e 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -671,9 +671,9 @@ static void ifi_canfd_set_bittiming(struct net_device *ndev)
 	       priv->base + IFI_CANFD_FTIME);
 
 	/* Configure transmitter delay */
-	tdc = (dbt->brp * (dbt->phase_seg1 + 1)) & IFI_CANFD_TDELAY_MASK;
-	writel(IFI_CANFD_TDELAY_EN | IFI_CANFD_TDELAY_ABS | tdc,
-	       priv->base + IFI_CANFD_TDELAY);
+	tdc = dbt->brp * (dbt->prop_seg + dbt->phase_seg1);
+	tdc &= IFI_CANFD_TDELAY_MASK;
+	writel(IFI_CANFD_TDELAY_EN | tdc, priv->base + IFI_CANFD_TDELAY);
 }
 
 static void ifi_canfd_set_filter(struct net_device *ndev, const u32 id,
-- 
2.11.0

