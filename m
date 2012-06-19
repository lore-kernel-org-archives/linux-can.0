From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 1/6] canfd: add new data structures and constants
Date: Tue, 19 Jun 2012 21:19:10 +0200
Message-ID: <4FE0D0AE.3010500@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:36292 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab2FSTTN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 Jun 2012 15:19:13 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

From d8976f0565e1d1c354c4ac0025b4ced7c4810e77 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Wed, 13 Jun 2012 20:04:33 +0200
Subject: [PATCH 1/6] canfd: add new data structures and constants

- add new struct canfd_frame
- check identical element offsets in struct can_frame and struct canfd_frame
- new ETH_P_CANFD definition to tag CAN FD skbs correctly
- add CAN_MTU and CANFD_MTU definitions for easy frame and mode detection
- add CAN[FD]_MAX_[DLC|DLEN] helper constants to remove hard coded values
- update existing struct can_frame with helper constants and comments

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can.h      |   59 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/if_ether.h |    3 ++-
 net/can/af_can.c         |    7 ++++++
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/include/linux/can.h b/include/linux/can.h
index 17334c0..1a66cf61 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -46,18 +46,67 @@ typedef __u32 canid_t;
  */
 typedef __u32 can_err_mask_t;
 
+/* CAN payload length and DLC definitions according to ISO 11898-1 */
+#define CAN_MAX_DLC 8
+#define CAN_MAX_DLEN 8
+
+/* CAN FD payload length and DLC definitions according to ISO 11898-7 */
+#define CANFD_MAX_DLC 15
+#define CANFD_MAX_DLEN 64
+
 /**
  * struct can_frame - basic CAN frame structure
- * @can_id:  the CAN ID of the frame and CAN_*_FLAG flags, see above.
- * @can_dlc: the data length field of the CAN frame
- * @data:    the CAN frame payload.
+ * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
+ * @can_dlc: frame payload length in byte (0 .. 8) aka data length code
+ *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
+ *           mapping of the 'data length code' to the real payload length
+ * @data:    CAN frame payload (up to 8 byte)
  */
 struct can_frame {
 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
-	__u8    can_dlc; /* data length code: 0 .. 8 */
-	__u8    data[8] __attribute__((aligned(8)));
+	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
+	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
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
+ * @can_id: CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
+ * @len:    frame payload length in byte (0 .. CANFD_MAX_DLEN)
+ * @flags:  additional flags for CAN FD
+ * @__res0: reserved / padding
+ * @__res1: reserved / padding
+ * @data:   CAN FD frame payload (up to CANFD_MAX_DLEN byte)
+ */
+struct canfd_frame {
+	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
+	__u8    len;     /* frame payload length in byte */
+	__u8    flags;   /* additional flags for CAN FD */
+	__u8    __res0;  /* reserved / padding */
+	__u8    __res1;  /* reserved / padding */
+	__u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
+};
+
+#define CAN_MTU		(sizeof(struct can_frame))
+#define CANFD_MTU	(sizeof(struct canfd_frame))
+
 /* particular protocols of the protocol family PF_CAN */
 #define CAN_RAW		1 /* RAW sockets */
 #define CAN_BCM		2 /* Broadcast Manager */
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 56d907a..167ce5b 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -105,7 +105,8 @@
 #define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP frames*/
 #define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP frames */
 #define ETH_P_LOCALTALK 0x0009		/* Localtalk pseudo type 	*/
-#define ETH_P_CAN	0x000C		/* Controller Area Network      */
+#define ETH_P_CAN	0x000C		/* CAN: Controller Area Network */
+#define ETH_P_CANFD	0x000D		/* CANFD: CAN flexible data rate*/
 #define ETH_P_PPPTALK	0x0010		/* Dummy type for Atalk over PPP*/
 #define ETH_P_TR_802_2	0x0011		/* 802.2 frames 		*/
 #define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 6efcd37..c96140a 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -41,6 +41,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/stddef.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
@@ -824,6 +825,12 @@ static struct notifier_block can_netdev_notifier __read_mostly = {
 
 static __init int can_init(void)
 {
+	/* check for correct padding to be able to use the structs similarly */
+	BUILD_BUG_ON(offsetof(struct can_frame, can_dlc) !=
+		     offsetof(struct canfd_frame, len) ||
+		     offsetof(struct can_frame, data) !=
+		     offsetof(struct canfd_frame, data));
+
 	printk(banner);
 
 	memset(&can_rx_alldev_list, 0, sizeof(can_rx_alldev_list));
-- 
1.7.10.4


