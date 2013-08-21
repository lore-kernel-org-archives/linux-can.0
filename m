From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH next] drivers: net: can: c_can: add type cast from 'unsigned
 int' to 'int'
Date: Wed, 21 Aug 2013 17:09:33 +0800
Message-ID: <521483CD.8050907@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:47791 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab3HUJKt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2013 05:10:49 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, anilkumar@ti.com, Tony Lindgren <tony@atomide.com>, jg1.han@samsung.com
Cc: David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>

'priv->instance' may less than zero, so need a type cast, the related
warnings (allmodconfig, "EXTRA_CFLAGS=-W"):

  drivers/net/can/c_can/c_can_platform.c:198:3: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/net/can/c_can/c_can_platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index c6f838d..294ced3 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -195,7 +195,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		priv->raminit_ctrlreg = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(priv->raminit_ctrlreg) || priv->instance < 0)
+		if (IS_ERR(priv->raminit_ctrlreg) || (int)priv->instance < 0)
 			dev_info(&pdev->dev, "control memory is not used for raminit\n");
 		else
 			priv->raminit = c_can_hw_raminit;
-- 
1.7.7.6
