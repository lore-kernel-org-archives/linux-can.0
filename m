From: Markus Marb <markus@marb.org>
Subject: [PATCH] can: ifi: use correct register to read rx status
Date: Fri, 17 Mar 2017 23:14:47 +0100
Message-ID: <1489788887-6919-1-git-send-email-markus@marb.org>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:33465 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdCQWpO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Mar 2017 18:45:14 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, Markus Marb <markus@marb.org>

The incorrect offset was used when trying to read the RXSTCMD register.

Signed-off-by: Markus Marb <markus@marb.org>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 138f5ae..4d1fe8d 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -557,7 +557,7 @@ static int ifi_canfd_poll(struct napi_struct *napi, int quota)
 	int work_done = 0;
 
 	u32 stcmd = readl(priv->base + IFI_CANFD_STCMD);
-	u32 rxstcmd = readl(priv->base + IFI_CANFD_STCMD);
+	u32 rxstcmd = readl(priv->base + IFI_CANFD_RXSTCMD);
 	u32 errctr = readl(priv->base + IFI_CANFD_ERROR_CTR);
 
 	/* Handle bus state changes */
-- 
2.7.4

