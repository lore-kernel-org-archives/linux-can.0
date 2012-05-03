From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC] CAN FD support part 1 - uncommented source
Date: Thu, 03 May 2012 13:14:37 +0200
Message-ID: <4FA2689D.5030905@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:47243 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab2ECLOl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 07:14:41 -0400
Received: from [10.251.25.131] ([134.191.244.25])
	by smtp.strato.de (jored mo54) (RZmta 29.1 AUTH)
	with ESMTPA id N0265eo438lHMS for <linux-can@vger.kernel.org>;
	Thu, 3 May 2012 13:14:38 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index f03d7a4..1b7e843 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -454,7 +454,7 @@ EXPORT_SYMBOL_GPL(can_bus_off);
 static void can_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_CAN;
-	dev->mtu = sizeof(struct can_frame);
+	dev->mtu = CAN_MTU;
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
 	dev->tx_queue_len = 10;
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index ea2d942..bddbafb 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -74,9 +74,8 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
 	struct net_device_stats *stats = &dev->stats;
 
 	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
+	stats->rx_bytes += can_dlc2len(cf->can_dlc);
 
-	skb->protocol  = htons(ETH_P_CAN);
 	skb->pkt_type  = PACKET_BROADCAST;
 	skb->dev       = dev;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -94,7 +93,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_OK;
 
 	stats->tx_packets++;
-	stats->tx_bytes += cf->can_dlc;
+	stats->tx_bytes += can_dlc2len(cf->can_dlc);
 
 	/* set flag whether this packet has to be looped back */
 	loop = skb->pkt_type == PACKET_LOOPBACK;
@@ -108,7 +107,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 			 * CAN core already did the echo for us
 			 */
 			stats->rx_packets++;
-			stats->rx_bytes += cf->can_dlc;
+			stats->rx_bytes += can_dlc2len(cf->can_dlc);
 		}
 		kfree_skb(skb);
 		return NETDEV_TX_OK;
@@ -133,14 +132,25 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static int vcan_change_mtu(struct net_device *dev, int new_mtu)
+{
+	if (new_mtu == CAN_MTU || new_mtu == CANFD_MTU) {
+		dev->mtu = new_mtu;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static const struct net_device_ops vcan_netdev_ops = {
 	.ndo_start_xmit = vcan_tx,
+	.ndo_change_mtu = vcan_change_mtu,
 };
 
 static void vcan_setup(struct net_device *dev)
 {
 	dev->type		= ARPHRD_CAN;
-	dev->mtu		= sizeof(struct can_frame);
+	dev->mtu		= CAN_MTU;
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
diff --git a/include/linux/can.h b/include/linux/can.h
index 9a19bcb..74052da 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -46,6 +46,9 @@ typedef __u32 canid_t;
  */
 typedef __u32 can_err_mask_t;
 
+#define CAN_MAX_DLC 8
+#define CANFD_MAX_DLC 15
+
 /**
  * struct can_frame - basic CAN frame structure
  * @can_id:  the CAN ID of the frame and CAN_*_FLAG flags, see above.
@@ -58,6 +61,65 @@ struct can_frame {
 	__u8    data[8] __attribute__((aligned(8)));
 };
 
+/*
+ * defined bits for canfd_frame.flags
+ *
+ * RX: HDR/EDL - info about received CAN FD frame
+ *     ESI     - bit from originating CAN controller
+ * TX: HDR/EDL - control per-frame settings if supported by CAN controller
+ *     ESI     - bit is set by local CAN controller
+ */
+#define CANFD_HDR 0x01 /* high data rate */
+#define CANFD_EDL 0x02 /* extended data length */
+#define CANFD_ESI 0x04 /* error state indicator */
+
+/**
+ * struct canfd_frame - CAN flexible data rate frame structure
+ * @can_id:  the CAN ID of the frame and CAN_*_FLAG flags, see above.
+ * @can_dlc: the data length field of the CAN frame (data length code)
+ * @flags:   additional flags for CAN FD
+ * @__res0:  reserved / padding
+ * @__res1:  reserved / padding
+ * @data:    the CAN FD frame payload (up to 64 byte).
+ */
+struct canfd_frame {
+	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
+	__u8    can_dlc; /* CAN FD data length code: 0 .. 0xF */
+	__u8    flags;   /* additional flags for CAN FD */
+	__u8    __res0;  /* reserved / padding */
+	__u8    __res1;  /* reserved / padding */
+	__u8    data[64] __attribute__((aligned(8)));
+};
+
+static const u8 dlc2len[16] = {0, 1, 2, 3, 4, 5, 6, 7, 8,
+			       12, 16, 20, 24, 32, 48, 64};
+
+/* get data length from can_dlc with sanitized can_dlc */
+static inline u8 can_dlc2len (u8 can_dlc)
+{
+	return dlc2len[can_dlc & 0x0F];
+}
+
+static const u8 len2dlc[65] = {0, 1, 2, 3, 4, 5, 6, 7, 8,	/* 0 - 8 */
+			       9, 9, 9, 9,			/* 9 - 12 */
+			       10, 10, 10, 10,			/* 13 - 16 */
+			       11, 11, 11, 11,			/* 17 - 20 */
+			       12, 12, 12, 12,			/* 21 - 24 */
+			       13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
+			       14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
+			       14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
+			       15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
+			       15, 15, 15, 15, 15, 15, 15, 15}; /* 57 - 64 */
+
+/* map the sanitized data length to an appropriate data length code */ 
+static inline u8 can_len2dlc(u8 len)
+{
+	if (unlikely(len > 64))
+		return 0xF;
+
+	return len2dlc[len];
+}
+
 /* particular protocols of the protocol family PF_CAN */
 #define CAN_RAW		1 /* RAW sockets */
 #define CAN_BCM		2 /* Broadcast Manager */
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 0ccc1cd..e6a3126 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -17,10 +17,10 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 
-#define CAN_VERSION "20090105"
+#define CAN_VERSION "20120413"
 
 /* increment this number each time you change some user-space interface */
-#define CAN_ABI_VERSION "8"
+#define CAN_ABI_VERSION "9"
 
 #define CAN_VERSION_STRING "rev " CAN_VERSION " abi " CAN_ABI_VERSION
 
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5d2efe7..082b664 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -61,7 +61,11 @@ struct can_priv {
  * To be used in the CAN netdriver receive path to ensure conformance with
  * ISO 11898-1 Chapter 8.4.2.3 (DLC field)
  */
-#define get_can_dlc(i)	(min_t(__u8, (i), 8))
+#define get_can_dlc(i)		(min_t(__u8, (i), CAN_MAX_DLC))
+#define get_canfd_dlc(i)	(min_t(__u8, (i), CANFD_MAX_DLC))
+
+#define CAN_MTU		(sizeof(struct can_frame))
+#define CANFD_MTU	(sizeof(struct canfd_frame))
 
 /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
 static inline int can_dropped_invalid_skb(struct net_device *dev,
@@ -69,13 +73,23 @@ static inline int can_dropped_invalid_skb(struct net_device *dev,
 {
 	const struct can_frame *cf = (struct can_frame *)skb->data;
 
-	if (unlikely(skb->len != sizeof(*cf) || cf->can_dlc > 8)) {
-		kfree_skb(skb);
-		dev->stats.tx_dropped++;
-		return 1;
-	}
+	if (skb->protocol == htons(ETH_P_CAN)) {
+		if (skb->len != sizeof(struct can_frame) ||
+		    cf->can_dlc > CAN_MAX_DLC)
+			goto inval_skb;
+	} else if (skb->protocol == htons(ETH_P_CANFD)) {
+		if (skb->len != sizeof(struct canfd_frame) ||
+		    cf->can_dlc > CANFD_MAX_DLC)
+			goto inval_skb;
+	} else
+		goto inval_skb;
 
 	return 0;
+
+inval_skb:
+	kfree_skb(skb);
+	dev->stats.tx_dropped++;
+	return 1;
 }
 
 struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
index 781f3a3..5448c0f 100644
--- a/include/linux/can/raw.h
+++ b/include/linux/can/raw.h
@@ -23,7 +23,8 @@ enum {
 	CAN_RAW_FILTER = 1,	/* set 0 .. n can_filter(s)          */
 	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
 	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
-	CAN_RAW_RECV_OWN_MSGS	/* receive my own msgs (default:off) */
+	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
+	CAN_RAW_FD_FRAMES,	/* use struct canfd_frame (default:off) */
 };
 
 #endif
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 56d907a..5c9c2b4 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -119,6 +119,7 @@
 #define ETH_P_PHONET	0x00F5		/* Nokia Phonet frames          */
 #define ETH_P_IEEE802154 0x00F6		/* IEEE802.15.4 frame		*/
 #define ETH_P_CAIF	0x00F7		/* ST-Ericsson CAIF protocol	*/
+#define ETH_P_CANFD	0x00FD		/* Controller Area Network FD   */
 
 /*
  *	This is an Ethernet frame header.
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0ce2ad0..1b7f1f8 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -41,6 +41,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/stddef.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
@@ -228,10 +229,20 @@ int can_send(struct sk_buff *skb, int loop)
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	int err;
 
-	if (skb->len != sizeof(struct can_frame) || cf->can_dlc > 8) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
+	if (skb->protocol == htons(ETH_P_CAN)) {
+		if (skb->len != sizeof(struct can_frame) ||
+		    cf->can_dlc > CAN_MAX_DLC)
+			goto inval_skb;
+	} else if (skb->protocol == htons(ETH_P_CANFD)) {
+		if (skb->len != sizeof(struct canfd_frame) ||
+		    cf->can_dlc > CANFD_MAX_DLC)
+			goto inval_skb;
+	} else
+		goto inval_skb;
+
+	/* make sure the CAN frame can pass the selected CAN netdevice */
+	if (skb->len > skb->dev->mtu)
+		goto inval_skb;
 
 	if (skb->dev->type != ARPHRD_CAN) {
 		kfree_skb(skb);
@@ -243,7 +254,6 @@ int can_send(struct sk_buff *skb, int loop)
 		return -ENETDOWN;
 	}
 
-	skb->protocol = htons(ETH_P_CAN);
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
 
@@ -300,6 +310,10 @@ int can_send(struct sk_buff *skb, int loop)
 	can_stats.tx_frames_delta++;
 
 	return 0;
+
+inval_skb:
+	kfree_skb(skb);
+	return -EINVAL;
 }
 EXPORT_SYMBOL(can_send);
 
@@ -632,24 +646,11 @@ static int can_rcv_filter(struct dev_rcv_lists *d, struct sk_buff *skb)
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
@@ -673,7 +674,49 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		can_stats.matches++;
 		can_stats.matches_delta++;
 	}
+}
+
+static int can_rcv(struct sk_buff *skb, struct net_device *dev,
+		   struct packet_type *pt, struct net_device *orig_dev)
+{
+	struct can_frame *cf = (struct can_frame *)skb->data;
 
+	if (!net_eq(dev_net(dev), &init_net))
+		goto drop;
+
+	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
+		      skb->len != sizeof(struct can_frame) ||
+		      cf->can_dlc > CAN_MAX_DLC,
+		      "PF_CAN: dropped non conform CAN skbuf: "
+		      "dev type %d, len %d, can_dlc %d\n",
+		      dev->type, skb->len, cf->can_dlc))
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
+	struct can_frame *cf = (struct can_frame *)skb->data;
+
+	if (!net_eq(dev_net(dev), &init_net))
+		goto drop;
+
+	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
+		      skb->len != sizeof(struct canfd_frame) ||
+		      cf->can_dlc > CANFD_MAX_DLC,
+		      "PF_CAN: dropped non conform CAN FD skbuf: "
+		      "dev type %d, len %d, can_dlc %d\n",
+		      dev->type, skb->len, cf->can_dlc))
+		goto drop;
+
+	can_receive(skb, dev);
 	return NET_RX_SUCCESS;
 
 drop:
@@ -811,6 +854,12 @@ static struct packet_type can_packet __read_mostly = {
 	.func = can_rcv,
 };
 
+static struct packet_type canfd_packet __read_mostly = {
+	.type = cpu_to_be16(ETH_P_CANFD),
+	.dev  = NULL,
+	.func = canfd_rcv,
+};
+
 static const struct net_proto_family can_family_ops = {
 	.family = PF_CAN,
 	.create = can_create,
@@ -824,6 +873,10 @@ static struct notifier_block can_netdev_notifier __read_mostly = {
 
 static __init int can_init(void)
 {
+	/* check for correct padding that can_dlc owns always the same position */
+	BUILD_BUG_ON(offsetof(struct can_frame, can_dlc) !=
+		     offsetof(struct canfd_frame, can_dlc));
+
 	printk(banner);
 
 	memset(&can_rx_alldev_list, 0, sizeof(can_rx_alldev_list));
@@ -846,6 +899,7 @@ static __init int can_init(void)
 	sock_register(&can_family_ops);
 	register_netdevice_notifier(&can_netdev_notifier);
 	dev_add_pack(&can_packet);
+	dev_add_pack(&canfd_packet);
 
 	return 0;
 }
@@ -861,6 +915,7 @@ static __exit void can_exit(void)
 
 	/* protocol unregister */
 	dev_remove_pack(&can_packet);
+	dev_remove_pack(&canfd_packet);
 	unregister_netdevice_notifier(&can_netdev_notifier);
 	sock_unregister(PF_CAN);
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 151b773..2060945 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -265,6 +265,7 @@ static void bcm_can_tx(struct bcm_op *op)
 	/* send with loopback */
 	skb->dev = dev;
 	skb->sk = op->sk;
+	skb->protocol = htons(ETH_P_CAN);
 	can_send(skb, 1);
 
 	/* update statistics */
@@ -1215,6 +1216,7 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk)
 
 	skb->dev = dev;
 	skb->sk  = sk;
+	skb->protocol = htons(ETH_P_CAN);
 	err = can_send(skb, 1); /* send with loopback */
 	dev_put(dev);
 
diff --git a/net/can/raw.c b/net/can/raw.c
index cde1b4a..7d3864e 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -82,6 +82,7 @@ struct raw_sock {
 	struct notifier_block notifier;
 	int loopback;
 	int recv_own_msgs;
+	int fd_frames;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
@@ -119,6 +120,15 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 
+	/* only pass correct frames to the socket */
+	if (ro->fd_frames) {
+		if (oskb->protocol != htons(ETH_P_CANFD))
+			return;
+	} else {
+		if (oskb->protocol != htons(ETH_P_CAN))
+			return;
+	}
+
 	/* clone the given skb to be able to enqueue it into the rcv queue */
 	skb = skb_clone(oskb, GFP_ATOMIC);
 	if (!skb)
@@ -291,6 +301,7 @@ static int raw_init(struct sock *sk)
 	/* set default loopback behaviour */
 	ro->loopback         = 1;
 	ro->recv_own_msgs    = 0;
+	ro->fd_frames        = 0;
 
 	/* set notifier */
 	ro->notifier.notifier_call = raw_notifier;
@@ -569,6 +580,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case CAN_RAW_FD_FRAMES:
+		if (optlen != sizeof(ro->fd_frames))
+			return -EINVAL;
+
+		if (copy_from_user(&ro->fd_frames, optval, optlen))
+			return -EFAULT;
+
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -627,6 +647,12 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		val = &ro->recv_own_msgs;
 		break;
 
+	case CAN_RAW_FD_FRAMES:
+		if (len > sizeof(int))
+			len = sizeof(int);
+		val = &ro->fd_frames;
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -662,13 +688,24 @@ static int raw_sendmsg(struct kiocb *iocb, struct socket *sock,
 	} else
 		ifindex = ro->ifindex;
 
-	if (size != sizeof(struct can_frame))
-		return -EINVAL;
+	if (ro->fd_frames) {
+		if (size != sizeof(struct canfd_frame))
+			return -EINVAL;
+	} else {
+		if (size != sizeof(struct can_frame))
+			return -EINVAL;
+	}
 
 	dev = dev_get_by_index(&init_net, ifindex);
 	if (!dev)
 		return -ENXIO;
 
+	/* make sure the created CAN frame can pass the CAN netdevice */
+	if (size > dev->mtu) {
+		err = -EINVAL;
+		goto put_dev;
+	}
+
 	skb = sock_alloc_send_skb(sk, size, msg->msg_flags & MSG_DONTWAIT,
 				  &err);
 	if (!skb)
@@ -684,6 +721,11 @@ static int raw_sendmsg(struct kiocb *iocb, struct socket *sock,
 	/* to be able to check the received tx sock reference in raw_rcv() */
 	skb_shinfo(skb)->tx_flags |= SKBTX_DRV_NEEDS_SK_REF;
 
+	if (ro->fd_frames)
+		skb->protocol = htons(ETH_P_CANFD);
+	else
+		skb->protocol = htons(ETH_P_CAN);
+
 	skb->dev = dev;
 	skb->sk  = sk;
 


