From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC v4] CAN FD support
Date: Tue, 15 May 2012 15:29:29 +0200
Message-ID: <4FB25A39.7090608@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:54745 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932837Ab2EON33 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 May 2012 09:29:29 -0400
Received: from [192.168.178.40] (p5B0B1336.dip0.t-ipconnect.de [91.11.19.54])
	by smtp.strato.de (jored mo91) (RZmta 29.7 DYNA|AUTH)
	with ESMTPA id e0166co4FDO4Dy for <linux-can@vger.kernel.org>;
	Tue, 15 May 2012 15:29:26 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi all,

changes since v3:

https://gitorious.org/linux-can/hartkopps-linux-can-next/commit/9d51e1e6e40be9a36210a9ac7a9f8d6067ba94a5/diffs/b24b9fa7d9720224541e7b5742ac41f792896d74

    can: bump version date (simultaneous support)
--> can_raw: allow simultaneous access of legacy apps and CANFD aware apps to CAN(FD) devices
    af_can: remove pointless initializer in packet_type definition
    can: add notifier handling when changing the CAN device MTU

I generated this diff by 'git diff fb7944b' on the repository

https://gitorious.org/~hartkopp/linux-can/hartkopps-linux-can-next

Regards,
Oliver


 drivers/net/can/dev.c    |   35 ++++++++++++++
 drivers/net/can/vcan.c   |   30 +++++++++---
 include/linux/can.h      |   51 ++++++++++++++++++++-
 include/linux/can/core.h |    4 -
 include/linux/can/dev.h  |   33 ++++++++++----
 include/linux/can/raw.h  |    3 -
 include/linux/if_ether.h |    3 -
 net/can/af_can.c         |  110 +++++++++++++++++++++++++++++++++++------------
 net/can/bcm.c            |    7 ++
 net/can/gw.c             |    2 
 net/can/raw.c            |   63 +++++++++++++++++++++++++-
 11 files changed, 287 insertions(+), 54 deletions(-)

---

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index f03d7a4..e1769b5 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -33,6 +33,39 @@ MODULE_DESCRIPTION(MOD_DESC);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
 
+/* CAN DLC to real data length conversion helpers */
+
+static const u8 dlc2len[] = {0, 1, 2, 3, 4, 5, 6, 7,
+			     8, 12, 16, 20, 24, 32, 48, 64};
+
+/* get data length from can_dlc with sanitized can_dlc */
+u8 can_dlc2len(u8 can_dlc)
+{
+	return dlc2len[can_dlc & 0x0F];
+}
+EXPORT_SYMBOL_GPL(can_dlc2len);
+
+static const u8 len2dlc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8,		/* 0 - 8 */
+			     9, 9, 9, 9,			/* 9 - 12 */
+			     10, 10, 10, 10,			/* 13 - 16 */
+			     11, 11, 11, 11,			/* 17 - 20 */
+			     12, 12, 12, 12,			/* 21 - 24 */
+			     13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
+			     14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
+			     14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
+			     15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
+			     15, 15, 15, 15, 15, 15, 15, 15};	/* 57 - 64 */
+
+/* map the sanitized data length to an appropriate data length code */ 
+u8 can_len2dlc(u8 len)
+{
+	if (unlikely(len > 64))
+		return 0xF;
+
+	return len2dlc[len];
+}
+EXPORT_SYMBOL_GPL(can_len2dlc);
+
 #ifdef CONFIG_CAN_CALC_BITTIMING
 #define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
 
@@ -454,7 +487,7 @@ EXPORT_SYMBOL_GPL(can_bus_off);
 static void can_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_CAN;
-	dev->mtu = sizeof(struct can_frame);
+	dev->mtu = CAN_MTU;
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
 	dev->tx_queue_len = 10;
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index ea2d942..f92130d 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -70,13 +70,12 @@ MODULE_PARM_DESC(echo, "Echo sent frames (for testing). Default: 0 (Off)");
 
 static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *stats = &dev->stats;
 
 	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
+	stats->rx_bytes += cfd->len;
 
-	skb->protocol  = htons(ETH_P_CAN);
 	skb->pkt_type  = PACKET_BROADCAST;
 	skb->dev       = dev;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -86,7 +85,7 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
 
 static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *stats = &dev->stats;
 	int loop;
 
@@ -94,7 +93,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_OK;
 
 	stats->tx_packets++;
-	stats->tx_bytes += cf->can_dlc;
+	stats->tx_bytes += cfd->len;
 
 	/* set flag whether this packet has to be looped back */
 	loop = skb->pkt_type == PACKET_LOOPBACK;
@@ -108,7 +107,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 			 * CAN core already did the echo for us
 			 */
 			stats->rx_packets++;
-			stats->rx_bytes += cf->can_dlc;
+			stats->rx_bytes += cfd->len;
 		}
 		kfree_skb(skb);
 		return NETDEV_TX_OK;
@@ -133,14 +132,31 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static int vcan_change_mtu(struct net_device *dev, int new_mtu)
+{
+	/* Do not allow changing the MTU while running */
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	if (new_mtu != CAN_MTU && new_mtu != CANFD_MTU)
+		return -EINVAL;
+
+	dev->mtu = new_mtu;
+
+	/* notify users (generic networking code notifies only with IFF_UP) */
+	call_netdevice_notifiers(NETDEV_CHANGEMTU, dev);
+	return 0;
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
index 9a19bcb..c8504ac 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -46,18 +46,65 @@ typedef __u32 canid_t;
  */
 typedef __u32 can_err_mask_t;
 
+#define CAN_MAX_DLC 8
+#define CAN_MAX_DLEN 8
+
+#define CANFD_MAX_DLC 15
+#define CANFD_MAX_DLEN 64
+
 /**
  * struct can_frame - basic CAN frame structure
  * @can_id:  the CAN ID of the frame and CAN_*_FLAG flags, see above.
- * @can_dlc: the data length field of the CAN frame
+ * @can_dlc: frame payload length in byte (0 .. 8) aka data length code.
+ *           The DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
+ *           mapping of the 'data length code' to the payload length.
  * @data:    the CAN frame payload.
  */
 struct can_frame {
 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
-	__u8    can_dlc; /* data length code: 0 .. 8 */
+	__u8    can_dlc; /* frame payload length in byte (0 .. 8) */
 	__u8    data[8] __attribute__((aligned(8)));
 };
 
+/*
+ * defined bits for canfd_frame.flags
+ *
+ * As the default for CAN FD should be to support the high data rate in the
+ * payload section of the frame (HDR) and to support up to 64 byte in the
+ * data section (EDL) the bits are only set in the non-default case.
+ * Btw. as long as there's no real implementation for CAN FD network driver
+ * these bits are only preliminary.
+ *
+ * RX: NOHDR/NOEDL - info about received CAN FD frame
+ *     ESI         - bit from originating CAN controller
+ * TX: NOHDR/NOEDL - control per-frame settings if supported by CAN controller
+ *     ESI         - bit is set by local CAN controller
+ */
+#define CANFD_NOHDR 0x01 /* frame without high data rate */
+#define CANFD_NOEDL 0x02 /* frame without extended data length */
+#define CANFD_ESI   0x04 /* error state indicator */
+
+/**
+ * struct canfd_frame - CAN flexible data rate frame structure
+ * @can_id: the CAN ID of the frame and CAN_*_FLAG flags, see above.
+ * @len:    frame payload length in byte (0 .. 64)
+ * @flags:  additional flags for CAN FD
+ * @__res0: reserved / padding
+ * @__res1: reserved / padding
+ * @data:   the CAN FD frame payload (up to 64 byte).
+ */
+struct canfd_frame {
+	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
+	__u8    len;     /* frame payload length in byte (0 .. 64) */
+	__u8    flags;   /* additional flags for CAN FD */
+	__u8    __res0;  /* reserved / padding */
+	__u8    __res1;  /* reserved / padding */
+	__u8    data[64] __attribute__((aligned(8)));
+};
+
+#define CAN_MTU		(sizeof(struct can_frame))
+#define CANFD_MTU	(sizeof(struct canfd_frame))
+
 /* particular protocols of the protocol family PF_CAN */
 #define CAN_RAW		1 /* RAW sockets */
 #define CAN_BCM		2 /* Broadcast Manager */
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 0ccc1cd..306dc24 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -17,10 +17,10 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 
-#define CAN_VERSION "20090105"
+#define CAN_VERSION "20120515"
 
 /* increment this number each time you change some user-space interface */
-#define CAN_ABI_VERSION "8"
+#define CAN_ABI_VERSION "9"
 
 #define CAN_VERSION_STRING "rev " CAN_VERSION " abi " CAN_ABI_VERSION
 
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5d2efe7..a243279 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -61,23 +61,40 @@ struct can_priv {
  * To be used in the CAN netdriver receive path to ensure conformance with
  * ISO 11898-1 Chapter 8.4.2.3 (DLC field)
  */
-#define get_can_dlc(i)	(min_t(__u8, (i), 8))
+#define get_can_dlc(i)		(min_t(__u8, (i), CAN_MAX_DLC))
+#define get_canfd_dlc(i)	(min_t(__u8, (i), CANFD_MAX_DLC))
 
 /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
 static inline int can_dropped_invalid_skb(struct net_device *dev,
 					  struct sk_buff *skb)
 {
-	const struct can_frame *cf = (struct can_frame *)skb->data;
-
-	if (unlikely(skb->len != sizeof(*cf) || cf->can_dlc > 8)) {
-		kfree_skb(skb);
-		dev->stats.tx_dropped++;
-		return 1;
-	}
+	const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+	if (skb->protocol == htons(ETH_P_CAN)) {
+		if (unlikely(skb->len != sizeof(struct can_frame) ||
+			     cfd->len > CAN_MAX_DLEN))
+			goto inval_skb;
+	} else if (skb->protocol == htons(ETH_P_CANFD)) {
+		if (unlikely(skb->len != sizeof(struct canfd_frame) ||
+			    cfd->len > CANFD_MAX_DLEN))
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
 
+/* get data length from can_dlc with sanitized can_dlc */
+u8 can_dlc2len(u8 can_dlc);
+
+/* map the sanitized data length to an appropriate data length code */ 
+u8 can_len2dlc(u8 len);
+
 struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
 void free_candev(struct net_device *dev);
 
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
index 56d907a..260138b 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -105,7 +105,8 @@
 #define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP frames*/
 #define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP frames */
 #define ETH_P_LOCALTALK 0x0009		/* Localtalk pseudo type 	*/
-#define ETH_P_CAN	0x000C		/* Controller Area Network      */
+#define ETH_P_CAN	0x000C		/* Controller Area Network (CAN)*/
+#define ETH_P_CANFD	0x000D		/* CAN FD 64 byte payload frames*/
 #define ETH_P_PPPTALK	0x0010		/* Dummy type for Atalk over PPP*/
 #define ETH_P_TR_802_2	0x0011		/* 802.2 frames 		*/
 #define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0ce2ad0..c8f729a 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -41,6 +41,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/stddef.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
@@ -220,30 +221,42 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
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
+	/* make sure the CAN frame can pass the selected CAN netdevice */
+	if (unlikely(skb->len > skb->dev->mtu)) {
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
 
@@ -300,6 +313,10 @@ int can_send(struct sk_buff *skb, int loop)
 	can_stats.tx_frames_delta++;
 
 	return 0;
+
+inval_skb:
+	kfree_skb(skb);
+	return err;
 }
 EXPORT_SYMBOL(can_send);
 
@@ -632,24 +649,11 @@ static int can_rcv_filter(struct dev_rcv_lists *d, struct sk_buff *skb)
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
@@ -673,7 +677,49 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		can_stats.matches++;
 		can_stats.matches_delta++;
 	}
+}
+
+static int can_rcv(struct sk_buff *skb, struct net_device *dev,
+		   struct packet_type *pt, struct net_device *orig_dev)
+{
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+	if (unlikely(!net_eq(dev_net(dev), &init_net)))
+		goto drop;
 
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
@@ -807,10 +853,14 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 
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
@@ -824,6 +874,10 @@ static struct notifier_block can_netdev_notifier __read_mostly = {
 
 static __init int can_init(void)
 {
+	/* check for correct padding that can_dlc owns always the same position */
+	BUILD_BUG_ON(offsetof(struct can_frame, can_dlc) !=
+		     offsetof(struct canfd_frame, len));
+
 	printk(banner);
 
 	memset(&can_rx_alldev_list, 0, sizeof(can_rx_alldev_list));
@@ -846,6 +900,7 @@ static __init int can_init(void)
 	sock_register(&can_family_ops);
 	register_netdevice_notifier(&can_netdev_notifier);
 	dev_add_pack(&can_packet);
+	dev_add_pack(&canfd_packet);
 
 	return 0;
 }
@@ -860,6 +915,7 @@ static __exit void can_exit(void)
 	can_remove_proc();
 
 	/* protocol unregister */
+	dev_remove_pack(&canfd_packet);
 	dev_remove_pack(&can_packet);
 	unregister_netdevice_notifier(&can_netdev_notifier);
 	sock_unregister(PF_CAN);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 151b773..98b5604 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1357,6 +1357,13 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 
 	switch (msg) {
 
+	case NETDEV_CHANGEMTU:
+		/*
+		 * Changing the MTU breaks the frame size that was formerly
+		 * registered. The change can only be done when the interface
+		 * ist down. Btw. make sure to get no trash from the device and
+		 * drop this device from the open sockets perspective.
+		 */
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 
diff --git a/net/can/gw.c b/net/can/gw.c
index b41acf2..f0c0b88 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -424,7 +424,7 @@ static int cgw_notifier(struct notifier_block *nb,
 	if (dev->type != ARPHRD_CAN)
 		return NOTIFY_DONE;
 
-	if (msg == NETDEV_UNREGISTER) {
+	if (msg == NETDEV_UNREGISTER || msg == NETDEV_CHANGEMTU) {
 
 		struct cgw_job *gwj = NULL;
 		struct hlist_node *n, *nx;
diff --git a/net/can/raw.c b/net/can/raw.c
index cde1b4a..a20ee8e 100644
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
@@ -119,6 +120,14 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (!ro->recv_own_msgs && oskb->sk == sk)
 		return;
 
+	/* do not pass frames with DLC > 8 to a legacy socket */
+	if (!ro->fd_frames) {
+		struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
+
+		if (unlikely(cfd->len > CAN_MAX_DLEN))
+			return;
+	}
+
 	/* clone the given skb to be able to enqueue it into the rcv queue */
 	skb = skb_clone(oskb, GFP_ATOMIC);
 	if (!skb)
@@ -246,6 +255,13 @@ static int raw_notifier(struct notifier_block *nb,
 
 	switch (msg) {
 
+	case NETDEV_CHANGEMTU:
+		/*
+		 * Changing the MTU breaks the frame size that was formerly
+		 * registered. The change can only be done when the interface
+		 * ist down. Btw. make sure to get no trash from the device and
+		 * drop this device from the open sockets perspective.
+		 */
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
 		/* remove current filters & unregister */
@@ -291,6 +307,7 @@ static int raw_init(struct sock *sk)
 	/* set default loopback behaviour */
 	ro->loopback         = 1;
 	ro->recv_own_msgs    = 0;
+	ro->fd_frames        = 0;
 
 	/* set notifier */
 	ro->notifier.notifier_call = raw_notifier;
@@ -569,6 +586,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
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
@@ -627,6 +653,12 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
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
@@ -662,13 +694,24 @@ static int raw_sendmsg(struct kiocb *iocb, struct socket *sock,
 	} else
 		ifindex = ro->ifindex;
 
-	if (size != sizeof(struct can_frame))
-		return -EINVAL;
+	if (ro->fd_frames) {
+		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
+			return -EINVAL;
+	} else {
+		if (unlikely(size != CAN_MTU))
+			return -EINVAL;
+	}
 
 	dev = dev_get_by_index(&init_net, ifindex);
 	if (!dev)
 		return -ENXIO;
 
+	/* make sure the created CAN frame can pass the CAN netdevice */
+	if (unlikely(size > dev->mtu)) {
+		err = -EMSGSIZE;
+		goto put_dev;
+	}
+
 	skb = sock_alloc_send_skb(sk, size, msg->msg_flags & MSG_DONTWAIT,
 				  &err);
 	if (!skb)
@@ -708,7 +751,9 @@ static int raw_recvmsg(struct kiocb *iocb, struct socket *sock,
 		       struct msghdr *msg, size_t size, int flags)
 {
 	struct sock *sk = sock->sk;
+	struct raw_sock *ro = raw_sk(sk);
 	struct sk_buff *skb;
+	int rxmtu;
 	int err = 0;
 	int noblock;
 
@@ -719,10 +764,20 @@ static int raw_recvmsg(struct kiocb *iocb, struct socket *sock,
 	if (!skb)
 		return err;
 
-	if (size < skb->len)
+	/*
+	 * when serving a legacy socket the DLC <= 8 is already checked inside
+	 * raw_rcv(). Now check if we need to pass a canfd_frame to a legacy
+	 * socket and cut the possible CANFD_MTU/CAN_MTU length to CAN_MTU
+	 */
+	if (!ro->fd_frames)
+		rxmtu = CAN_MTU;
+	else
+		rxmtu = skb->len;
+
+	if (size < rxmtu)
 		msg->msg_flags |= MSG_TRUNC;
 	else
-		size = skb->len;
+		size = rxmtu;
 
 	err = memcpy_toiovec(msg->msg_iov, skb->data, size);
 	if (err < 0) {


