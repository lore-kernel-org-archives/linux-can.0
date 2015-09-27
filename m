From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [RFC PATCH 4/4] net: can: remove net namespace restrictions
Date: Sun, 27 Sep 2015 18:22:45 +0000
Message-ID: <DB4PR05MB0927878900A3AA31F941BE7F89400@DB4PR05MB0927.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0095.outbound.protection.outlook.com ([157.56.112.95]:16209
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751894AbbI0Sh4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 27 Sep 2015 14:37:56 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, John Ernberg <john.ernberg@actia.se>

---
 net/can/af_can.c | 12 ------------
 net/can/gw.c     |  2 --
 net/can/raw.c    |  3 ---
 3 files changed, 17 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index aaeb93a..309270d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -140,9 +140,6 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 	if (protocol < 0 || protocol >= CAN_NPROTO)
 		return -EINVAL;
 
-	if (!net_eq(net, &init_net))
-		return -EAFNOSUPPORT;
-
 	cp = can_get_proto(protocol);
 
 #ifdef CONFIG_MODULES
@@ -710,9 +707,6 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
-	if (unlikely(!net_eq(dev_net(dev), &init_net)))
-		goto drop;
-
 	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
 		      skb->len != CAN_MTU ||
 		      cfd->len > CAN_MAX_DLEN,
@@ -734,9 +728,6 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 {
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 
-	if (unlikely(!net_eq(dev_net(dev), &init_net)))
-		goto drop;
-
 	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
 		      skb->len != CANFD_MTU ||
 		      cfd->len > CANFD_MAX_DLEN,
@@ -826,9 +817,6 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct can_dev_rcv_lists *d;
 
-	if (!net_eq(dev_net(dev), &init_net))
-		return NOTIFY_DONE;
-
 	if (dev->type != ARPHRD_CAN)
 		return NOTIFY_DONE;
 
diff --git a/net/can/gw.c b/net/can/gw.c
index 082a144..f5a52ad 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -458,8 +458,6 @@ static int cgw_notifier(struct notifier_block *nb,
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
-	if (!net_eq(dev_net(dev), &init_net))
-		return NOTIFY_DONE;
 	if (dev->type != ARPHRD_CAN)
 		return NOTIFY_DONE;
 
diff --git a/net/can/raw.c b/net/can/raw.c
index c5c0cb9..8b60d87 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -272,9 +272,6 @@ static int raw_notifier(struct notifier_block *nb,
 	struct raw_sock *ro = container_of(nb, struct raw_sock, notifier);
 	struct sock *sk = &ro->sk;
 
-	if (!net_eq(dev_net(dev), &init_net))
-		return NOTIFY_DONE;
-
 	if (dev->type != ARPHRD_CAN)
 		return NOTIFY_DONE;
 
-- 
2.5.3

