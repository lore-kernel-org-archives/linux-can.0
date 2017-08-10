From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v4 4/4] can: m_can: Add call to of_can_transceiver
Date: Wed, 9 Aug 2017 19:59:16 -0500
Message-ID: <20170810005916.27163-5-fcooper@ti.com>
References: <20170810005916.27163-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:24665 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbdHJBCB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Aug 2017 21:02:01 -0400
In-Reply-To: <20170810005916.27163-1-fcooper@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, quentin.schulz@free-electrons.com, dev.kurt@vandijck-laurijssen.be, andrew@lunn.ch, sergei.shtylyov@cogentembedded.com, socketcan@hartkopp.net
Cc: Franklin S Cooper Jr <fcooper@ti.com>

Add call to new generic functions that provides support via a binding
to limit the arbitration rate and/or data rate imposed by the physical
transceiver connected to the MCAN peripheral.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
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
2.9.4.dirty

