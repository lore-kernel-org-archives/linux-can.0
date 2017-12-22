From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v6 2/6] can: m_can: Add call to of_can_transceiver
Date: Fri, 22 Dec 2017 19:01:24 +0530
Message-ID: <1513949488-13026-3-git-send-email-faiz_abbas@ti.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com
List-Id: linux-can.vger.kernel.org

From: Franklin S Cooper Jr <fcooper@ti.com>

Add call to new generic functions that provides support via a binding
to limit the arbitration rate and/or data rate imposed by the physical
transceiver connected to the MCAN peripheral.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f4947a7..f72116e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1649,6 +1649,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	devm_can_led_init(dev);
 
+	of_can_transceiver(dev);
+
 	dev_info(&pdev->dev, "%s device registered (irq=%d, version=%d)\n",
 		 KBUILD_MODNAME, dev->irq, priv->version);
 
-- 
2.7.4
