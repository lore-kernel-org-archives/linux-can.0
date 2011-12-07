From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 04/14] can: bfin_can/ti_hecc/mscan: add missing do_get_berr_counter callback
Date: Wed,  7 Dec 2011 15:55:18 +0100
Message-ID: <1323269728-17491-5-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49260 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756528Ab1LGOzj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:39 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/bfin_can.c    |   15 +++++++++++++++
 drivers/net/can/mscan/mscan.c |   16 +++++++++++++++-
 drivers/net/can/ti_hecc.c     |   12 ++++++++++++
 3 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
index 9cf4ddb..3f88473 100644
--- a/drivers/net/can/bfin_can.c
+++ b/drivers/net/can/bfin_can.c
@@ -221,6 +221,20 @@ static int bfin_can_set_mode(struct net_device *dev, enum can_mode mode)
 	return 0;
 }
 
+static int bfin_can_get_berr_counter(const struct net_device *dev,
+				     struct can_berr_counter *bec)
+{
+	struct bfin_can_priv *priv = netdev_priv(dev);
+	struct bfin_can_regs __iomem *reg = priv->membase;
+
+	u16 cec = bfin_read(&reg->cec);
+
+	bec->txerr = cec >> 8;
+	bec->rxerr = cec;
+
+	return 0;
+}
+
 static int bfin_can_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bfin_can_priv *priv = netdev_priv(dev);
@@ -505,6 +519,7 @@ struct net_device *alloc_bfin_candev(void)
 	priv->can.bittiming_const = &bfin_can_bittiming_const;
 	priv->can.do_set_bittiming = bfin_can_set_bittiming;
 	priv->can.do_set_mode = bfin_can_set_mode;
+	priv->can.do_get_berr_counter = bfin_can_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
 
 	return dev;
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index ad8e687..41a2a2d 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -559,6 +559,18 @@ static int mscan_do_set_bittiming(struct net_device *dev)
 	return 0;
 }
 
+static int mscan_get_berr_counter(const struct net_device *dev,
+				  struct can_berr_counter *bec)
+{
+	struct mscan_priv *priv = netdev_priv(dev);
+	struct mscan_regs __iomem *regs = priv->reg_base;
+
+	bec->txerr = in_8(&regs->cantxerr);
+	bec->rxerr = in_8(&regs->canrxerr);
+
+	return 0;
+}
+
 static int mscan_open(struct net_device *dev)
 {
 	int ret;
@@ -638,8 +650,10 @@ int register_mscandev(struct net_device *dev, int mscan_clksrc)
 	else
 		ctl1 &= ~MSCAN_CLKSRC;
 
-	if (priv->type == MSCAN_TYPE_MPC5121)
+	if (priv->type == MSCAN_TYPE_MPC5121) {
+		priv->can.do_get_berr_counter = mscan_get_berr_counter;
 		ctl1 |= MSCAN_BORM; /* bus-off recovery upon request */
+	}
 
 	ctl1 |= MSCAN_CANE;
 	out_8(&regs->canctl1, ctl1);
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index d50e5e0..ebaee3c 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -458,6 +458,17 @@ static int ti_hecc_do_set_mode(struct net_device *ndev, enum can_mode mode)
 	return ret;
 }
 
+static int ti_hecc_get_berr_counter(const struct net_device *dev,
+					struct can_berr_counter *bec)
+{
+	struct ti_hecc_priv *priv = netdev_priv(ndev);
+
+	bec->txerr = hecc_read(priv, HECC_CANTEC);
+	bec->rxerr = hecc_read(priv, HECC_CANREC);
+
+	return 0;
+}
+
 /*
  * ti_hecc_xmit: HECC Transmit
  *
@@ -922,6 +933,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	priv->can.bittiming_const = &ti_hecc_bittiming_const;
 	priv->can.do_set_mode = ti_hecc_do_set_mode;
 	priv->can.do_get_state = ti_hecc_get_state;
+	priv->can.do_get_berr_counter = ti_hecc_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
 
 	spin_lock_init(&priv->mbx_lock);
-- 
1.7.4.1

