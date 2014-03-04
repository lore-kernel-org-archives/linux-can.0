From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v12 7/7] can: add bittiming check at interface open for CAN FD
Date: Tue,  4 Mar 2014 23:26:56 +0100
Message-ID: <1393972016-18383-8-git-send-email-mkl@pengutronix.de>
References: <1393972016-18383-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58403 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626AbaCDW1C (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 17:27:02 -0500
In-Reply-To: <1393972016-18383-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

Additionally to have the second (data) bitrate available the data bitrate
has to be greater or equal to the arbitration bitrate in CAN FD.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 4e20d82b..c7a2604 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -642,6 +642,14 @@ int open_candev(struct net_device *dev)
 		return -EINVAL;
 	}
 
+	/* For CAN FD the data bitrate has to be >= the arbitration bitrate */
+	if ((priv->ctrlmode & CAN_CTRLMODE_FD) &&
+	    (!priv->data_bittiming.bitrate ||
+	     (priv->data_bittiming.bitrate < priv->bittiming.bitrate))) {
+		netdev_err(dev, "incorrect/missing data bit-timing\n");
+		return -EINVAL;
+	}
+
 	/* Switch carrier on if device was stopped while in bus-off state */
 	if (!netif_carrier_ok(dev))
 		netif_carrier_on(dev);
-- 
1.9.0

