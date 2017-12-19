From: Luu An Phu <phu.luuan@nxp.com>
Subject: [PATCH] flex_can: Fix checking can_dlc
Date: Tue, 19 Dec 2017 15:40:33 +0700
Message-ID: <1513672833-28402-1-git-send-email-phu.luuan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:25824
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936960AbdLSIuc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 19 Dec 2017 03:50:32 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, stefan-gabriel.mirea@nxp.com, "phu.luuan" <phu.luuan@nxp.com>

From: "phu.luuan" <phu.luuan@nxp.com>

flexcan_start_xmit should write data to register when can_dlc > 4.
Because can_dlc is data length and it has value from 1 to 8. But CAN data
index has value from 0 to 7. So in case we have data in cf->data[4],
the can_dlc has value is more than 4.

Signed-off-by: Luu An Phu <phu.luuan@nxp.com>
---
 drivers/net/can/flexcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0626dcf..0e3ff13 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2009 Sascha Hauer, Pengutronix
  * Copyright (c) 2010-2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
  * Copyright (c) 2014 David Jander, Protonic Holland
+ * Copyright 2017 NXP
  *
  * Based on code originally by Andrey Volkov <avolkov@varma-el.com>
  *
@@ -526,7 +527,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		data = be32_to_cpup((__be32 *)&cf->data[0]);
 		flexcan_write(data, &priv->tx_mb->data[0]);
 	}
-	if (cf->can_dlc > 3) {
+	if (cf->can_dlc > 4) {
 		data = be32_to_cpup((__be32 *)&cf->data[4]);
 		flexcan_write(data, &priv->tx_mb->data[1]);
 	}
-- 
1.9.1

