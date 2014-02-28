From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v9 6/7] can: allow to change the device mtu for CAN FD capable devices
Date: Fri, 28 Feb 2014 16:36:24 +0100
Message-ID: <1393601785-4631-7-git-send-email-socketcan@hartkopp.net>
References: <1393601785-4631-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:40222 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbaB1Pgg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 10:36:36 -0500
In-Reply-To: <1393601785-4631-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The configuration for CAN FD depends on CAN_CTRLMODE_FD enabled in the driver
specific ctrlmode_supported capabilities.

The configuration can be done either with the 'fd { on | off }' option in the
'ip' tool from iproute2 or by setting the CAN netdevice MTU to CAN_MTU (16) or
to CANFD_MTU (72).

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h          |  1 +
 include/uapi/linux/can/netlink.h |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 1eafa6cc..f3151d9 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -595,6 +595,40 @@ void free_candev(struct net_device *dev)
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
+
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
+			return -EINVAL;
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
@@ -714,6 +748,12 @@ static int can_changelink(struct net_device *dev,
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

