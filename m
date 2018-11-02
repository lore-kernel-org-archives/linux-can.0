From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 6/6] can: m_can: Add support for transceiver as phy
Date: Sat, 3 Nov 2018 00:56:16 +0530
Message-ID: <20181102192616.28291-7-faiz_abbas@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102192616.28291-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com, faiz_abbas@ti.com
List-Id: linux-can.vger.kernel.org

Add support for implementing the transceiver device as a phy. Instead
of a child node, the max_bitrate information is obtained by getting a
phy attribute. Fallback to the legacy API if no phy node is found.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9b449400376b..ed6d84acea20 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
 #include <linux/can/dev.h>
+#include <linux/phy/phy.h>
 #include <linux/pinctrl/consumer.h>
 
 /* napi related */
@@ -1582,6 +1583,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	struct device_node *np;
 	u32 mram_config_vals[MRAM_CFG_LEN];
 	u32 tx_fifo_size;
+	struct phy *transceiver;
 
 	np = pdev->dev.of_node;
 
@@ -1671,7 +1673,26 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	devm_can_led_init(dev);
 
-	of_can_transceiver(dev);
+	transceiver = devm_phy_optional_get(&pdev->dev, "can_transceiver");
+	if (IS_ERR(transceiver)) {
+		ret = PTR_ERR(transceiver);
+		dev_err(&pdev->dev, "Couldn't get phy. err=%d\n", ret);
+		return ret;
+	}
+
+	if (!transceiver) {
+		dev_warn(&pdev->dev, "No transceiver phy. Falling back to legacy API\n");
+		of_can_transceiver(dev);
+	} else {
+		ret = phy_power_on(transceiver);
+		if (ret) {
+			dev_err(&pdev->dev, "phy_power_on err:%d\n", ret);
+			return ret;
+		}
+		priv->can.bitrate_max = phy_get_max_bitrate(transceiver);
+		if (!priv->can.bitrate_max)
+			dev_warn(&pdev->dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
+	}
 
 	dev_info(&pdev->dev, "%s device registered (irq=%d, version=%d)\n",
 		 KBUILD_MODNAME, dev->irq, priv->version);
-- 
2.18.0
