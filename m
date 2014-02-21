From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4 7/7] can: add bittiming check at interface open for CAN FD
Date: Fri, 21 Feb 2014 19:57:05 +0100
Message-ID: <1393009025-4903-8-git-send-email-socketcan@hartkopp.net>
References: <1393009025-4903-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:43030 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaBUS5T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Feb 2014 13:57:19 -0500
In-Reply-To: <1393009025-4903-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Additionally to have the second (data) bitrate available the data bitrate
has to be greater or equal to the arbitration bitrate in CAN FD.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index d9f7281..9c3fb51 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -652,6 +652,14 @@ int open_candev(struct net_device *dev)
 		return -EINVAL;
 	}
 
+	/* For CAN FD the data bitrate has to be >= the arbitration bitrate */
+	if ((priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
+	    (!priv->data_bittiming.tq || !priv->data_bittiming.bitrate ||
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

