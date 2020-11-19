Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37422C2D0E4
	for <linux-can@archiver.kernel.org>; Thu, 19 Nov 2020 10:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1EE22260
	for <linux-can@archiver.kernel.org>; Thu, 19 Nov 2020 10:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgKSKJW (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 19 Nov 2020 05:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgKSKJV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2020 05:09:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820DCC0613D4
        for <linux-can@vger.kernel.org>; Thu, 19 Nov 2020 02:09:21 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kfgsQ-00063P-Hg; Thu, 19 Nov 2020 11:09:18 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next v2 1/5] can: flexcan: factor out enabling and disabling of interrupts into separate function
Date:   Thu, 19 Nov 2020 11:09:13 +0100
Message-Id: <20201119100917.3013281-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119100917.3013281-1-mkl@pengutronix.de>
References: <20201119100917.3013281-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The upcoming patches are going to move the enabling and disabling of the
interrupts. Introduce convenience functions to make these patches simpler.

Link: https://lore.kernel.org/r/20201119085251.2949181-2-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 06e03ab6f43a..56af58c4179b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1383,6 +1383,31 @@ static void flexcan_ram_init(struct net_device *dev)
 	priv->write(reg_ctrl2, &regs->ctrl2);
 }
 
+static void flexcan_chip_interrupts_enable(const struct net_device *dev)
+{
+	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	u64 reg_imask;
+
+	disable_irq(dev->irq);
+	priv->write(priv->reg_ctrl_default, &regs->ctrl);
+	reg_imask = priv->rx_mask | priv->tx_mask;
+	priv->write(upper_32_bits(reg_imask), &regs->imask2);
+	priv->write(lower_32_bits(reg_imask), &regs->imask1);
+	enable_irq(dev->irq);
+}
+
+static void flexcan_chip_interrupts_disable(const struct net_device *dev)
+{
+	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
+
+	priv->write(0, &regs->imask2);
+	priv->write(0, &regs->imask1);
+	priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
+		    &regs->ctrl);
+}
+
 /* flexcan_chip_start
  *
  * this functions is entered with clocks enabled
@@ -1393,7 +1418,6 @@ static int flexcan_chip_start(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
 	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr;
-	u64 reg_imask;
 	int err, i;
 	struct flexcan_mb __iomem *mb;
 
@@ -1611,13 +1635,7 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	/* enable interrupts atomically */
-	disable_irq(dev->irq);
-	priv->write(priv->reg_ctrl_default, &regs->ctrl);
-	reg_imask = priv->rx_mask | priv->tx_mask;
-	priv->write(upper_32_bits(reg_imask), &regs->imask2);
-	priv->write(lower_32_bits(reg_imask), &regs->imask1);
-	enable_irq(dev->irq);
+	flexcan_chip_interrupts_enable(dev);
 
 	/* print chip status */
 	netdev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
@@ -1637,7 +1655,6 @@ static int flexcan_chip_start(struct net_device *dev)
 static int __flexcan_chip_stop(struct net_device *dev, bool disable_on_error)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->regs;
 	int err;
 
 	/* freeze + disable module */
@@ -1648,11 +1665,7 @@ static int __flexcan_chip_stop(struct net_device *dev, bool disable_on_error)
 	if (err && !disable_on_error)
 		goto out_chip_unfreeze;
 
-	/* Disable all interrupts */
-	priv->write(0, &regs->imask2);
-	priv->write(0, &regs->imask1);
-	priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-		    &regs->ctrl);
+	flexcan_chip_interrupts_disable(dev);
 
 	priv->can.state = CAN_STATE_STOPPED;
 
-- 
2.29.2

