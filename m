From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 8/9] can: softing: use dev_get_platdata()
Date: Tue, 10 Sep 2013 17:42:53 +0900
Message-ID: <004f01ceae01$bd79f5d0$386de170$%han@samsung.com>
References: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32926 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab3IJImy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 04:42:54 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW0099ZIVA3F50@mailout1.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 17:42:53 +0900 (KST)
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
 drivers/net/can/softing/softing_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 65eef1e..6cd5c01 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -768,7 +768,7 @@ static int softing_pdev_remove(struct platform_device *pdev)
 
 static int softing_pdev_probe(struct platform_device *pdev)
 {
-	const struct softing_platform_data *pdat = pdev->dev.platform_data;
+	const struct softing_platform_data *pdat = dev_get_platdata(&pdev->dev);
 	struct softing *card;
 	struct net_device *netdev;
 	struct softing_priv *priv;
-- 
1.7.10.4


