From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/6] canfd: add support for CAN FD in PF_CAN core
Date: Mon, 18 Jun 2012 19:39:24 +0200
Message-ID: <4FDF67CC.6080705@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:39775 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab2FRRjX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 13:39:23 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

- handle ETH_P_CAN and ETH_P_CANFD skbuffs
- update sanity checks for CAN and CAN FD
- make sure the CAN frame can pass the selected CAN netdevice on send
- bump core version and abi version to indicate the new CAN FD support

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/core.h |    4 +-
 net/can/af_can.c         |  109 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 84 insertions(+), 29 deletions(-)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 0ccc1cd..78c6c52 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -17,10 +17,10 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 -#define CAN_VERSION "20090105"
+#define CAN_VERSION "20120528"
  /* increment this number each time you change some user-space interface */
-#define CAN_ABI_VERSION "8"
+#define CAN_ABI_VERSION "9"
  #define CAN_VERSION_STRING "rev " CAN_VERSION " abi " CAN_ABI_VERSION
 diff --git a/net/can/af_can.c b/net/can/af_can.c
index c96140a..821022a 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -221,30 +221,46 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
  *  -ENOBUFS on full driver queue (see net_xmit_errno())
  *  -ENOMEM when local loopback failed at calling skb_clone()
  *  -EPERM when trying to send on a non-CAN interface
+ *  -EMSGSIZE CAN frame size is bigger than CAN interface MTU
  *  -EINVAL when the skb->data does not contain a valid CAN frame
  */
 int can_send(struct sk_buff *skb, int loop)
 {
 	struct sk_buff *newskb = NULL;
-	struct can_frame *cf = (struct can_frame *)skb->data;
-	int err;
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+	int err = -EINVAL;
+
+	if (skb->len == CAN_MTU) {
+		skb->protocol = htons(ETH_P_CAN);
+		if (unlikely(cfd->len > CAN_MAX_DLEN))
+			goto inval_skb;
+	} else if (skb->len == CANFD_MTU) {
+		skb->protocol = htons(ETH_P_CANFD);
+		if (unlikely(cfd->len > CANFD_MAX_DLEN))
+			goto inval_skb;
+	} else
+		goto inval_skb;
 -	if (skb->len != sizeof(struct can_frame) || cf->can_dlc > 8) {
-		kfree_skb(skb);
-		return -EINVAL;
+	/*
+	 * Make sure the CAN frame can pass the selected CAN netdevice.
+	 * As structs can_frame and canfd_frame are similar, we can provide
+	 * CAN FD frames to legacy CAN drivers as long as the length is <= 8
+	 */
+	if (unlikely(skb->len > skb->dev->mtu && cfd->len > CAN_MAX_DLEN)) {
+		err = -EMSGSIZE;
+		goto inval_skb;
 	}
 -	if (skb->dev->type != ARPHRD_CAN) {
-		kfree_skb(skb);
-		return -EPERM;
+	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
+		err = -EPERM;
+		goto inval_skb;
 	}
 -	if (!(skb->dev->flags & IFF_UP)) {
-		kfree_skb(skb);
-		return -ENETDOWN;
+	if (unlikely(!(skb->dev->flags & IFF_UP))) {
+		err = -ENETDOWN;
+		goto inval_skb;
 	}
 -	skb->protocol = htons(ETH_P_CAN);
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
 @@ -301,6 +317,10 @@ int can_send(struct sk_buff *skb, int loop)
 	can_stats.tx_frames_delta++;
  	return 0;
+
+inval_skb:
+	kfree_skb(skb);
+	return err;
 }
 EXPORT_SYMBOL(can_send);
 @@ -633,24 +653,11 @@ static int can_rcv_filter(struct dev_rcv_lists *d, struct sk_buff *skb)
 	return matches;
 }
 -static int can_rcv(struct sk_buff *skb, struct net_device *dev,
-		   struct packet_type *pt, struct net_device *orig_dev)
+static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
 	struct dev_rcv_lists *d;
-	struct can_frame *cf = (struct can_frame *)skb->data;
 	int matches;
 -	if (!net_eq(dev_net(dev), &init_net))
-		goto drop;
-
-	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
-		      skb->len != sizeof(struct can_frame) ||
-		      cf->can_dlc > 8,
-		      "PF_CAN: dropped non conform skbuf: "
-		      "dev type %d, len %d, can_dlc %d\n",
-		      dev->type, skb->len, cf->can_dlc))
-		goto drop;
-
 	/* update statistics */
 	can_stats.rx_frames++;
 	can_stats.rx_frames_delta++;
@@ -674,7 +681,49 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		can_stats.matches++;
 		can_stats.matches_delta++;
 	}
+}
+
+static int can_rcv(struct sk_buff *skb, struct net_device *dev,
+		   struct packet_type *pt, struct net_device *orig_dev)
+{
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 +	if (unlikely(!net_eq(dev_net(dev), &init_net)))
+		goto drop;
+
+	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
+		      skb->len != CAN_MTU ||
+		      cfd->len > CAN_MAX_DLEN,
+		      "PF_CAN: dropped non conform CAN skbuf: "
+		      "dev type %d, len %d, datalen %d\n",
+		      dev->type, skb->len, cfd->len))
+		goto drop;
+
+	can_receive(skb, dev);
+	return NET_RX_SUCCESS;
+
+drop:
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
+static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
+		   struct packet_type *pt, struct net_device *orig_dev)
+{
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+	if (unlikely(!net_eq(dev_net(dev), &init_net)))
+		goto drop;
+
+	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
+		      skb->len != CANFD_MTU ||
+		      cfd->len > CANFD_MAX_DLEN,
+		      "PF_CAN: dropped non conform CAN FD skbuf: "
+		      "dev type %d, len %d, datalen %d\n",
+		      dev->type, skb->len, cfd->len))
+		goto drop;
+
+	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
  drop:
@@ -808,10 +857,14 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
  static struct packet_type can_packet __read_mostly = {
 	.type = cpu_to_be16(ETH_P_CAN),
-	.dev  = NULL,
 	.func = can_rcv,
 };
 +static struct packet_type canfd_packet __read_mostly = {
+	.type = cpu_to_be16(ETH_P_CANFD),
+	.func = canfd_rcv,
+};
+
 static const struct net_proto_family can_family_ops = {
 	.family = PF_CAN,
 	.create = can_create,
@@ -853,6 +906,7 @@ static __init int can_init(void)
 	sock_register(&can_family_ops);
 	register_netdevice_notifier(&can_netdev_notifier);
 	dev_add_pack(&can_packet);
+	dev_add_pack(&canfd_packet);
  	return 0;
 }
@@ -867,6 +921,7 @@ static __exit void can_exit(void)
 	can_remove_proc();
  	/* protocol unregister */
+	dev_remove_pack(&canfd_packet);
 	dev_remove_pack(&can_packet);
 	unregister_netdevice_notifier(&can_netdev_notifier);
 	sock_unregister(PF_CAN);
-- 
1.7.10.4

