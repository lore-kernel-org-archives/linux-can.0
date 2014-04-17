From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] net: can: c_can: use proper type for 'instance'
Date: Thu, 17 Apr 2014 10:57:18 +0200
Message-ID: <1397725047-7833-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:39716 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbaDQI5n (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 17 Apr 2014 04:57:43 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Chen Gang <gang.chen@asianux.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Wolfram Sang <wsa@sang-engineering.com>

Commit 6439fbce1075 (can: c_can: fix error checking of priv->instance in
probe()) found the warning but applied a suboptimal solution. Since, both
pdev->id and of_alias_get_id() return integers, it makes sense to convert the
variable to an integer and avoid the cast.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---

@chen: casts are rarely the correct solution. Please always investigate further
before applying them

 drivers/net/can/c_can/c_can.h          | 2 +-
 drivers/net/can/c_can/c_can_platform.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index faa8404162b3..308601c6c0d7 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -198,7 +198,7 @@ struct c_can_priv {
 	u16 irqstatus;
 	enum c_can_dev_id type;
 	u32 __iomem *raminit_ctrlreg;
-	unsigned int instance;
+	int instance;
 	void (*raminit) (const struct c_can_priv *priv, bool enable);
 	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
 };
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 806d92753427..1df0b322d1e4 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -222,7 +222,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		priv->raminit_ctrlreg = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(priv->raminit_ctrlreg) || (int)priv->instance < 0)
+		if (IS_ERR(priv->raminit_ctrlreg) || priv->instance < 0)
 			dev_info(&pdev->dev, "control memory is not used for raminit\n");
 		else
 			priv->raminit = c_can_hw_raminit;
-- 
1.9.1

