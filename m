From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] can: c_can: checking IS_ERR() instead of NULL
Date: Fri, 1 Aug 2014 11:53:44 +0300
Message-ID: <20140801085344.GA31702@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:29845 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbaHAIyl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 Aug 2014 04:54:41 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, George Cherian <george.cherian@ti.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thor Thayer <tthayer@altera.com>, Pavel Machek <pavel@denx.de>, Mugunthan V N <mugunthanvnm@ti.com>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-can@vger.kernel.org, kernel-janitors@vger.kernel.org

devm_ioremap() returns NULL on error, not an ERR_PTR().

Fixes: 33cf75656923 ('can: c_can_platform: Fix raminit, use devm_ioremap() instead of devm_ioremap_resource()')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This will need to go to -stable because the patch which introduces the
bug is going to be pushed to -stable.

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 5dede6e..109cb44 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -280,7 +280,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 
 		priv->raminit_ctrlreg = devm_ioremap(&pdev->dev, res->start,
 						     resource_size(res));
-		if (IS_ERR(priv->raminit_ctrlreg) || priv->instance < 0)
+		if (!priv->raminit_ctrlreg || priv->instance < 0)
 			dev_info(&pdev->dev, "control memory is not used for raminit\n");
 		else
 			priv->raminit = c_can_hw_raminit_ti;
