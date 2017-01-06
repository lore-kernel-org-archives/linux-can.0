From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on devices not providing {data_,}bittiming_const
Date: Fri,  6 Jan 2017 13:53:44 +0100
Message-ID: <20170106125344.15267-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56857 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1760580AbdAFNNd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Jan 2017 08:13:33 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Until commit

    08da7da41ea4 can: provide a separate bittiming_const parameter to
                 bittiming functions

it was possible to have devices not providing bittiming_const. This can
be used for hardware that only support pre-defined fixed bitrates.
Although no mainline driver is using this feature so far.

This patch re-introduces this feature for the bitrate and the data
bitrate (of CANFD controllers). The driver can specify the
{data_,}bittiming_const (if the bittiming parameters should be
calculated from the bittiming_const) as before or no
{data_,}bittiming_const but implement the do_set_{data,}bittiming
callback.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

this patch should make the mcba_usb driver, which only support fixed bitrates,
a bit simpler.

regards,
Marc

 drivers/net/can/dev.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 8d6208c0b400..c240cd9f823b 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -284,10 +284,6 @@ static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
 {
 	int err;
 
-	/* Check if the CAN device has bit-timing parameters */
-	if (!btc)
-		return -EOPNOTSUPP;
-
 	/*
 	 * Depending on the given can_bittiming parameter structure the CAN
 	 * timing parameters are calculated based on the provided bitrate OR
@@ -872,10 +868,22 @@ static int can_changelink(struct net_device *dev,
 		/* Do not allow changing bittiming while running */
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
+
+		/* Calculate bittiming parameters based on
+		 * bittiming_const if set, otherwise pass bitrate
+		 * directly via do_set_bitrate(). Bail out if neither
+		 * is given.
+		 */
+		if (!priv->bittiming_const && !priv->do_set_bittiming)
+			return -EOPNOTSUPP;
+
 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_get_bittiming(dev, &bt, priv->bittiming_const);
-		if (err)
-			return err;
+		if (priv->bittiming_const) {
+			err = can_get_bittiming(dev, &bt,
+						priv->bittiming_const);
+			if (err)
+				return err;
+		}
 		memcpy(&priv->bittiming, &bt, sizeof(bt));
 
 		if (priv->do_set_bittiming) {
@@ -943,11 +951,23 @@ static int can_changelink(struct net_device *dev,
 		/* Do not allow changing bittiming while running */
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
+
+		/* Calculate bittiming parameters based on
+		 * data_bittiming_const if set, otherwise pass bitrate
+		 * directly via do_set_bitrate(). Bail out if neither
+		 * is given.
+		 */
+		if (!priv->data_bittiming_const && !priv->do_set_data_bittiming)
+			return -EOPNOTSUPP;
+
 		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
 		       sizeof(dbt));
-		err = can_get_bittiming(dev, &dbt, priv->data_bittiming_const);
-		if (err)
-			return err;
+		if (priv->data_bittiming_const) {
+			err = can_get_bittiming(dev, &dbt,
+						priv->data_bittiming_const);
+			if (err)
+				return err;
+		}
 		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
 
 		if (priv->do_set_data_bittiming) {
-- 
2.11.0

