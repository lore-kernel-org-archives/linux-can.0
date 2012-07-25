From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 4/4] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller
Date: Wed, 25 Jul 2012 11:53:37 +0530
Message-ID: <1343197417-27481-5-git-send-email-anilkumar@ti.com>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53851 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932767Ab2GYGYJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 25 Jul 2012 02:24:09 -0400
In-Reply-To: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
APIs control clocks for C_CAN/D_CAN IP and prevent access to the
register of C_CAN/D_CAN IP when clock is turned off.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can_platform.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 2f5b153..f0dc912 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -32,6 +32,7 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/can/dev.h>
 
@@ -176,6 +177,9 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 		goto exit_free_device;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	dev->irq = irq;
 	priv->base = addr;
 	priv->can.clock.freq = clk_get_rate(clk);
@@ -197,6 +201,8 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 
 exit_free_device:
 	platform_set_drvdata(pdev, NULL);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	free_c_can_dev(dev);
 exit_iounmap:
 	iounmap(addr);
@@ -225,6 +231,8 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	clk_put(priv->priv);
 
 	return 0;
-- 
1.7.9.5

