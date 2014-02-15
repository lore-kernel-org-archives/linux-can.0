From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 5/5] can: allow to change the device mtu for CAN FD capable devices
Date: Sat, 15 Feb 2014 08:08:42 +0100
Message-ID: <1392448122-4689-5-git-send-email-socketcan@hartkopp.net>
References: <1392448122-4689-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:40204 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbaBOHIy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 15 Feb 2014 02:08:54 -0500
In-Reply-To: <1392448122-4689-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c            | 25 +++++++++++++++++++++++++
 include/linux/can/dev.h          |  1 +
 include/uapi/linux/can/netlink.h |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index a2b9bce..a1ce36f 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -598,6 +598,31 @@ void free_candev(struct net_device *dev)
 EXPORT_SYMBOL_GPL(free_candev);
 
 /*
+ * CANFD support: enable changing MTU for CANFD aware devices.
+ */
+int can_change_mtu(struct net_device *dev, int new_mtu)
+{
+	/* Do not allow changing the MTU while running */
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	/* allow change of MTU according to the CANFD ability of the device */
+	if (new_mtu != CAN_MTU) {
+		struct can_priv *priv = netdev_priv(dev);
+
+		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD))
+			return -EINVAL;
+
+		if (new_mtu != CANFD_MTU)
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
1.9.0.rc3

