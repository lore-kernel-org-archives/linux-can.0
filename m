From: Luu An Phu <phu.luuan@nxp.com>
Subject: [PATCH] flex_can: Correct the checking for frame length in flexcan_start_xmit()
Date: Tue,  2 Jan 2018 10:44:18 +0700
Message-ID: <1514864658-13194-1-git-send-email-phu.luuan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:37887
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751274AbeABDyQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 1 Jan 2018 22:54:16 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, stefan-gabriel.mirea@nxp.com, "phu.luuan" <phu.luuan@nxp.com>

From: "phu.luuan" <phu.luuan@nxp.com>

The flexcan_start_xmit() function compares the frame length with data register
length to write frame content into data[0] and data[1] register. Data register
length is 4 bytes and frame maximum length is 8 bytes.

Fix the check that compares frame length with 3. Because the register length
is 4.

Signed-off-by: Luu An Phu <phu.luuan@nxp.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0626dcf..760d2c0 100644
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
1.9.1

