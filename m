From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] can: m_can: Propagate the real error code
Date: Wed, 21 Jun 2017 12:42:32 -0300
Message-ID: <1498059752-15463-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com ([104.47.33.80]:26016
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751082AbdFUQ0z (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 21 Jun 2017 12:26:55 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, festevam@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>

Instead of propagating '-EINVAL' when devm_ioremap_resource() or
platform_get_irq_byname() fails, it is better to propagate the 
real error code instead.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/net/can/m_can/m_can.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f4947a7..5768070 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1587,10 +1587,14 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
 	addr = devm_ioremap_resource(&pdev->dev, res);
-	irq = platform_get_irq_byname(pdev, "int0");
+	if (IS_ERR(addr)) {
+		ret = PTR_ERR(addr);
+		goto disable_cclk_ret;
+	}
 
-	if (IS_ERR(addr) || irq < 0) {
-		ret = -EINVAL;
+	irq = platform_get_irq_byname(pdev, "int0");
+	if (irq < 0) {
+		ret = irq;
 		goto disable_cclk_ret;
 	}
 
-- 
2.7.4

