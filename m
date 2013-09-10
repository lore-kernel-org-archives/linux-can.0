From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/9] can: cc770: use dev_get_platdata()
Date: Tue, 10 Sep 2013 17:41:07 +0900
Message-ID: <004a01ceae01$7dfebd50$79fc37f0$%han@samsung.com>
References: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32505 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab3IJIlI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 04:41:08 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW009YMISCPI40@mailout1.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 17:41:07 +0900 (KST)
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
 drivers/net/can/cc770/cc770_platform.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index 034bdd8..ad76734 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -152,7 +152,7 @@ static int cc770_get_platform_data(struct platform_device *pdev,
 				   struct cc770_priv *priv)
 {
 
-	struct cc770_platform_data *pdata = pdev->dev.platform_data;
+	struct cc770_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	priv->can.clock.freq = pdata->osc_freq;
 	if (priv->cpu_interface & CPUIF_DSC)
@@ -203,7 +203,7 @@ static int cc770_platform_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node)
 		err = cc770_get_of_node_data(pdev, priv);
-	else if (pdev->dev.platform_data)
+	else if (dev_get_platdata(&pdev->dev))
 		err = cc770_get_platform_data(pdev, priv);
 	else
 		err = -ENODEV;
-- 
1.7.10.4


