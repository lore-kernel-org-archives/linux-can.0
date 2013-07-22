From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2 2/2] flexcan: Check the return value from clk_prepare_enable()
Date: Mon, 22 Jul 2013 12:41:40 -0300
Message-ID: <1374507700-21575-2-git-send-email-fabio.estevam@freescale.com>
References: <1374507700-21575-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:23272 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756220Ab3GVPly (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Jul 2013 11:41:54 -0400
In-Reply-To: <1374507700-21575-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, festevam@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Newly introduced in this version

 drivers/net/can/flexcan.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index da24ca5..03b93fa 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -850,8 +850,13 @@ static int flexcan_open(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	clk_prepare_enable(priv->clk_ipg);
-	clk_prepare_enable(priv->clk_per);
+	err = clk_prepare_enable(priv->clk_ipg);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(priv->clk_per);
+	if (err)
+		goto out_clk_per;
 
 	err = open_candev(dev);
 	if (err)
@@ -877,6 +882,7 @@ static int flexcan_open(struct net_device *dev)
 	close_candev(dev);
  out:
 	clk_disable_unprepare(priv->clk_per);
+out_clk_per:
 	clk_disable_unprepare(priv->clk_ipg);
 
 	return err;
@@ -933,8 +939,13 @@ static int register_flexcandev(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	u32 reg, err;
 
-	clk_prepare_enable(priv->clk_ipg);
-	clk_prepare_enable(priv->clk_per);
+	err = clk_prepare_enable(priv->clk_ipg);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(priv->clk_per);
+	if (err)
+		goto out_clk_per;
 
 	/* select "bus clock", chip must be disabled */
 	flexcan_chip_disable(priv);
@@ -968,6 +979,7 @@ static int register_flexcandev(struct net_device *dev)
 	/* disable core and turn off clocks */
 	flexcan_chip_disable(priv);
 	clk_disable_unprepare(priv->clk_per);
+out_clk_per:
 	clk_disable_unprepare(priv->clk_ipg);
 
 	return err;
-- 
1.8.1.2


