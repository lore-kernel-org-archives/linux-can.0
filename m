From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/4] can: flex_can: Correct the checking for frame length in flexcan_start_xmit()
Date: Thu,  4 Jan 2018 16:33:54 +0100
Message-ID: <20180104153355.11243-4-mkl@pengutronix.de>
References: <20180104153355.11243-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50035 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753311AbeADPeO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Jan 2018 10:34:14 -0500
In-Reply-To: <20180104153355.11243-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Luu An Phu <phu.luuan@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Luu An Phu <phu.luuan@nxp.com>

The flexcan_start_xmit() function compares the frame length with data
register length to write frame content into data[0] and data[1]
register. Data register length is 4 bytes and frame maximum length is 8
bytes.

Fix the check that compares frame length with 3. Because the register
length is 4.

Signed-off-by: Luu An Phu <phu.luuan@nxp.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0626dcfd1f3d..760d2c07e3a2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -526,7 +526,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		data = be32_to_cpup((__be32 *)&cf->data[0]);
 		flexcan_write(data, &priv->tx_mb->data[0]);
 	}
-	if (cf->can_dlc > 3) {
+	if (cf->can_dlc > 4) {
 		data = be32_to_cpup((__be32 *)&cf->data[4]);
 		flexcan_write(data, &priv->tx_mb->data[1]);
 	}
-- 
2.15.1

