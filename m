From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/9] can: at91_can: use dev_get_platdata()
Date: Tue, 10 Sep 2013 17:40:09 +0900
Message-ID: <004801ceae01$5b9c18c0$12d44a40$%han@samsung.com>
References: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:28634 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab3IJIkL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 04:40:11 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW00E4VIQI4SU0@mailout2.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 17:40:09 +0900 (KST)
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
 drivers/net/can/at91_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 3b1ff61..64f2efa 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1347,7 +1347,7 @@ static int at91_can_probe(struct platform_device *pdev)
 	priv->reg_base = addr;
 	priv->devtype_data = *devtype_data;
 	priv->clk = clk;
-	priv->pdata = pdev->dev.platform_data;
+	priv->pdata = dev_get_platdata(&pdev->dev);
 	priv->mb0_id = 0x7ff;
 
 	netif_napi_add(dev, &priv->napi, at91_poll, get_mb_rx_num(priv));
-- 
1.7.10.4


