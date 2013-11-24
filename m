From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: c_can: don't call pm_runtime_get_sync() from IRQ handler
Date: Sun, 24 Nov 2013 23:53:37 +0100
Message-ID: <1385333617-30842-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40291 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab3KXWxm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Nov 2013 17:53:42 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Andrew Glen <AGlen@bepmarine.com>, Marc Kleine-Budde <mkl@pengutronix.de>

The c_can driver contians a callpath (c_can_poll -> c_can_state_change ->
c_can_get_berr_counter) which may call pm_runtime_get_sync() from the IRQ
handler, which is not allowed.

This problem is fixed by introducing __c_can_get_berr_counter, which will not
call pm_runtime_get_sync().

Reported-by: Andrew Glen <AGlen@bepmarine.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Andrew,

can you please test this patch if it solves your problem?

Marc

 drivers/net/can/c_can/c_can.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index e3fc07c..0a5718e 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -712,22 +712,30 @@ static int c_can_set_mode(struct net_device *dev, enum can_mode mode)
 	return 0;
 }
 
-static int c_can_get_berr_counter(const struct net_device *dev,
-					struct can_berr_counter *bec)
+static int __c_can_get_berr_counter(const struct net_device *dev,
+				    struct can_berr_counter *bec)
 {
 	unsigned int reg_err_counter;
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	c_can_pm_runtime_get_sync(priv);
-
 	reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
 	bec->rxerr = (reg_err_counter & ERR_CNT_REC_MASK) >>
 				ERR_CNT_REC_SHIFT;
 	bec->txerr = reg_err_counter & ERR_CNT_TEC_MASK;
 
+	return 0;
+}
+
+static int c_can_get_berr_counter(const struct net_device *dev,
+					struct can_berr_counter *bec)
+{
+	int err;
+
+	c_can_pm_runtime_get_sync(priv);
+	err = __c_can_get_berr_counter(dev, bec)
 	c_can_pm_runtime_put_sync(priv);
 
-	return 0;
+	return err;
 }
 
 /*
@@ -872,7 +880,7 @@ static int c_can_handle_state_change(struct net_device *dev,
 	if (unlikely(!skb))
 		return 0;
 
-	c_can_get_berr_counter(dev, &bec);
+	__c_can_get_berr_counter(dev, &bec);
 	reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
 	rx_err_passive = (reg_err_counter & ERR_CNT_RP_MASK) >>
 				ERR_CNT_RP_SHIFT;
-- 
1.8.5.rc0

