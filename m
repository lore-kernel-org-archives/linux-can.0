From: =?UTF-8?q?Mario=20H=C3=BCttel?= <mario.huettel@gmx.net>
Subject: [PATCH v4 3/7] can: m_can: Removed virtual address from print
Date: Sat,  8 Apr 2017 14:10:11 +0200
Message-ID: <20170408121015.11428-3-mario.huettel@gmx.net>
References: <20170408121015.11428-1-mario.huettel@gmx.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:59387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751922AbdDHMKa (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 8 Apr 2017 08:10:30 -0400
In-Reply-To: <20170408121015.11428-1-mario.huettel@gmx.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Mario Huettel <mario.huettel@gmx.net>

From: Mario Huettel <mario.huettel@gmx.net>

The virtual address of the device was printed. I removed it
because it leaks internal information.

Signed-off-by: Mario Huettel <mario.huettel@gmx.net>
---
 drivers/net/can/m_can/m_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ddcbe8b..a966ed5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1231,8 +1231,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	devm_can_led_init(dev);
 
-	dev_info(&pdev->dev, "%s device registered (regs=%p, irq=%d)\n",
-		 KBUILD_MODNAME, priv->base, dev->irq);
+	dev_info(&pdev->dev, "%s device registered (irq=%d)\n",
+		 KBUILD_MODNAME, dev->irq);
 
 	return 0;
 
-- 
1.9.1

