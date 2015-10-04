From: Anton Glukhov <anton.a.glukhov@gmail.com>
Subject: [PATCH 1/3] can: ti_hecc: Add DT support for TI HECC module
Date: Sun,  4 Oct 2015 22:59:37 +0300
Message-ID: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34177 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbbJDUAs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 4 Oct 2015 16:00:48 -0400
Received: by lbbwt4 with SMTP id wt4so10312603lbb.1
        for <linux-can@vger.kernel.org>; Sun, 04 Oct 2015 13:00:46 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, linux-can@vger.kernel.org, bcousson@baylibre.com
Cc: Anton Glukhov <anton.a.glukhov@gmail.com>

These patch set adds device tree support for TI HECC module.

Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
---
 drivers/net/can/ti_hecc.c | 56 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index cf345cb..c1a89fd 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -46,6 +46,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
@@ -875,19 +877,64 @@ static const struct net_device_ops ti_hecc_netdev_ops = {
 	.ndo_change_mtu		= can_change_mtu,
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id ti_hecc_dt_ids[] = {
+	{
+		.compatible = "ti,am35x-hecc",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_hecc_dt_ids);
+#endif
+
+static struct ti_hecc_platform_data *hecc_parse_dt(struct device *dev)
+{
+	struct ti_hecc_platform_data *pdata;
+	struct device_node *np = dev->of_node;
+
+	pdata = devm_kzalloc(dev, sizeof(struct ti_hecc_platform_data), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	if (of_property_read_u32(np, "ti,scc-ram-offset", &pdata->scc_ram_offset)) {
+		dev_err(dev, "Missing scc-ram-offset property in the DT.\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32(np, "ti,hecc-ram-offset", &pdata->hecc_ram_offset)) {
+		dev_err(dev, "Missing hecc-ram-offset property in the DT.\n");
+		return ERR_PTR(-EINVAL);
+	}
+	if (of_property_read_u32(np, "ti,mbx-offset", &pdata->mbx_offset)) {
+		dev_err(dev, "Missing mbx-offset property in the DT.\n");
+		return ERR_PTR(-EINVAL);
+	}
+	if (of_property_read_u32(dev->of_node, "ti,int-line", &pdata->int_line)) {
+		pdata->int_line = 0;
+	}
+
+	return pdata;
+}
+
 static int ti_hecc_probe(struct platform_device *pdev)
 {
 	struct net_device *ndev = (struct net_device *)0;
 	struct ti_hecc_priv *priv;
-	struct ti_hecc_platform_data *pdata;
+	struct ti_hecc_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 	struct resource *mem, *irq;
 	void __iomem *addr;
 	int err = -ENODEV;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	if (!pdata && np) {
+		pdata = hecc_parse_dt(&pdev->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
+
 	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data\n");
-		goto probe_exit;
+		dev_err(&pdev->dev, "Platform data missing\n");
+		return -EINVAL;
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1040,6 +1087,7 @@ static int ti_hecc_resume(struct platform_device *pdev)
 static struct platform_driver ti_hecc_driver = {
 	.driver = {
 		.name    = DRV_NAME,
+		.of_match_table = ti_hecc_dt_ids,
 	},
 	.probe = ti_hecc_probe,
 	.remove = ti_hecc_remove,
-- 
1.9.1

