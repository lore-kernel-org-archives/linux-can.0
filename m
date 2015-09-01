From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 06/12] can: flexcan: use pointer to struct regs instead of void pointer for mmio address space
Date: Tue,  1 Sep 2015 11:29:09 +0200
Message-ID: <1441099755-8601-7-git-send-email-mkl@pengutronix.de>
References: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44515 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333AbbIAJ3T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 05:29:19 -0400
In-Reply-To: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch renames the pointer to the mmio address space from "base" to "regs"
and changes the type from "void __iomem *" to "struct flexcan_regs __iomem *".

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index dd5a9353e0c5..72831c52ff53 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -251,7 +251,7 @@ struct flexcan_priv {
 	struct can_priv can;
 	struct napi_struct napi;
 
-	void __iomem *base;
+	struct flexcan_regs __iomem *regs;
 	u32 reg_esr;
 	u32 reg_ctrl_default;
 
@@ -340,7 +340,7 @@ static inline int flexcan_has_and_handle_berr(const struct flexcan_priv *priv,
 
 static int flexcan_chip_enable(struct flexcan_priv *priv)
 {
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
 
@@ -359,7 +359,7 @@ static int flexcan_chip_enable(struct flexcan_priv *priv)
 
 static int flexcan_chip_disable(struct flexcan_priv *priv)
 {
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
 
@@ -378,7 +378,7 @@ static int flexcan_chip_disable(struct flexcan_priv *priv)
 
 static int flexcan_chip_freeze(struct flexcan_priv *priv)
 {
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	unsigned int timeout = 1000 * 1000 * 10 / priv->can.bittiming.bitrate;
 	u32 reg;
 
@@ -397,7 +397,7 @@ static int flexcan_chip_freeze(struct flexcan_priv *priv)
 
 static int flexcan_chip_unfreeze(struct flexcan_priv *priv)
 {
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
 
@@ -416,7 +416,7 @@ static int flexcan_chip_unfreeze(struct flexcan_priv *priv)
 
 static int flexcan_chip_softreset(struct flexcan_priv *priv)
 {
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
 
 	flexcan_write(FLEXCAN_MCR_SOFTRST, &regs->mcr);
@@ -433,7 +433,7 @@ static int __flexcan_get_berr_counter(const struct net_device *dev,
 				      struct can_berr_counter *bec)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg = flexcan_read(&regs->ecr);
 
 	bec->txerr = (reg >> 0) & 0xff;
@@ -468,7 +468,7 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
 static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 can_id;
 	u32 data;
@@ -628,7 +628,7 @@ static void flexcan_read_fifo(const struct net_device *dev,
 			      struct can_frame *cf)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	struct flexcan_mb __iomem *mb = &regs->cantxfg[0];
 	u32 reg_ctrl, reg_id;
 
@@ -678,7 +678,7 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
 	const struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_iflag1, reg_esr;
 	int work_done = 0;
 
@@ -717,7 +717,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_iflag1, reg_esr;
 
 	reg_iflag1 = flexcan_read(&regs->iflag1);
@@ -773,7 +773,7 @@ static void flexcan_set_bittiming(struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg;
 
 	reg = flexcan_read(&regs->ctrl);
@@ -815,7 +815,7 @@ static void flexcan_set_bittiming(struct net_device *dev)
 static int flexcan_chip_start(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr;
 	int err, i;
 
@@ -960,7 +960,7 @@ static int flexcan_chip_start(struct net_device *dev)
 static void flexcan_chip_stop(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 
 	/* freeze + disable module */
 	flexcan_chip_freeze(priv);
@@ -1069,7 +1069,7 @@ static const struct net_device_ops flexcan_netdev_ops = {
 static int register_flexcandev(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg, err;
 
 	err = clk_prepare_enable(priv->clk_ipg);
@@ -1151,7 +1151,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	struct regulator *reg_xceiver;
 	struct resource *mem;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
-	void __iomem *base;
+	struct flexcan_regs __iomem *regs;
 	int err, irq;
 	u32 clock_freq = 0;
 
@@ -1185,9 +1185,9 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return -ENODEV;
 
-	base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	of_id = of_match_device(flexcan_of_match, &pdev->dev);
 	if (of_id) {
@@ -1215,7 +1215,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_3_SAMPLES |
 		CAN_CTRLMODE_BERR_REPORTING;
-	priv->base = base;
+	priv->regs = regs;
 	priv->clk_ipg = clk_ipg;
 	priv->clk_per = clk_per;
 	priv->pdata = dev_get_platdata(&pdev->dev);
@@ -1236,7 +1236,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	devm_can_led_init(dev);
 
 	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
-		 priv->base, dev->irq);
+		 priv->regs, dev->irq);
 
 	return 0;
 
-- 
2.5.0

