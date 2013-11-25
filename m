From: "Glen, Andrew" <AGlen@bepmarine.com>
Subject: RE: [PATCH] can: c_can: don't call pm_runtime_get_sync() from IRQ
 handler
Date: Mon, 25 Nov 2013 00:27:52 +0000
Message-ID: <2A43324E02E34840B044C9DC9221448009056812@AMDTCEX12.actuant.pri>
References: <1385333617-30842-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41384 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab3KYIwO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 03:52:14 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1Vkrtt-0006SP-OZ
	for linux-can@vger.kernel.org; Mon, 25 Nov 2013 09:52:13 +0100
Received: from [172.17.34.65] (hardanger.do.blackshift.org [172.17.34.65])
	(using TLSv1 with cipher ECDHE-ECDSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: frogger)
	by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id 7791D5E89A
	for <linux-can@vger.kernel.org>; Mon, 25 Nov 2013 09:52:13 +0100 (CET)
In-Reply-To: <1385333617-30842-1-git-send-email-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Marc,

There were a couple of mistakes in your patch, a missing semi-colon and missing call to 'struct c_can_priv *priv = netdev_priv(dev);' in ' c_can_get_berr_counter()'

I'm new to the formal procedures and am keen to learn. I'd like to post an updated patch. If this is ok, do I make a complete new post with a similar subject except with [Patch v2]?


Regards,
Andrew.

-----Original Message-----
From: linux-can-owner@vger.kernel.org [mailto:linux-can-owner@vger.kernel.org] On Behalf Of Marc Kleine-Budde
Sent: Monday, 25 November 2013 11:54 a.m.
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de; Glen, Andrew; Marc Kleine-Budde
Subject: [PATCH] can: c_can: don't call pm_runtime_get_sync() from IRQ handler

The c_can driver contians a callpath (c_can_poll -> c_can_state_change ->
c_can_get_berr_counter) which may call pm_runtime_get_sync() from the IRQ handler, which is not allowed.

This problem is fixed by introducing __c_can_get_berr_counter, which will not call pm_runtime_get_sync().

Reported-by: Andrew Glen <AGlen@bepmarine.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Andrew,

can you please test this patch if it solves your problem?

Marc

 drivers/net/can/c_can/c_can.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c index e3fc07c..0a5718e 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -712,22 +712,30 @@ static int c_can_set_mode(struct net_device *dev, enum can_mode mode)
        return 0;
 }

-static int c_can_get_berr_counter(const struct net_device *dev,
-                                       struct can_berr_counter *bec)
+static int __c_can_get_berr_counter(const struct net_device *dev,
+                                   struct can_berr_counter *bec)
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
+}
+
+static int c_can_get_berr_counter(const struct net_device *dev,
+                                       struct can_berr_counter *bec)
+{
+       int err;
+
+       c_can_pm_runtime_get_sync(priv);
+       err = __c_can_get_berr_counter(dev, bec)
        c_can_pm_runtime_put_sync(priv);

-       return 0;
+       return err;
 }

 /*
@@ -872,7 +880,7 @@ static int c_can_handle_state_change(struct net_device *dev,
        if (unlikely(!skb))
                return 0;

-       c_can_get_berr_counter(dev, &bec);
+       __c_can_get_berr_counter(dev, &bec);
        reg_err_counter = priv->read_reg(priv, C_CAN_ERR_CNT_REG);
        rx_err_passive = (reg_err_counter & ERR_CNT_RP_MASK) >>
                                ERR_CNT_RP_SHIFT;
--
1.8.5.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-can" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

Actuant Corporation Email Notice

This message is intended only for the use of the Addressee and may contain information that is PRIVILEGED and/or CONFIDENTIAL.
This email is intended only for the personal and confidential use of the recipient(s) named above. If the reader of this email is not an intended recipient, you have received this email in error and any review, dissemination, distribution or copying is strictly prohibited.
If you have received this email in error, please notify the sender immediately by return mail and permanently delete the copy you received.

Thank you.

