From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/7] can: flexcan: add berr_limit support
Date: Mon,  7 Oct 2013 16:40:40 +0200
Message-ID: <1381156840-24071-8-git-send-email-mkl@pengutronix.de>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33018 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab3JGOkr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:40:47 -0400
In-Reply-To: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds berr_limit support to the flexcan driver.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index df010d6..0a4a7a2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -301,6 +301,14 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
 	return 0;
 }
 
+static void flexcan_berr_restart(const struct net_device *dev)
+{
+	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->base;
+
+	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
+}
+
 static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
@@ -594,7 +602,7 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 		napi_complete(napi);
 		/* enable IRQs */
 		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
+		can_berr_limit(dev);
 	}
 
 	return work_done;
@@ -1055,6 +1063,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->can.bittiming_const = &flexcan_bittiming_const;
 	priv->can.do_set_mode = flexcan_set_mode;
 	priv->can.do_get_berr_counter = flexcan_get_berr_counter;
+	priv->can.do_berr_restart = flexcan_berr_restart;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_3_SAMPLES |
 		CAN_CTRLMODE_BERR_REPORTING;
-- 
1.8.4.rc3

