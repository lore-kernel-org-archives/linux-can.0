From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/4] can: ifi: Fix transmitter delay calculation
Date: Fri, 10 Nov 2017 14:07:30 +0100
Message-ID: <20171110130730.6662-5-mkl@pengutronix.de>
References: <20171110130730.6662-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56845 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752943AbdKJNHl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Nov 2017 08:07:41 -0500
In-Reply-To: <20171110130730.6662-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marek Vasut <marex@denx.de>, Markus Marb <markus@marb.org>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Marek Vasut <marex@denx.de>

The CANFD transmitter delay calculation formula was updated in the
latest software drop from IFI and improves the behavior of the IFI
CANFD core during bitrate switching. Use the new formula to improve
stability of the CANFD operation.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Markus Marb <markus@marb.org>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 4d1fe8d95042..2772d05ff11c 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -670,9 +670,9 @@ static void ifi_canfd_set_bittiming(struct net_device *ndev)
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
2.15.0

