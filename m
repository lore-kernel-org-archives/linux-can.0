From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 4/9] can: flexcan: use dev_get_platdata()
Date: Tue, 10 Sep 2013 17:41:30 +0900
Message-ID: <004b01ceae01$8bf76650$a3e632f0$%han@samsung.com>
References: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33609 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab3IJIlb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 04:41:31 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW009VOIT6NZR0@mailout4.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 17:41:30 +0900 (KST)
In-reply-to: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Content-language: ko
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: 'Wolfgang Grandegger' <wg@grandegger.com>, linux-can@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/net/can/flexcan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 71c677e..e8c46bd 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1074,7 +1074,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	priv->clk_ipg = clk_ipg;
 	priv->clk_per = clk_per;
-	priv->pdata = pdev->dev.platform_data;
+	priv->pdata = dev_get_platdata(&pdev->dev);
 	priv->devtype_data = devtype_data;
 
 	priv->reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
-- 
1.7.10.4


