From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 2/3] can: m_can: m_can_platform: Add support for enabling transceiver
Date: Mon, 17 Feb 2020 19:58:35 +0530
Message-ID: <20200217142836.23702-3-faiz_abbas@ti.com>
References: <20200217142836.23702-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200217142836.23702-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, robh+dt@kernel.org, mkl@pengutronix.de, wg@grandegger.com, sriram.dash@samsung.com, dmurphy@ti.com, faiz_abbas@ti.com
List-Id: linux-can.vger.kernel.org

CAN transceivers on some boards have a standby line which can be
toggled to enable/disable the transceiver. Model this as an optional
fixed xceiver regulator.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Sriram Dash <sriram.dash@samsung.com>
---
 drivers/net/can/m_can/m_can_platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 38ea5e600fb8..719468fab507 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -6,6 +6,7 @@
 // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
 
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #include "m_can.h"
 
@@ -57,6 +58,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 {
 	struct m_can_classdev *mcan_class;
 	struct m_can_plat_priv *priv;
+	struct regulator *reg_xceiver;
 	struct resource *res;
 	void __iomem *addr;
 	void __iomem *mram_addr;
@@ -111,6 +113,10 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	m_can_init_ram(mcan_class);
 
+	reg_xceiver = devm_regulator_get_optional(&pdev->dev, "xceiver");
+	if (PTR_ERR(reg_xceiver) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	ret = m_can_class_register(mcan_class);
 
 failed_ret:
-- 
2.19.2
