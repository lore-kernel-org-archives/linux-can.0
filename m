From: "Glen, Andrew" <AGlen@bepmarine.com>
Subject: [PATCH v2] can: c_can: don't call pm_runtime_get_sync() from IRQ
 handler
Date: Mon, 25 Nov 2013 20:34:33 +0000
Message-ID: <2A43324E02E34840B044C9DC92214480090568F0@AMDTCEX12.actuant.pri>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.106]:43277 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750879Ab3KYUeh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 25 Nov 2013 15:34:37 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: <mkl@pengutronix.de>

The c_can driver contains a callpath (c_can_poll -> c_can_state_change ->
c_can_get_berr_counter) which may call pm_runtime_get_sync() from the IRQ handler, which is not allowed.

This problem is fixed by introducing __c_can_get_berr_counter, which will not call pm_runtime_get_sync().

Reported-by: Andrew Glen <AGlen@bepmarine.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Andrew Glen <AGlen@bepmarine.com>
Tested-by: Andrew Glen <AGlen@bepmarine.com>
---
Changes since v1: Fixed missing semi-colon and missing call to 'struct c_can_priv *priv = netdev_priv(dev);' in ' c_can_get_berr_counter()'

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index a668cd4..a58ea45 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -712,22 +712,32 @@ static int c_can_set_mode(struct net_device *dev, enum can_mode mode)
        return 0;
 }

-static int c_can_get_berr_counter(const struct net_device *dev,
+static int __c_can_get_berr_counter(const struct net_device *dev,
                                        struct can_berr_counter *bec)
 {
        unsigned int reg_err_counter;
        struct c_can_priv *priv = netdev_priv(dev);

-       c_can_pm_runtime_get_sync(priv);
-
        reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
        bec->rxerr = (reg_err_counter & ERR_CNT_REC_MASK) >>
                                ERR_CNT_REC_SHIFT;
        bec->txerr = reg_err_counter & ERR_CNT_TEC_MASK;

+       return 0;
+
+}
+
+static int c_can_get_berr_counter(const struct net_device *dev,
+                                       struct can_berr_counter *bec)
+{
+       int err;
+       struct c_can_priv *priv = netdev_priv(dev);
+
+       c_can_pm_runtime_get_sync(priv);
+       err = __c_can_get_berr_counter(dev, bec);
        c_can_pm_runtime_put_sync(priv);

-       return 0;
+       return err;
 }

 /*
@@ -872,7 +882,7 @@ static int c_can_handle_state_change(struct net_device *dev,
        if (unlikely(!skb))
                return 0;

-       c_can_get_berr_counter(dev, &bec);
+       __c_can_get_berr_counter(dev, &bec);
        reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
        rx_err_passive = (reg_err_counter & ERR_CNT_RP_MASK) >>
                                ERR_CNT_RP_SHIFT;


________________________________

Actuant Corporation Email Notice

This message is intended only for the use of the Addressee and may contain information that is PRIVILEGED and/or CONFIDENTIAL.
This email is intended only for the personal and confidential use of the recipient(s) named above. If the reader of this email is not an intended recipient, you have received this email in error and any review, dissemination, distribution or copying is strictly prohibited.
If you have received this email in error, please notify the sender immediately by return mail and permanently delete the copy you received.

Thank you.
