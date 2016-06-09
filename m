From: Marek Vasut <marex@denx.de>
Subject: [PATCH 2/5][RFC] can: Factor out alloc_socketdev()
Date: Thu,  9 Jun 2016 21:21:01 +0200
Message-ID: <1465500064-5402-2-git-send-email-marex@denx.de>
References: <1465500064-5402-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41674 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbcFITVm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2016 15:21:42 -0400
In-Reply-To: <1465500064-5402-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Factor out alloc_socketdev() from alloc_candev() to make it possible
to register different socket devices -- like kline -- using the same
codepath.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c   | 11 +++++++++--
 include/linux/can/dev.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 141c2a4..f8ef6b0 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -641,7 +641,8 @@ EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 /*
  * Allocate and setup space for the CAN network device
  */
-struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
+struct net_device *alloc_socketdev(const char *name, int sizeof_priv,
+				   unsigned int echo_skb_max)
 {
 	struct net_device *dev;
 	struct can_priv *priv;
@@ -653,7 +654,7 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 	else
 		size = sizeof_priv;
 
-	dev = alloc_netdev(size, "can%d", NET_NAME_UNKNOWN, can_setup);
+	dev = alloc_netdev(size, name, NET_NAME_UNKNOWN, can_setup);
 	if (!dev)
 		return NULL;
 
@@ -671,6 +672,12 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 
 	return dev;
 }
+EXPORT_SYMBOL_GPL(alloc_socketdev);
+
+struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
+{
+	return alloc_socketdev("can%d", sizeof_priv, echo_skb_max);
+}
 EXPORT_SYMBOL_GPL(alloc_candev);
 
 /*
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 735f9f8..9b0520d 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -114,6 +114,7 @@ u8 can_dlc2len(u8 can_dlc);
 /* map the sanitized data length to an appropriate data length code */
 u8 can_len2dlc(u8 len);
 
+struct net_device *alloc_socketdev(const char *name, int sizeof_priv, unsigned int echo_skb_max);
 struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
 void free_candev(struct net_device *dev);
 
-- 
2.7.0

