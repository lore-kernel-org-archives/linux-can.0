From: Marek Vasut <marex@denx.de>
Subject: [PATCH 3/5][RFC] can: Add register_candevice()
Date: Thu,  9 Jun 2016 21:21:02 +0200
Message-ID: <1465500064-5402-3-git-send-email-marex@denx.de>
References: <1465500064-5402-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44064 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbcFITVp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2016 15:21:45 -0400
In-Reply-To: <1465500064-5402-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Add register_candevice() call, which unlike register_candev(),
registers the candev without rtnl lock held. This is very similar
to register_netdev() and register_netdevice().

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c   | 7 +++++++
 include/linux/can/dev.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index f8ef6b0..0db16f6 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -984,6 +984,13 @@ static struct rtnl_link_ops can_link_ops __read_mostly = {
 /*
  * Register the CAN network device
  */
+int register_candevice(struct net_device *dev)
+{
+	dev->rtnl_link_ops = &can_link_ops;
+	return register_netdevice(dev);
+}
+EXPORT_SYMBOL_GPL(register_candevice);
+
 int register_candev(struct net_device *dev)
 {
 	dev->rtnl_link_ops = &can_link_ops;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9b0520d..c67082d 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -125,6 +125,7 @@ int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 int can_change_mtu(struct net_device *dev, int new_mtu);
 
+int register_candevice(struct net_device *dev);
 int register_candev(struct net_device *dev);
 void unregister_candev(struct net_device *dev);
 
-- 
2.7.0

