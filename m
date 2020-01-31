From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH linux-master 3/3] can: m_can: Remove unused clock function from the framework
Date: Fri, 31 Jan 2020 12:34:33 -0600
Message-ID: <20200131183433.11041-4-dmurphy@ti.com>
References: <20200131183433.11041-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45648 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgAaSiI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2020 13:38:08 -0500
In-Reply-To: <20200131183433.11041-1-dmurphy@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-kernel@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Cc: davem@davemloft.net, Dan Murphy <dmurphy@ti.com>

Remove the unused clock function from the framework as the clock
discovery, initilaization and management are all within the registrars
code.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/m_can.c | 16 ----------------
 drivers/net/can/m_can/m_can.h |  3 ---
 2 files changed, 19 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02c5795b7393..5794be1ef3ef 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1751,22 +1751,6 @@ void m_can_init_ram(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_init_ram);
 
-int m_can_class_get_clocks(struct m_can_classdev *m_can_dev)
-{
-	int ret = 0;
-
-	m_can_dev->hclk = devm_clk_get(m_can_dev->dev, "hclk");
-	m_can_dev->cclk = devm_clk_get(m_can_dev->dev, "cclk");
-
-	if (IS_ERR(m_can_dev->cclk)) {
-		dev_err(m_can_dev->dev, "no clock found\n");
-		ret = -ENODEV;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
-
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev)
 {
 	struct m_can_classdev *class_dev = NULL;
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 49f42b50627a..c20a716b14cc 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -74,8 +74,6 @@ struct m_can_classdev {
 	struct napi_struct napi;
 	struct net_device *net;
 	struct device *dev;
-	struct clk *hclk;
-	struct clk *cclk;
 
 	struct workqueue_struct *tx_wq;
 	struct work_struct tx_work;
@@ -101,7 +99,6 @@ struct m_can_classdev {
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev);
 int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
-int m_can_class_get_clocks(struct m_can_classdev *cdev);
 void m_can_init_ram(struct m_can_classdev *priv);
 void m_can_config_endisable(struct m_can_classdev *priv, bool enable);
 
-- 
2.25.0
