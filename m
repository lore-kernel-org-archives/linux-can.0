From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 2/3] can: m_can: m_can_platform: Add support for enabling transceiver through the STB line
Date: Wed, 22 Jan 2020 13:33:09 +0530
Message-ID: <20200122080310.24653-3-faiz_abbas@ti.com>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44008 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgAVICK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Jan 2020 03:02:10 -0500
In-Reply-To: <20200122080310.24653-1-faiz_abbas@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, robh+dt@kernel.org, davem@davemloft.net, mkl@pengutronix.de, wg@grandegger.com, sriram.dash@samsung.com, dmurphy@ti.com, faiz_abbas@ti.com, nm@ti.com, t-kristo@ti.com

CAN transceivers on some boards have an STB (standby) line which can be
toggled to enable/disable the transceiver. Add support for enabling the
transceiver using a GPIO connected to the STB line.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can_platform.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 38ea5e600fb8..b4e1423bd5d8 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -6,6 +6,7 @@
 // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
 
 #include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
 
 #include "m_can.h"
 
@@ -57,6 +58,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 {
 	struct m_can_classdev *mcan_class;
 	struct m_can_plat_priv *priv;
+	struct gpio_desc *stb;
 	struct resource *res;
 	void __iomem *addr;
 	void __iomem *mram_addr;
@@ -111,6 +113,16 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	m_can_init_ram(mcan_class);
 
+	stb = devm_gpiod_get_optional(&pdev->dev, "stb", GPIOD_OUT_HIGH);
+	if (IS_ERR(stb)) {
+		ret = PTR_ERR(stb);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"gpio request failed, ret %d\n", ret);
+
+		goto failed_ret;
+	}
+
 	ret = m_can_class_register(mcan_class);
 
 failed_ret:
-- 
2.19.2
