From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/9] can: bfin_can: use dev_get_platdata()
Date: Tue, 10 Sep 2013 17:40:42 +0900
Message-ID: <004901ceae01$6f1d3af0$4d57b0d0$%han@samsung.com>
References: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32400 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab3IJIko (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 04:40:44 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW00873IRUSN50@mailout1.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 17:40:42 +0900 (KST)
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
 drivers/net/can/bfin_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
index a2700d2..8a0b515 100644
--- a/drivers/net/can/bfin_can.c
+++ b/drivers/net/can/bfin_can.c
@@ -539,7 +539,7 @@ static int bfin_can_probe(struct platform_device *pdev)
 	struct resource *res_mem, *rx_irq, *tx_irq, *err_irq;
 	unsigned short *pdata;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
 		dev_err(&pdev->dev, "No platform data provided!\n");
 		err = -EINVAL;
-- 
1.7.10.4


