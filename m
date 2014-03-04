From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v10 6/7] can: allow to change the device mtu for CAN FD capable devices
Date: Tue,  4 Mar 2014 21:44:14 +0100
Message-ID: <1393965855-3408-7-git-send-email-mkl@pengutronix.de>
References: <1393965855-3408-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54702 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932792AbaCDUoV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 15:44:21 -0500
In-Reply-To: <1393965855-3408-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

The configuration for CAN FD depends on CAN_CTRLMODE_FD enabled in the driver
specific ctrlmode_supported capabilities.

The configuration can be done either with the 'fd { on | off }' option in the
'ip' tool from iproute2 or by setting the CAN netdevice MTU to CAN_MTU (16) or
to CANFD_MTU (72).

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c            | 67 +++++++++++++++++++++++++++++++---------
 include/linux/can/dev.h          |  1 +
 include/uapi/linux/can/netlink.h |  1 +
 3 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 3c30920..cd11c0c1 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -595,6 +595,39 @@ void free_candev(struct net_device *dev)
 EXPORT_SYMBOL_GPL(free_candev);
 
 /*
+ * changing MTU and control mode for CAN/CANFD devices
+ */
+int can_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	/* Do not allow changing the MTU while running */
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	/* allow change of MTU according to the CANFD ability of the device */
+	switch (new_mtu) {
+	case CAN_MTU:
+		priv->ctrlmode &= ~CAN_CTRLMODE_FD;
+		break;
+
+	case CANFD_MTU:
+		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD))
+			return -EINVAL;
+
+		priv->ctrlmode |= CAN_CTRLMODE_FD;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_change_mtu);
+
+/*
  * Common open function when the device gets opened.
  *
  * This function should be called in the open function of the device
@@ -682,20 +715,6 @@ static int can_changelink(struct net_device *dev,
 		}
 	}
 
-	if (data[IFLA_CAN_DATA_BITTIMING]) {
-		struct can_bittiming dbt;
-
-		/* Do not allow changing bittiming while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
-		       sizeof(dbt));
-		err = can_get_bittiming(dev, &dbt, priv->data_bittiming_const);
-		if (err)
-			return err;
-		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
-	}
-
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm;
 
@@ -707,6 +726,12 @@ static int can_changelink(struct net_device *dev,
 			return -EOPNOTSUPP;
 		priv->ctrlmode &= ~cm->mask;
 		priv->ctrlmode |= cm->flags;
+
+		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
+		if (priv->ctrlmode & CAN_CTRLMODE_FD)
+			dev->mtu = CANFD_MTU;
+		else
+			dev->mtu = CAN_MTU;
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
@@ -725,6 +750,20 @@ static int can_changelink(struct net_device *dev,
 			return err;
 	}
 
+	if (data[IFLA_CAN_DATA_BITTIMING]) {
+		struct can_bittiming dbt;
+
+		/* Do not allow changing bittiming while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
+		       sizeof(dbt));
+		err = can_get_bittiming(dev, &dbt, priv->data_bittiming_const);
+		if (err)
+			return err;
+		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 8adaee9..3ce5e52 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -113,6 +113,7 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
+int can_change_mtu(struct net_device *dev, int new_mtu);
 
 int register_candev(struct net_device *dev);
 void unregister_candev(struct net_device *dev);
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index b41933d..7e2e186 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -96,6 +96,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
 #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
+#define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
 
 /*
  * CAN device statistics
-- 
1.9.0

