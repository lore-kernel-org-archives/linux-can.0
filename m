From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6 5/5] include: Move includes from include/socketcan to include/linux
Date: Fri, 17 Jan 2014 15:48:51 +0100
Message-ID: <1389970131-9350-6-git-send-email-mkl@pengutronix.de>
References: <1389970131-9350-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43990 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbaAQOsz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2014 09:48:55 -0500
In-Reply-To: <1389970131-9350-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

This makes it possible to import header from the kernel more easily, e.=
g.:

	cd $path_to_linux_repo
	make headers_install
	rsync -a --exclude .\* usr/include/linux/can* $path_to_can_utils/inclu=
de/linux

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 GNUmakefile.am                  |   9 +--
 include/linux/can.h             | 168 ++++++++++++++++++++++++++++++++=
++++++-
 include/linux/can/bcm.h         |  67 +++++++++++++++-
 include/linux/can/error.h       |  92 ++++++++++++++++++++-
 include/linux/can/gw.h          | 172 ++++++++++++++++++++++++++++++++=
+++++++-
 include/linux/can/isotp.h       | 141 +++++++++++++++++++++++++++++++-
 include/linux/can/netlink.h     | 123 +++++++++++++++++++++++++++-
 include/linux/can/raw.h         |  31 +++++++-
 include/socketcan/can.h         | 167 --------------------------------=
------
 include/socketcan/can/bcm.h     |  66 ---------------
 include/socketcan/can/error.h   |  91 ---------------------
 include/socketcan/can/gw.h      | 171 --------------------------------=
-------
 include/socketcan/can/isotp.h   | 140 --------------------------------
 include/socketcan/can/netlink.h | 122 ----------------------------
 include/socketcan/can/raw.h     |  30 -------
 15 files changed, 788 insertions(+), 802 deletions(-)
 delete mode 100644 include/socketcan/can.h
 delete mode 100644 include/socketcan/can/bcm.h
 delete mode 100644 include/socketcan/can/error.h
 delete mode 100644 include/socketcan/can/gw.h
 delete mode 100644 include/socketcan/can/isotp.h
 delete mode 100644 include/socketcan/can/netlink.h
 delete mode 100644 include/socketcan/can/raw.h

diff --git a/GNUmakefile.am b/GNUmakefile.am
index 9b30d9c..630a69a 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -16,14 +16,7 @@ noinst_HEADERS =3D \
 	include/linux/can.h \
 	include/linux/can/isotp.h \
 	include/linux/can/netlink.h \
-	include/linux/can/raw.h \
-	include/socketcan/can/bcm.h \
-	include/socketcan/can/error.h \
-	include/socketcan/can/gw.h \
-	include/socketcan/can.h \
-	include/socketcan/can/isotp.h \
-	include/socketcan/can/netlink.h \
-	include/socketcan/can/raw.h
+	include/linux/can/raw.h
=20
=20
 noinst_LTLIBRARIES =3D \
diff --git a/include/linux/can.h b/include/linux/can.h
index 958a3f4..8452f0e 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -1 +1,167 @@
-#include <socketcan/can.h>
+/*
+ * socketcan/can.h
+ *
+ * Definitions for CAN network layer (socket addr / CAN frame / CAN fi=
lter)
+ *
+ * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ *          Urs Thuermann   <urs.thuermann@volkswagen.de>
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ */
+
+#ifndef CAN_H
+#define CAN_H
+
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/socket.h>
+
+/* controller area network (CAN) kernel definitions */
+
+/* special address description flags for the CAN_ID */
+#define CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
+#define CAN_RTR_FLAG 0x40000000U /* remote transmission request */
+#define CAN_ERR_FLAG 0x20000000U /* error message frame */
+
+/* valid bits in CAN ID for frame formats */
+#define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
+#define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
+#define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
+
+/*
+ * Controller Area Network Identifier structure
+ *
+ * bit 0-28	: CAN identifier (11/29 bit)
+ * bit 29	: error message frame flag (0 =3D data frame, 1 =3D error me=
ssage)
+ * bit 30	: remote transmission request flag (1 =3D rtr frame)
+ * bit 31	: frame format flag (0 =3D standard 11 bit, 1 =3D extended 2=
9 bit)
+ */
+typedef __u32 canid_t;
+
+#define CAN_SFF_ID_BITS		11
+#define CAN_EFF_ID_BITS		29
+
+/*
+ * Controller Area Network Error Message Frame Mask structure
+ *
+ * bit 0-28	: error class mask (see include/socketcan/can/error.h)
+ * bit 29-31	: set to zero
+ */
+typedef __u32 can_err_mask_t;
+
+/* CAN payload length and DLC definitions according to ISO 11898-1 */
+#define CAN_MAX_DLC 8
+#define CAN_MAX_DLEN 8
+
+/* CAN FD payload length and DLC definitions according to ISO 11898-7 =
*/
+#define CANFD_MAX_DLC 15
+#define CANFD_MAX_DLEN 64
+
+/**
+ * struct can_frame - basic CAN frame structure
+ * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t def=
inition
+ * @can_dlc: frame payload length in byte (0 .. 8) aka data length cod=
e
+ *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a=
 1:1
+ *           mapping of the 'data length code' to the real payload len=
gth
+ * @data:    CAN frame payload (up to 8 byte)
+ */
+struct can_frame {
+	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
+	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) =
*/
+	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
+};
+
+/*
+ * defined bits for canfd_frame.flags
+ *
+ * The use of struct canfd_frame implies the Extended Data Length (EDL=
) bit to
+ * be set in the CAN frame bitstream on the wire. The EDL bit switch t=
urns
+ * the CAN controllers bitstream processor into the CAN FD mode which =
creates
+ * two new options within the CAN FD frame specification:
+ *
+ * Bit Rate Switch - to indicate a second bitrate is/was used for the =
payload
+ * Error State Indicator - represents the error state of the transmitt=
ing node
+ *
+ * As the CANFD_ESI bit is internally generated by the transmitting CA=
N
+ * controller only the CANFD_BRS bit is relevant for real CAN controll=
ers when
+ * building a CAN FD frame for transmission. Setting the CANFD_ESI bit=
 can make
+ * sense for virtual CAN interfaces to test applications with echoed f=
rames.
+ */
+#define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload =
data) */
+#define CANFD_ESI 0x02 /* error state indicator of the transmitting no=
de */
+
+/**
+ * struct canfd_frame - CAN flexible data rate frame structure
+ * @can_id: CAN ID of the frame and CAN_*_FLAG flags, see canid_t defi=
nition
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
+/* particular protocols of the protocol family PF_CAN */
+#define CAN_RAW		1 /* RAW sockets */
+#define CAN_BCM		2 /* Broadcast Manager */
+#define CAN_TP16	3 /* VAG Transport Protocol v1.6 */
+#define CAN_TP20	4 /* VAG Transport Protocol v2.0 */
+#define CAN_MCNET	5 /* Bosch MCNet */
+#define CAN_ISOTP	6 /* ISO 15765-2 Transport Protocol */
+#define CAN_NPROTO	7
+
+#define SOL_CAN_BASE 100
+
+// typedef unsigned short __kernel_sa_family_t;
+// introduced in Linux 3.2 commit 6602a4baf4d1a73cc4685a39ef859e1c5ddf=
654c
+
+/**
+ * struct sockaddr_can - the sockaddr structure for CAN sockets
+ * @can_family:  address family number AF_CAN.
+ * @can_ifindex: CAN network interface index.
+ * @can_addr:    protocol specific address information
+ */
+struct sockaddr_can {
+	sa_family_t can_family;
+//	__kernel_sa_family_t can_family;
+	int         can_ifindex;
+	union {
+		/* transport protocol class address information (e.g. ISOTP) */
+		struct { canid_t rx_id, tx_id; } tp;
+
+		/* reserved for future CAN protocols address information */
+	} can_addr;
+};
+
+/**
+ * struct can_filter - CAN ID based filter in can_register().
+ * @can_id:   relevant bits of CAN ID which are not masked out.
+ * @can_mask: CAN mask (see description)
+ *
+ * Description:
+ * A filter matches, when
+ *
+ *          <received_can_id> & mask =3D=3D can_id & mask
+ *
+ * The filter can be inverted (CAN_INV_FILTER bit set in can_id) or it=
 can
+ * filter for error message frames (CAN_ERR_FLAG bit set in mask).
+ */
+struct can_filter {
+	canid_t can_id;
+	canid_t can_mask;
+};
+
+#define CAN_INV_FILTER 0x20000000U /* to be set in can_filter.can_id *=
/
+
+#endif /* CAN_H */
diff --git a/include/linux/can/bcm.h b/include/linux/can/bcm.h
index 6d61559..f10af82 100644
--- a/include/linux/can/bcm.h
+++ b/include/linux/can/bcm.h
@@ -1 +1,66 @@
-#include <socketcan/can/bcm.h>
+/*
+ * socketcan/can/bcm.h
+ *
+ * Definitions for CAN Broadcast Manager (BCM)
+ *
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ */
+
+#ifndef CAN_BCM_H
+#define CAN_BCM_H
+
+#include <linux/types.h>
+#include <linux/can.h>
+
+/**
+ * struct bcm_msg_head - head of messages to/from the broadcast manage=
r
+ * @opcode:    opcode, see enum below.
+ * @flags:     special flags, see below.
+ * @count:     number of frames to send before changing interval.
+ * @ival1:     interval for the first @count frames.
+ * @ival2:     interval for the following frames.
+ * @can_id:    CAN ID of frames to be sent or received.
+ * @nframes:   number of frames appended to the message head.
+ * @frames:    array of CAN frames.
+ */
+struct bcm_msg_head {
+	__u32 opcode;
+	__u32 flags;
+	__u32 count;
+	struct timeval ival1, ival2;
+	canid_t can_id;
+	__u32 nframes;
+	struct can_frame frames[0];
+};
+
+enum {
+	TX_SETUP =3D 1,	/* create (cyclic) transmission task */
+	TX_DELETE,	/* remove (cyclic) transmission task */
+	TX_READ,	/* read properties of (cyclic) transmission task */
+	TX_SEND,	/* send one CAN frame */
+	RX_SETUP,	/* create RX content filter subscription */
+	RX_DELETE,	/* remove RX content filter subscription */
+	RX_READ,	/* read properties of RX content filter subscription */
+	TX_STATUS,	/* reply to TX_READ request */
+	TX_EXPIRED,	/* notification on performed transmissions (count=3D0) */
+	RX_STATUS,	/* reply to RX_READ request */
+	RX_TIMEOUT,	/* cyclic message is absent */
+	RX_CHANGED	/* updated CAN frame (detected content change) */
+};
+
+#define SETTIMER            0x0001
+#define STARTTIMER          0x0002
+#define TX_COUNTEVT         0x0004
+#define TX_ANNOUNCE         0x0008
+#define TX_CP_CAN_ID        0x0010
+#define RX_FILTER_ID        0x0020
+#define RX_CHECK_DLC        0x0040
+#define RX_NO_AUTOTIMER     0x0080
+#define RX_ANNOUNCE_RESUME  0x0100
+#define TX_RESET_MULTI_IDX  0x0200
+#define RX_RTR_FRAME        0x0400
+
+#endif /* CAN_BCM_H */
diff --git a/include/linux/can/error.h b/include/linux/can/error.h
index a02b1ca..b65c231 100644
--- a/include/linux/can/error.h
+++ b/include/linux/can/error.h
@@ -1 +1,91 @@
-#include <socketcan/can/error.h>
+/*
+ * socketcan/can/error.h
+ *
+ * Definitions of the CAN error messages to be filtered and passed to =
the user.
+ *
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ */
+
+#ifndef CAN_ERROR_H
+#define CAN_ERROR_H
+
+#define CAN_ERR_DLC 8 /* dlc for error message frames */
+
+/* error class (mask) in can_id */
+#define CAN_ERR_TX_TIMEOUT   0x00000001U /* TX timeout (by netdevice d=
river) */
+#define CAN_ERR_LOSTARB      0x00000002U /* lost arbitration    / data=
[0]    */
+#define CAN_ERR_CRTL         0x00000004U /* controller problems / data=
[1]    */
+#define CAN_ERR_PROT         0x00000008U /* protocol violations / data=
[2..3] */
+#define CAN_ERR_TRX          0x00000010U /* transceiver status  / data=
[4]    */
+#define CAN_ERR_ACK          0x00000020U /* received no ACK on transmi=
ssion */
+#define CAN_ERR_BUSOFF       0x00000040U /* bus off */
+#define CAN_ERR_BUSERROR     0x00000080U /* bus error (may flood!) */
+#define CAN_ERR_RESTARTED    0x00000100U /* controller restarted */
+
+/* arbitration lost in bit ... / data[0] */
+#define CAN_ERR_LOSTARB_UNSPEC   0x00 /* unspecified */
+				      /* else bit number in bitstream */
+
+/* error status of CAN-controller / data[1] */
+#define CAN_ERR_CRTL_UNSPEC      0x00 /* unspecified */
+#define CAN_ERR_CRTL_RX_OVERFLOW 0x01 /* RX buffer overflow */
+#define CAN_ERR_CRTL_TX_OVERFLOW 0x02 /* TX buffer overflow */
+#define CAN_ERR_CRTL_RX_WARNING  0x04 /* reached warning level for RX =
errors */
+#define CAN_ERR_CRTL_TX_WARNING  0x08 /* reached warning level for TX =
errors */
+#define CAN_ERR_CRTL_RX_PASSIVE  0x10 /* reached error passive status =
RX */
+#define CAN_ERR_CRTL_TX_PASSIVE  0x20 /* reached error passive status =
TX */
+				      /* (at least one error counter exceeds */
+				      /* the protocol-defined level of 127)  */
+
+/* error in CAN protocol (type) / data[2] */
+#define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */
+#define CAN_ERR_PROT_BIT         0x01 /* single bit error */
+#define CAN_ERR_PROT_FORM        0x02 /* frame format error */
+#define CAN_ERR_PROT_STUFF       0x04 /* bit stuffing error */
+#define CAN_ERR_PROT_BIT0        0x08 /* unable to send dominant bit *=
/
+#define CAN_ERR_PROT_BIT1        0x10 /* unable to send recessive bit =
*/
+#define CAN_ERR_PROT_OVERLOAD    0x20 /* bus overload */
+#define CAN_ERR_PROT_ACTIVE      0x40 /* active error announcement */
+#define CAN_ERR_PROT_TX          0x80 /* error occurred on transmissio=
n */
+
+/* error in CAN protocol (location) / data[3] */
+#define CAN_ERR_PROT_LOC_UNSPEC  0x00 /* unspecified */
+#define CAN_ERR_PROT_LOC_SOF     0x03 /* start of frame */
+#define CAN_ERR_PROT_LOC_ID28_21 0x02 /* ID bits 28 - 21 (SFF: 10 - 3)=
 */
+#define CAN_ERR_PROT_LOC_ID20_18 0x06 /* ID bits 20 - 18 (SFF: 2 - 0 )=
*/
+#define CAN_ERR_PROT_LOC_SRTR    0x04 /* substitute RTR (SFF: RTR) */
+#define CAN_ERR_PROT_LOC_IDE     0x05 /* identifier extension */
+#define CAN_ERR_PROT_LOC_ID17_13 0x07 /* ID bits 17-13 */
+#define CAN_ERR_PROT_LOC_ID12_05 0x0F /* ID bits 12-5 */
+#define CAN_ERR_PROT_LOC_ID04_00 0x0E /* ID bits 4-0 */
+#define CAN_ERR_PROT_LOC_RTR     0x0C /* RTR */
+#define CAN_ERR_PROT_LOC_RES1    0x0D /* reserved bit 1 */
+#define CAN_ERR_PROT_LOC_RES0    0x09 /* reserved bit 0 */
+#define CAN_ERR_PROT_LOC_DLC     0x0B /* data length code */
+#define CAN_ERR_PROT_LOC_DATA    0x0A /* data section */
+#define CAN_ERR_PROT_LOC_CRC_SEQ 0x08 /* CRC sequence */
+#define CAN_ERR_PROT_LOC_CRC_DEL 0x18 /* CRC delimiter */
+#define CAN_ERR_PROT_LOC_ACK     0x19 /* ACK slot */
+#define CAN_ERR_PROT_LOC_ACK_DEL 0x1B /* ACK delimiter */
+#define CAN_ERR_PROT_LOC_EOF     0x1A /* end of frame */
+#define CAN_ERR_PROT_LOC_INTERM  0x12 /* intermission */
+
+/* error status of CAN-transceiver / data[4] */
+/*                                             CANH CANL */
+#define CAN_ERR_TRX_UNSPEC             0x00 /* 0000 0000 */
+#define CAN_ERR_TRX_CANH_NO_WIRE       0x04 /* 0000 0100 */
+#define CAN_ERR_TRX_CANH_SHORT_TO_BAT  0x05 /* 0000 0101 */
+#define CAN_ERR_TRX_CANH_SHORT_TO_VCC  0x06 /* 0000 0110 */
+#define CAN_ERR_TRX_CANH_SHORT_TO_GND  0x07 /* 0000 0111 */
+#define CAN_ERR_TRX_CANL_NO_WIRE       0x40 /* 0100 0000 */
+#define CAN_ERR_TRX_CANL_SHORT_TO_BAT  0x50 /* 0101 0000 */
+#define CAN_ERR_TRX_CANL_SHORT_TO_VCC  0x60 /* 0110 0000 */
+#define CAN_ERR_TRX_CANL_SHORT_TO_GND  0x70 /* 0111 0000 */
+#define CAN_ERR_TRX_CANL_SHORT_TO_CANH 0x80 /* 1000 0000 */
+
+/* controller specific additional information / data[5..7] */
+
+#endif /* CAN_ERROR_H */
diff --git a/include/linux/can/gw.h b/include/linux/can/gw.h
index f37dbf0..f709809 100644
--- a/include/linux/can/gw.h
+++ b/include/linux/can/gw.h
@@ -1 +1,171 @@
-#include <socketcan/can/gw.h>
+/*
+ * socketcan/can/gw.h
+ *
+ * Definitions for CAN frame Gateway/Router/Bridge
+ *
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ * Copyright (c) 2011 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ */
+
+#ifndef CAN_GW_H
+#define CAN_GW_H
+
+#include <linux/types.h>
+#include <linux/can.h>
+
+struct rtcanmsg {
+	__u8  can_family;
+	__u8  gwtype;
+	__u16 flags;
+};
+
+/* CAN gateway types */
+enum {
+	CGW_TYPE_UNSPEC,
+	CGW_TYPE_CAN_CAN,	/* CAN->CAN routing */
+	__CGW_TYPE_MAX
+};
+
+#define CGW_TYPE_MAX (__CGW_TYPE_MAX - 1)
+
+/* CAN rtnetlink attribute definitions */
+enum {
+	CGW_UNSPEC,
+	CGW_MOD_AND,	/* CAN frame modification binary AND */
+	CGW_MOD_OR,	/* CAN frame modification binary OR */
+	CGW_MOD_XOR,	/* CAN frame modification binary XOR */
+	CGW_MOD_SET,	/* CAN frame modification set alternate values */
+	CGW_CS_XOR,	/* set data[] XOR checksum into data[index] */
+	CGW_CS_CRC8,	/* set data[] CRC8 checksum into data[index] */
+	CGW_HANDLED,	/* number of handled CAN frames */
+	CGW_DROPPED,	/* number of dropped CAN frames */
+	CGW_SRC_IF,	/* ifindex of source network interface */
+	CGW_DST_IF,	/* ifindex of destination network interface */
+	CGW_FILTER,	/* specify struct can_filter on source CAN device */
+	CGW_DELETED,	/* number of deleted CAN frames (see max_hops param) */
+	CGW_LIM_HOPS,	/* limit the number of hops of this specific rule */
+	__CGW_MAX
+};
+
+#define CGW_MAX (__CGW_MAX - 1)
+
+#define CGW_FLAGS_CAN_ECHO 0x01
+#define CGW_FLAGS_CAN_SRC_TSTAMP 0x02
+#define CGW_FLAGS_CAN_IIF_TX_OK 0x04
+
+#define CGW_MOD_FUNCS 4 /* AND OR XOR SET */
+
+/* CAN frame elements that are affected by curr. 3 CAN frame modificat=
ions */
+#define CGW_MOD_ID	0x01
+#define CGW_MOD_DLC	0x02
+#define CGW_MOD_DATA	0x04
+
+#define CGW_FRAME_MODS 3 /* ID DLC DATA */
+
+#define MAX_MODFUNCTIONS (CGW_MOD_FUNCS * CGW_FRAME_MODS)
+
+struct cgw_frame_mod {
+	struct can_frame cf;
+	__u8 modtype;
+} __attribute__((packed));
+
+#define CGW_MODATTR_LEN sizeof(struct cgw_frame_mod)
+
+struct cgw_csum_xor {
+	__s8 from_idx;
+	__s8 to_idx;
+	__s8 result_idx;
+	__u8 init_xor_val;
+} __attribute__((packed));
+
+struct cgw_csum_crc8 {
+	__s8 from_idx;
+	__s8 to_idx;
+	__s8 result_idx;
+	__u8 init_crc_val;
+	__u8 final_xor_val;
+	__u8 crctab[256];
+	__u8 profile;
+	__u8 profile_data[20];
+} __attribute__((packed));
+
+/* length of checksum operation parameters. idx =3D index in CAN frame=
 data[] */
+#define CGW_CS_XOR_LEN  sizeof(struct cgw_csum_xor)
+#define CGW_CS_CRC8_LEN  sizeof(struct cgw_csum_crc8)
+
+/* CRC8 profiles (compute CRC for additional data elements - see below=
) */
+enum {
+	CGW_CRC8PRF_UNSPEC,
+	CGW_CRC8PRF_1U8,	/* compute one additional u8 value */
+	CGW_CRC8PRF_16U8,	/* u8 value table indexed by data[1] & 0xF */
+	CGW_CRC8PRF_SFFID_XOR,	/* (can_id & 0xFF) ^ (can_id >> 8 & 0xFF) */
+	__CGW_CRC8PRF_MAX
+};
+
+#define CGW_CRC8PRF_MAX (__CGW_CRC8PRF_MAX - 1)
+
+/*
+ * CAN rtnetlink attribute contents in detail
+ *
+ * CGW_XXX_IF (length 4 bytes):
+ * Sets an interface index for source/destination network interfaces.
+ * For the CAN->CAN gwtype the indices of _two_ CAN interfaces are man=
datory.
+ *
+ * CGW_FILTER (length 8 bytes):
+ * Sets a CAN receive filter for the gateway job specified by the
+ * struct can_filter described in include/linux/can.h
+ *
+ * CGW_MOD_(AND|OR|XOR|SET) (length 17 bytes):
+ * Specifies a modification that's done to a received CAN frame before=
 it is
+ * send out to the destination interface.
+ *
+ * <struct can_frame> data used as operator
+ * <u8> affected CAN frame elements
+ *
+ * CGW_LIM_HOPS (length 1 byte):
+ * Limit the number of hops of this specific rule. Usually the receive=
d CAN
+ * frame can be processed as much as 'max_hops' times (which is given =
at module
+ * load time of the can-gw module). This value is used to reduce the n=
umber of
+ * possible hops for this gateway job to a value smaller then max_hops=
=2E
+ *
+ * CGW_CS_XOR (length 4 bytes):
+ * Set a simple XOR checksum starting with an initial value into
+ * data[result-idx] using data[start-idx] .. data[end-idx]
+ *
+ * The XOR checksum is calculated like this:
+ *
+ * xor =3D init_xor_val
+ *
+ * for (i =3D from_idx .. to_idx)
+ *      xor ^=3D can_frame.data[i]
+ *
+ * can_frame.data[ result_idx ] =3D xor
+ *
+ * CGW_CS_CRC8 (length 282 bytes):
+ * Set a CRC8 value into data[result-idx] using a given 256 byte CRC8 =
table,
+ * a given initial value and a defined input data[start-idx] .. data[e=
nd-idx].
+ * Finally the result value is XOR'ed with the final_xor_val.
+ *
+ * The CRC8 checksum is calculated like this:
+ *
+ * crc =3D init_crc_val
+ *
+ * for (i =3D from_idx .. to_idx)
+ *      crc =3D crctab[ crc ^ can_frame.data[i] ]
+ *
+ * can_frame.data[ result_idx ] =3D crc ^ final_xor_val
+ *
+ * The calculated CRC may contain additional source data elements that=
 can be
+ * defined in the handling of 'checksum profiles' e.g. shown in AUTOSA=
R specs
+ * like http://www.autosar.org/download/R4.0/AUTOSAR_SWS_E2ELibrary.pd=
f
+ * E.g. the profile_data[] may contain additional u8 values (called DA=
TA_IDs)
+ * that are used depending on counter values inside the CAN frame data=
[].
+ * So far only three profiles have been implemented for illustration.
+ *
+ * Remark: In general the attribute data is a linear buffer.
+ *         Beware of sending unpacked or aligned structs!
+ */
+
+#endif
diff --git a/include/linux/can/isotp.h b/include/linux/can/isotp.h
index c52850f..18d13d1 100644
--- a/include/linux/can/isotp.h
+++ b/include/linux/can/isotp.h
@@ -1 +1,140 @@
-#include <socketcan/can/isotp.h>
+/*
+ * socketcan/can/isotp.h
+ *
+ * Definitions for isotp CAN sockets
+ *
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ * Copyright (c) 2008 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this sof=
tware
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of t=
he
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible lice=
nse.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS F=
OR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGH=
T
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTA=
L,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF US=
E,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON A=
NY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * Send feedback to <linux-can@vger.kernel.org>
+ */
+
+#ifndef CAN_ISOTP_H
+#define CAN_ISOTP_H
+
+#include <linux/can.h>
+
+#define SOL_CAN_ISOTP (SOL_CAN_BASE + CAN_ISOTP)
+
+/* for socket options affecting the socket (not the global system) */
+
+#define CAN_ISOTP_OPTS		1	/* pass struct can_isotp_options */
+
+#define CAN_ISOTP_RECV_FC	2	/* pass struct can_isotp_fc_options */
+
+/* sockopts to force stmin timer values for protocol regression tests =
*/
+
+#define CAN_ISOTP_TX_STMIN	3	/* pass __u32 value in nano secs    */
+					/* use this time instead of value   */
+					/* provided in FC from the receiver */
+
+#define CAN_ISOTP_RX_STMIN	4	/* pass __u32 value in nano secs   */
+					/* ignore received CF frames which */
+					/* timestamps differ less than val */
+
+struct can_isotp_options {
+
+	__u32 flags;		/* set flags for isotp behaviour.	*/
+				/* __u32 value : flags see below	*/
+
+	__u32 frame_txtime;	/* frame transmission time (N_As/N_Ar)	*/
+				/* __u32 value : time in nano secs	*/
+
+	__u8  ext_address;	/* set address for extended addressing	*/
+				/* __u8 value : extended address	*/
+
+	__u8  txpad_content;	/* set content of padding byte (tx)	*/
+				/* __u8 value : content	on tx path	*/
+
+	__u8  rxpad_content;	/* set content of padding byte (rx)	*/
+				/* __u8 value : content	on rx path	*/
+};
+
+struct can_isotp_fc_options {
+
+	__u8  bs;		/* blocksize provided in FC frame	*/
+				/* __u8 value : blocksize. 0 =3D off	*/
+
+	__u8  stmin;		/* separation time provided in FC frame	*/
+				/* __u8 value :				*/
+				/* 0x00 - 0x7F : 0 - 127 ms		*/
+				/* 0x80 - 0xF0 : reserved		*/
+				/* 0xF1 - 0xF9 : 100 us - 900 us	*/
+				/* 0xFA - 0xFF : reserved		*/
+
+	__u8  wftmax;		/* max. number of wait frame transmiss.	*/
+				/* __u8 value : 0 =3D omit FC N_PDU WT	*/
+};
+
+
+/* flags for isotp behaviour */
+
+#define CAN_ISOTP_LISTEN_MODE	0x001	/* listen only (do not send FC) */
+#define CAN_ISOTP_EXTEND_ADDR	0x002	/* enable extended addressing */
+#define CAN_ISOTP_TX_PADDING	0x004	/* enable CAN frame padding tx path=
 */
+#define CAN_ISOTP_RX_PADDING	0x008	/* enable CAN frame padding rx path=
 */
+#define CAN_ISOTP_CHK_PAD_LEN	0x010	/* check received CAN frame paddin=
g */
+#define CAN_ISOTP_CHK_PAD_DATA	0x020	/* check received CAN frame paddi=
ng */
+#define CAN_ISOTP_HALF_DUPLEX	0x040	/* half duplex error state handlin=
g */
+#define CAN_ISOTP_FORCE_TXSTMIN	0x080	/* ignore stmin from received FC=
 */
+#define CAN_ISOTP_FORCE_RXSTMIN	0x100	/* ignore CFs depending on rx st=
min */
+
+
+/* default values */
+
+#define CAN_ISOTP_DEFAULT_FLAGS		0
+#define CAN_ISOTP_DEFAULT_EXT_ADDRESS	0x00
+#define CAN_ISOTP_DEFAULT_RXPAD_CONTENT	0x00
+#define CAN_ISOTP_DEFAULT_TXPAD_CONTENT	0x00
+#define CAN_ISOTP_DEFAULT_FRAME_TXTIME	0
+#define CAN_ISOTP_DEFAULT_RECV_BS	0
+#define CAN_ISOTP_DEFAULT_RECV_STMIN	0x00
+#define CAN_ISOTP_DEFAULT_RECV_WFTMAX	0
+
+/*
+ * Remark on CAN_ISOTP_DEFAULT_RECV_* values:
+ *
+ * We can strongly assume, that the Linux Kernel implementation of
+ * CAN_ISOTP is capable to run with BS=3D0, STmin=3D0 and WFTmax=3D0.
+ * But as we like to be able to behave as a commonly available ECU,
+ * these default settings can be changed via sockopts.
+ * For that reason the STmin value is intentionally _not_ checked for
+ * consistency and copied directly into the flow control (FC) frame.
+ *
+ */
+
+#endif
diff --git a/include/linux/can/netlink.h b/include/linux/can/netlink.h
index 99425f9..9bb47e3 100644
--- a/include/linux/can/netlink.h
+++ b/include/linux/can/netlink.h
@@ -1 +1,122 @@
-#include <socketcan/can/netlink.h>
+/*
+ * socketcan/can/netlink.h
+ *
+ * Definitions for the CAN netlink interface
+ *
+ * Copyright (c) 2009 Wolfgang Grandegger <wg@grandegger.com>
+ *
+ */
+
+#ifndef CAN_NETLINK_H
+#define CAN_NETLINK_H
+
+#include <linux/types.h>
+
+/*
+ * CAN bit-timing parameters
+ *
+ * For further information, please read chapter "8 BIT TIMING
+ * REQUIREMENTS" of the "Bosch CAN Specification version 2.0"
+ * at http://www.semiconductors.bosch.de/pdf/can2spec.pdf.
+ */
+struct can_bittiming {
+	__u32 bitrate;		/* Bit-rate in bits/second */
+	__u32 sample_point;	/* Sample point in one-tenth of a percent */
+	__u32 tq;		/* Time quanta (TQ) in nanoseconds */
+	__u32 prop_seg;		/* Propagation segment in TQs */
+	__u32 phase_seg1;	/* Phase buffer segment 1 in TQs */
+	__u32 phase_seg2;	/* Phase buffer segment 2 in TQs */
+	__u32 sjw;		/* Synchronisation jump width in TQs */
+	__u32 brp;		/* Bit-rate prescaler */
+};
+
+/*
+ * CAN harware-dependent bit-timing constant
+ *
+ * Used for calculating and checking bit-timing parameters
+ */
+struct can_bittiming_const {
+	char name[16];		/* Name of the CAN controller hardware */
+	__u32 tseg1_min;	/* Time segement 1 =3D prop_seg + phase_seg1 */
+	__u32 tseg1_max;
+	__u32 tseg2_min;	/* Time segement 2 =3D phase_seg2 */
+	__u32 tseg2_max;
+	__u32 sjw_max;		/* Synchronisation jump width */
+	__u32 brp_min;		/* Bit-rate prescaler */
+	__u32 brp_max;
+	__u32 brp_inc;
+};
+
+/*
+ * CAN clock parameters
+ */
+struct can_clock {
+	__u32 freq;		/* CAN system clock frequency in Hz */
+};
+
+/*
+ * CAN operational and error states
+ */
+enum can_state {
+	CAN_STATE_ERROR_ACTIVE =3D 0,	/* RX/TX error count < 96 */
+	CAN_STATE_ERROR_WARNING,	/* RX/TX error count < 128 */
+	CAN_STATE_ERROR_PASSIVE,	/* RX/TX error count < 256 */
+	CAN_STATE_BUS_OFF,		/* RX/TX error count >=3D 256 */
+	CAN_STATE_STOPPED,		/* Device is stopped */
+	CAN_STATE_SLEEPING,		/* Device is sleeping */
+	CAN_STATE_MAX
+};
+
+/*
+ * CAN bus error counters
+ */
+struct can_berr_counter {
+	__u16 txerr;
+	__u16 rxerr;
+};
+
+/*
+ * CAN controller mode
+ */
+struct can_ctrlmode {
+	__u32 mask;
+	__u32 flags;
+};
+
+#define CAN_CTRLMODE_LOOPBACK		0x01	/* Loopback mode */
+#define CAN_CTRLMODE_LISTENONLY		0x02 	/* Listen-only mode */
+#define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
+#define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
+#define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
+
+/*
+ * CAN device statistics
+ */
+struct can_device_stats {
+	__u32 bus_error;	/* Bus errors */
+	__u32 error_warning;	/* Changes to error warning state */
+	__u32 error_passive;	/* Changes to error passive state */
+	__u32 bus_off;		/* Changes to bus off state */
+	__u32 arbitration_lost; /* Arbitration lost errors */
+	__u32 restarts;		/* CAN controller re-starts */
+};
+
+/*
+ * CAN netlink interface
+ */
+enum {
+	IFLA_CAN_UNSPEC,
+	IFLA_CAN_BITTIMING,
+	IFLA_CAN_BITTIMING_CONST,
+	IFLA_CAN_CLOCK,
+	IFLA_CAN_STATE,
+	IFLA_CAN_CTRLMODE,
+	IFLA_CAN_RESTART_MS,
+	IFLA_CAN_RESTART,
+	IFLA_CAN_BERR_COUNTER,
+	__IFLA_CAN_MAX
+};
+
+#define IFLA_CAN_MAX	(__IFLA_CAN_MAX - 1)
+
+#endif /* CAN_NETLINK_H */
diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
index 22a90e5..c80bff0 100644
--- a/include/linux/can/raw.h
+++ b/include/linux/can/raw.h
@@ -1 +1,30 @@
-#include <socketcan/can/raw.h>
+/*
+ * socketcan/can/raw.h
+ *
+ * Definitions for raw CAN sockets
+ *
+ * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ *          Urs Thuermann   <urs.thuermann@volkswagen.de>
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ */
+
+#ifndef CAN_RAW_H
+#define CAN_RAW_H
+
+#include <linux/can.h>
+
+#define SOL_CAN_RAW (SOL_CAN_BASE + CAN_RAW)
+
+/* for socket options affecting the socket (not the global system) */
+
+enum {
+	CAN_RAW_FILTER =3D 1,	/* set 0 .. n can_filter(s)          */
+	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
+	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
+	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
+	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
+};
+
+#endif
diff --git a/include/socketcan/can.h b/include/socketcan/can.h
deleted file mode 100644
index 8452f0e..0000000
--- a/include/socketcan/can.h
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * socketcan/can.h
- *
- * Definitions for CAN network layer (socket addr / CAN frame / CAN fi=
lter)
- *
- * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
- *          Urs Thuermann   <urs.thuermann@volkswagen.de>
- * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
- * All rights reserved.
- *
- */
-
-#ifndef CAN_H
-#define CAN_H
-
-#include <linux/version.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-
-/* controller area network (CAN) kernel definitions */
-
-/* special address description flags for the CAN_ID */
-#define CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
-#define CAN_RTR_FLAG 0x40000000U /* remote transmission request */
-#define CAN_ERR_FLAG 0x20000000U /* error message frame */
-
-/* valid bits in CAN ID for frame formats */
-#define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
-#define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
-#define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
-
-/*
- * Controller Area Network Identifier structure
- *
- * bit 0-28	: CAN identifier (11/29 bit)
- * bit 29	: error message frame flag (0 =3D data frame, 1 =3D error me=
ssage)
- * bit 30	: remote transmission request flag (1 =3D rtr frame)
- * bit 31	: frame format flag (0 =3D standard 11 bit, 1 =3D extended 2=
9 bit)
- */
-typedef __u32 canid_t;
-
-#define CAN_SFF_ID_BITS		11
-#define CAN_EFF_ID_BITS		29
-
-/*
- * Controller Area Network Error Message Frame Mask structure
- *
- * bit 0-28	: error class mask (see include/socketcan/can/error.h)
- * bit 29-31	: set to zero
- */
-typedef __u32 can_err_mask_t;
-
-/* CAN payload length and DLC definitions according to ISO 11898-1 */
-#define CAN_MAX_DLC 8
-#define CAN_MAX_DLEN 8
-
-/* CAN FD payload length and DLC definitions according to ISO 11898-7 =
*/
-#define CANFD_MAX_DLC 15
-#define CANFD_MAX_DLEN 64
-
-/**
- * struct can_frame - basic CAN frame structure
- * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t def=
inition
- * @can_dlc: frame payload length in byte (0 .. 8) aka data length cod=
e
- *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a=
 1:1
- *           mapping of the 'data length code' to the real payload len=
gth
- * @data:    CAN frame payload (up to 8 byte)
- */
-struct can_frame {
-	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
-	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) =
*/
-	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
-};
-
-/*
- * defined bits for canfd_frame.flags
- *
- * The use of struct canfd_frame implies the Extended Data Length (EDL=
) bit to
- * be set in the CAN frame bitstream on the wire. The EDL bit switch t=
urns
- * the CAN controllers bitstream processor into the CAN FD mode which =
creates
- * two new options within the CAN FD frame specification:
- *
- * Bit Rate Switch - to indicate a second bitrate is/was used for the =
payload
- * Error State Indicator - represents the error state of the transmitt=
ing node
- *
- * As the CANFD_ESI bit is internally generated by the transmitting CA=
N
- * controller only the CANFD_BRS bit is relevant for real CAN controll=
ers when
- * building a CAN FD frame for transmission. Setting the CANFD_ESI bit=
 can make
- * sense for virtual CAN interfaces to test applications with echoed f=
rames.
- */
-#define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload =
data) */
-#define CANFD_ESI 0x02 /* error state indicator of the transmitting no=
de */
-
-/**
- * struct canfd_frame - CAN flexible data rate frame structure
- * @can_id: CAN ID of the frame and CAN_*_FLAG flags, see canid_t defi=
nition
- * @len:    frame payload length in byte (0 .. CANFD_MAX_DLEN)
- * @flags:  additional flags for CAN FD
- * @__res0: reserved / padding
- * @__res1: reserved / padding
- * @data:   CAN FD frame payload (up to CANFD_MAX_DLEN byte)
- */
-struct canfd_frame {
-	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
-	__u8    len;     /* frame payload length in byte */
-	__u8    flags;   /* additional flags for CAN FD */
-	__u8    __res0;  /* reserved / padding */
-	__u8    __res1;  /* reserved / padding */
-	__u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
-};
-
-#define CAN_MTU		(sizeof(struct can_frame))
-#define CANFD_MTU	(sizeof(struct canfd_frame))
-
-/* particular protocols of the protocol family PF_CAN */
-#define CAN_RAW		1 /* RAW sockets */
-#define CAN_BCM		2 /* Broadcast Manager */
-#define CAN_TP16	3 /* VAG Transport Protocol v1.6 */
-#define CAN_TP20	4 /* VAG Transport Protocol v2.0 */
-#define CAN_MCNET	5 /* Bosch MCNet */
-#define CAN_ISOTP	6 /* ISO 15765-2 Transport Protocol */
-#define CAN_NPROTO	7
-
-#define SOL_CAN_BASE 100
-
-// typedef unsigned short __kernel_sa_family_t;
-// introduced in Linux 3.2 commit 6602a4baf4d1a73cc4685a39ef859e1c5ddf=
654c
-
-/**
- * struct sockaddr_can - the sockaddr structure for CAN sockets
- * @can_family:  address family number AF_CAN.
- * @can_ifindex: CAN network interface index.
- * @can_addr:    protocol specific address information
- */
-struct sockaddr_can {
-	sa_family_t can_family;
-//	__kernel_sa_family_t can_family;
-	int         can_ifindex;
-	union {
-		/* transport protocol class address information (e.g. ISOTP) */
-		struct { canid_t rx_id, tx_id; } tp;
-
-		/* reserved for future CAN protocols address information */
-	} can_addr;
-};
-
-/**
- * struct can_filter - CAN ID based filter in can_register().
- * @can_id:   relevant bits of CAN ID which are not masked out.
- * @can_mask: CAN mask (see description)
- *
- * Description:
- * A filter matches, when
- *
- *          <received_can_id> & mask =3D=3D can_id & mask
- *
- * The filter can be inverted (CAN_INV_FILTER bit set in can_id) or it=
 can
- * filter for error message frames (CAN_ERR_FLAG bit set in mask).
- */
-struct can_filter {
-	canid_t can_id;
-	canid_t can_mask;
-};
-
-#define CAN_INV_FILTER 0x20000000U /* to be set in can_filter.can_id *=
/
-
-#endif /* CAN_H */
diff --git a/include/socketcan/can/bcm.h b/include/socketcan/can/bcm.h
deleted file mode 100644
index f10af82..0000000
--- a/include/socketcan/can/bcm.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * socketcan/can/bcm.h
- *
- * Definitions for CAN Broadcast Manager (BCM)
- *
- * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
- * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
- * All rights reserved.
- *
- */
-
-#ifndef CAN_BCM_H
-#define CAN_BCM_H
-
-#include <linux/types.h>
-#include <linux/can.h>
-
-/**
- * struct bcm_msg_head - head of messages to/from the broadcast manage=
r
- * @opcode:    opcode, see enum below.
- * @flags:     special flags, see below.
- * @count:     number of frames to send before changing interval.
- * @ival1:     interval for the first @count frames.
- * @ival2:     interval for the following frames.
- * @can_id:    CAN ID of frames to be sent or received.
- * @nframes:   number of frames appended to the message head.
- * @frames:    array of CAN frames.
- */
-struct bcm_msg_head {
-	__u32 opcode;
-	__u32 flags;
-	__u32 count;
-	struct timeval ival1, ival2;
-	canid_t can_id;
-	__u32 nframes;
-	struct can_frame frames[0];
-};
-
-enum {
-	TX_SETUP =3D 1,	/* create (cyclic) transmission task */
-	TX_DELETE,	/* remove (cyclic) transmission task */
-	TX_READ,	/* read properties of (cyclic) transmission task */
-	TX_SEND,	/* send one CAN frame */
-	RX_SETUP,	/* create RX content filter subscription */
-	RX_DELETE,	/* remove RX content filter subscription */
-	RX_READ,	/* read properties of RX content filter subscription */
-	TX_STATUS,	/* reply to TX_READ request */
-	TX_EXPIRED,	/* notification on performed transmissions (count=3D0) */
-	RX_STATUS,	/* reply to RX_READ request */
-	RX_TIMEOUT,	/* cyclic message is absent */
-	RX_CHANGED	/* updated CAN frame (detected content change) */
-};
-
-#define SETTIMER            0x0001
-#define STARTTIMER          0x0002
-#define TX_COUNTEVT         0x0004
-#define TX_ANNOUNCE         0x0008
-#define TX_CP_CAN_ID        0x0010
-#define RX_FILTER_ID        0x0020
-#define RX_CHECK_DLC        0x0040
-#define RX_NO_AUTOTIMER     0x0080
-#define RX_ANNOUNCE_RESUME  0x0100
-#define TX_RESET_MULTI_IDX  0x0200
-#define RX_RTR_FRAME        0x0400
-
-#endif /* CAN_BCM_H */
diff --git a/include/socketcan/can/error.h b/include/socketcan/can/erro=
r.h
deleted file mode 100644
index b65c231..0000000
--- a/include/socketcan/can/error.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * socketcan/can/error.h
- *
- * Definitions of the CAN error messages to be filtered and passed to =
the user.
- *
- * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
- * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
- * All rights reserved.
- *
- */
-
-#ifndef CAN_ERROR_H
-#define CAN_ERROR_H
-
-#define CAN_ERR_DLC 8 /* dlc for error message frames */
-
-/* error class (mask) in can_id */
-#define CAN_ERR_TX_TIMEOUT   0x00000001U /* TX timeout (by netdevice d=
river) */
-#define CAN_ERR_LOSTARB      0x00000002U /* lost arbitration    / data=
[0]    */
-#define CAN_ERR_CRTL         0x00000004U /* controller problems / data=
[1]    */
-#define CAN_ERR_PROT         0x00000008U /* protocol violations / data=
[2..3] */
-#define CAN_ERR_TRX          0x00000010U /* transceiver status  / data=
[4]    */
-#define CAN_ERR_ACK          0x00000020U /* received no ACK on transmi=
ssion */
-#define CAN_ERR_BUSOFF       0x00000040U /* bus off */
-#define CAN_ERR_BUSERROR     0x00000080U /* bus error (may flood!) */
-#define CAN_ERR_RESTARTED    0x00000100U /* controller restarted */
-
-/* arbitration lost in bit ... / data[0] */
-#define CAN_ERR_LOSTARB_UNSPEC   0x00 /* unspecified */
-				      /* else bit number in bitstream */
-
-/* error status of CAN-controller / data[1] */
-#define CAN_ERR_CRTL_UNSPEC      0x00 /* unspecified */
-#define CAN_ERR_CRTL_RX_OVERFLOW 0x01 /* RX buffer overflow */
-#define CAN_ERR_CRTL_TX_OVERFLOW 0x02 /* TX buffer overflow */
-#define CAN_ERR_CRTL_RX_WARNING  0x04 /* reached warning level for RX =
errors */
-#define CAN_ERR_CRTL_TX_WARNING  0x08 /* reached warning level for TX =
errors */
-#define CAN_ERR_CRTL_RX_PASSIVE  0x10 /* reached error passive status =
RX */
-#define CAN_ERR_CRTL_TX_PASSIVE  0x20 /* reached error passive status =
TX */
-				      /* (at least one error counter exceeds */
-				      /* the protocol-defined level of 127)  */
-
-/* error in CAN protocol (type) / data[2] */
-#define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */
-#define CAN_ERR_PROT_BIT         0x01 /* single bit error */
-#define CAN_ERR_PROT_FORM        0x02 /* frame format error */
-#define CAN_ERR_PROT_STUFF       0x04 /* bit stuffing error */
-#define CAN_ERR_PROT_BIT0        0x08 /* unable to send dominant bit *=
/
-#define CAN_ERR_PROT_BIT1        0x10 /* unable to send recessive bit =
*/
-#define CAN_ERR_PROT_OVERLOAD    0x20 /* bus overload */
-#define CAN_ERR_PROT_ACTIVE      0x40 /* active error announcement */
-#define CAN_ERR_PROT_TX          0x80 /* error occurred on transmissio=
n */
-
-/* error in CAN protocol (location) / data[3] */
-#define CAN_ERR_PROT_LOC_UNSPEC  0x00 /* unspecified */
-#define CAN_ERR_PROT_LOC_SOF     0x03 /* start of frame */
-#define CAN_ERR_PROT_LOC_ID28_21 0x02 /* ID bits 28 - 21 (SFF: 10 - 3)=
 */
-#define CAN_ERR_PROT_LOC_ID20_18 0x06 /* ID bits 20 - 18 (SFF: 2 - 0 )=
*/
-#define CAN_ERR_PROT_LOC_SRTR    0x04 /* substitute RTR (SFF: RTR) */
-#define CAN_ERR_PROT_LOC_IDE     0x05 /* identifier extension */
-#define CAN_ERR_PROT_LOC_ID17_13 0x07 /* ID bits 17-13 */
-#define CAN_ERR_PROT_LOC_ID12_05 0x0F /* ID bits 12-5 */
-#define CAN_ERR_PROT_LOC_ID04_00 0x0E /* ID bits 4-0 */
-#define CAN_ERR_PROT_LOC_RTR     0x0C /* RTR */
-#define CAN_ERR_PROT_LOC_RES1    0x0D /* reserved bit 1 */
-#define CAN_ERR_PROT_LOC_RES0    0x09 /* reserved bit 0 */
-#define CAN_ERR_PROT_LOC_DLC     0x0B /* data length code */
-#define CAN_ERR_PROT_LOC_DATA    0x0A /* data section */
-#define CAN_ERR_PROT_LOC_CRC_SEQ 0x08 /* CRC sequence */
-#define CAN_ERR_PROT_LOC_CRC_DEL 0x18 /* CRC delimiter */
-#define CAN_ERR_PROT_LOC_ACK     0x19 /* ACK slot */
-#define CAN_ERR_PROT_LOC_ACK_DEL 0x1B /* ACK delimiter */
-#define CAN_ERR_PROT_LOC_EOF     0x1A /* end of frame */
-#define CAN_ERR_PROT_LOC_INTERM  0x12 /* intermission */
-
-/* error status of CAN-transceiver / data[4] */
-/*                                             CANH CANL */
-#define CAN_ERR_TRX_UNSPEC             0x00 /* 0000 0000 */
-#define CAN_ERR_TRX_CANH_NO_WIRE       0x04 /* 0000 0100 */
-#define CAN_ERR_TRX_CANH_SHORT_TO_BAT  0x05 /* 0000 0101 */
-#define CAN_ERR_TRX_CANH_SHORT_TO_VCC  0x06 /* 0000 0110 */
-#define CAN_ERR_TRX_CANH_SHORT_TO_GND  0x07 /* 0000 0111 */
-#define CAN_ERR_TRX_CANL_NO_WIRE       0x40 /* 0100 0000 */
-#define CAN_ERR_TRX_CANL_SHORT_TO_BAT  0x50 /* 0101 0000 */
-#define CAN_ERR_TRX_CANL_SHORT_TO_VCC  0x60 /* 0110 0000 */
-#define CAN_ERR_TRX_CANL_SHORT_TO_GND  0x70 /* 0111 0000 */
-#define CAN_ERR_TRX_CANL_SHORT_TO_CANH 0x80 /* 1000 0000 */
-
-/* controller specific additional information / data[5..7] */
-
-#endif /* CAN_ERROR_H */
diff --git a/include/socketcan/can/gw.h b/include/socketcan/can/gw.h
deleted file mode 100644
index f709809..0000000
--- a/include/socketcan/can/gw.h
+++ /dev/null
@@ -1,171 +0,0 @@
-/*
- * socketcan/can/gw.h
- *
- * Definitions for CAN frame Gateway/Router/Bridge
- *
- * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
- * Copyright (c) 2011 Volkswagen Group Electronic Research
- * All rights reserved.
- *
- */
-
-#ifndef CAN_GW_H
-#define CAN_GW_H
-
-#include <linux/types.h>
-#include <linux/can.h>
-
-struct rtcanmsg {
-	__u8  can_family;
-	__u8  gwtype;
-	__u16 flags;
-};
-
-/* CAN gateway types */
-enum {
-	CGW_TYPE_UNSPEC,
-	CGW_TYPE_CAN_CAN,	/* CAN->CAN routing */
-	__CGW_TYPE_MAX
-};
-
-#define CGW_TYPE_MAX (__CGW_TYPE_MAX - 1)
-
-/* CAN rtnetlink attribute definitions */
-enum {
-	CGW_UNSPEC,
-	CGW_MOD_AND,	/* CAN frame modification binary AND */
-	CGW_MOD_OR,	/* CAN frame modification binary OR */
-	CGW_MOD_XOR,	/* CAN frame modification binary XOR */
-	CGW_MOD_SET,	/* CAN frame modification set alternate values */
-	CGW_CS_XOR,	/* set data[] XOR checksum into data[index] */
-	CGW_CS_CRC8,	/* set data[] CRC8 checksum into data[index] */
-	CGW_HANDLED,	/* number of handled CAN frames */
-	CGW_DROPPED,	/* number of dropped CAN frames */
-	CGW_SRC_IF,	/* ifindex of source network interface */
-	CGW_DST_IF,	/* ifindex of destination network interface */
-	CGW_FILTER,	/* specify struct can_filter on source CAN device */
-	CGW_DELETED,	/* number of deleted CAN frames (see max_hops param) */
-	CGW_LIM_HOPS,	/* limit the number of hops of this specific rule */
-	__CGW_MAX
-};
-
-#define CGW_MAX (__CGW_MAX - 1)
-
-#define CGW_FLAGS_CAN_ECHO 0x01
-#define CGW_FLAGS_CAN_SRC_TSTAMP 0x02
-#define CGW_FLAGS_CAN_IIF_TX_OK 0x04
-
-#define CGW_MOD_FUNCS 4 /* AND OR XOR SET */
-
-/* CAN frame elements that are affected by curr. 3 CAN frame modificat=
ions */
-#define CGW_MOD_ID	0x01
-#define CGW_MOD_DLC	0x02
-#define CGW_MOD_DATA	0x04
-
-#define CGW_FRAME_MODS 3 /* ID DLC DATA */
-
-#define MAX_MODFUNCTIONS (CGW_MOD_FUNCS * CGW_FRAME_MODS)
-
-struct cgw_frame_mod {
-	struct can_frame cf;
-	__u8 modtype;
-} __attribute__((packed));
-
-#define CGW_MODATTR_LEN sizeof(struct cgw_frame_mod)
-
-struct cgw_csum_xor {
-	__s8 from_idx;
-	__s8 to_idx;
-	__s8 result_idx;
-	__u8 init_xor_val;
-} __attribute__((packed));
-
-struct cgw_csum_crc8 {
-	__s8 from_idx;
-	__s8 to_idx;
-	__s8 result_idx;
-	__u8 init_crc_val;
-	__u8 final_xor_val;
-	__u8 crctab[256];
-	__u8 profile;
-	__u8 profile_data[20];
-} __attribute__((packed));
-
-/* length of checksum operation parameters. idx =3D index in CAN frame=
 data[] */
-#define CGW_CS_XOR_LEN  sizeof(struct cgw_csum_xor)
-#define CGW_CS_CRC8_LEN  sizeof(struct cgw_csum_crc8)
-
-/* CRC8 profiles (compute CRC for additional data elements - see below=
) */
-enum {
-	CGW_CRC8PRF_UNSPEC,
-	CGW_CRC8PRF_1U8,	/* compute one additional u8 value */
-	CGW_CRC8PRF_16U8,	/* u8 value table indexed by data[1] & 0xF */
-	CGW_CRC8PRF_SFFID_XOR,	/* (can_id & 0xFF) ^ (can_id >> 8 & 0xFF) */
-	__CGW_CRC8PRF_MAX
-};
-
-#define CGW_CRC8PRF_MAX (__CGW_CRC8PRF_MAX - 1)
-
-/*
- * CAN rtnetlink attribute contents in detail
- *
- * CGW_XXX_IF (length 4 bytes):
- * Sets an interface index for source/destination network interfaces.
- * For the CAN->CAN gwtype the indices of _two_ CAN interfaces are man=
datory.
- *
- * CGW_FILTER (length 8 bytes):
- * Sets a CAN receive filter for the gateway job specified by the
- * struct can_filter described in include/linux/can.h
- *
- * CGW_MOD_(AND|OR|XOR|SET) (length 17 bytes):
- * Specifies a modification that's done to a received CAN frame before=
 it is
- * send out to the destination interface.
- *
- * <struct can_frame> data used as operator
- * <u8> affected CAN frame elements
- *
- * CGW_LIM_HOPS (length 1 byte):
- * Limit the number of hops of this specific rule. Usually the receive=
d CAN
- * frame can be processed as much as 'max_hops' times (which is given =
at module
- * load time of the can-gw module). This value is used to reduce the n=
umber of
- * possible hops for this gateway job to a value smaller then max_hops=
=2E
- *
- * CGW_CS_XOR (length 4 bytes):
- * Set a simple XOR checksum starting with an initial value into
- * data[result-idx] using data[start-idx] .. data[end-idx]
- *
- * The XOR checksum is calculated like this:
- *
- * xor =3D init_xor_val
- *
- * for (i =3D from_idx .. to_idx)
- *      xor ^=3D can_frame.data[i]
- *
- * can_frame.data[ result_idx ] =3D xor
- *
- * CGW_CS_CRC8 (length 282 bytes):
- * Set a CRC8 value into data[result-idx] using a given 256 byte CRC8 =
table,
- * a given initial value and a defined input data[start-idx] .. data[e=
nd-idx].
- * Finally the result value is XOR'ed with the final_xor_val.
- *
- * The CRC8 checksum is calculated like this:
- *
- * crc =3D init_crc_val
- *
- * for (i =3D from_idx .. to_idx)
- *      crc =3D crctab[ crc ^ can_frame.data[i] ]
- *
- * can_frame.data[ result_idx ] =3D crc ^ final_xor_val
- *
- * The calculated CRC may contain additional source data elements that=
 can be
- * defined in the handling of 'checksum profiles' e.g. shown in AUTOSA=
R specs
- * like http://www.autosar.org/download/R4.0/AUTOSAR_SWS_E2ELibrary.pd=
f
- * E.g. the profile_data[] may contain additional u8 values (called DA=
TA_IDs)
- * that are used depending on counter values inside the CAN frame data=
[].
- * So far only three profiles have been implemented for illustration.
- *
- * Remark: In general the attribute data is a linear buffer.
- *         Beware of sending unpacked or aligned structs!
- */
-
-#endif
diff --git a/include/socketcan/can/isotp.h b/include/socketcan/can/isot=
p.h
deleted file mode 100644
index 18d13d1..0000000
--- a/include/socketcan/can/isotp.h
+++ /dev/null
@@ -1,140 +0,0 @@
-/*
- * socketcan/can/isotp.h
- *
- * Definitions for isotp CAN sockets
- *
- * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
- * Copyright (c) 2008 Volkswagen Group Electronic Research
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyrigh=
t
- *    notice, this list of conditions and the following disclaimer in =
the
- *    documentation and/or other materials provided with the distribut=
ion.
- * 3. Neither the name of Volkswagen nor the names of its contributors
- *    may be used to endorse or promote products derived from this sof=
tware
- *    without specific prior written permission.
- *
- * Alternatively, provided that this notice is retained in full, this
- * software may be distributed under the terms of the GNU General
- * Public License ("GPL") version 2, in which case the provisions of t=
he
- * GPL apply INSTEAD OF those given above.
- *
- * The provided data structures and external interfaces from this code
- * are not restricted to be used by modules with a GPL compatible lice=
nse.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS F=
OR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGH=
T
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTA=
L,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF US=
E,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON A=
NY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
- *
- * Send feedback to <linux-can@vger.kernel.org>
- */
-
-#ifndef CAN_ISOTP_H
-#define CAN_ISOTP_H
-
-#include <linux/can.h>
-
-#define SOL_CAN_ISOTP (SOL_CAN_BASE + CAN_ISOTP)
-
-/* for socket options affecting the socket (not the global system) */
-
-#define CAN_ISOTP_OPTS		1	/* pass struct can_isotp_options */
-
-#define CAN_ISOTP_RECV_FC	2	/* pass struct can_isotp_fc_options */
-
-/* sockopts to force stmin timer values for protocol regression tests =
*/
-
-#define CAN_ISOTP_TX_STMIN	3	/* pass __u32 value in nano secs    */
-					/* use this time instead of value   */
-					/* provided in FC from the receiver */
-
-#define CAN_ISOTP_RX_STMIN	4	/* pass __u32 value in nano secs   */
-					/* ignore received CF frames which */
-					/* timestamps differ less than val */
-
-struct can_isotp_options {
-
-	__u32 flags;		/* set flags for isotp behaviour.	*/
-				/* __u32 value : flags see below	*/
-
-	__u32 frame_txtime;	/* frame transmission time (N_As/N_Ar)	*/
-				/* __u32 value : time in nano secs	*/
-
-	__u8  ext_address;	/* set address for extended addressing	*/
-				/* __u8 value : extended address	*/
-
-	__u8  txpad_content;	/* set content of padding byte (tx)	*/
-				/* __u8 value : content	on tx path	*/
-
-	__u8  rxpad_content;	/* set content of padding byte (rx)	*/
-				/* __u8 value : content	on rx path	*/
-};
-
-struct can_isotp_fc_options {
-
-	__u8  bs;		/* blocksize provided in FC frame	*/
-				/* __u8 value : blocksize. 0 =3D off	*/
-
-	__u8  stmin;		/* separation time provided in FC frame	*/
-				/* __u8 value :				*/
-				/* 0x00 - 0x7F : 0 - 127 ms		*/
-				/* 0x80 - 0xF0 : reserved		*/
-				/* 0xF1 - 0xF9 : 100 us - 900 us	*/
-				/* 0xFA - 0xFF : reserved		*/
-
-	__u8  wftmax;		/* max. number of wait frame transmiss.	*/
-				/* __u8 value : 0 =3D omit FC N_PDU WT	*/
-};
-
-
-/* flags for isotp behaviour */
-
-#define CAN_ISOTP_LISTEN_MODE	0x001	/* listen only (do not send FC) */
-#define CAN_ISOTP_EXTEND_ADDR	0x002	/* enable extended addressing */
-#define CAN_ISOTP_TX_PADDING	0x004	/* enable CAN frame padding tx path=
 */
-#define CAN_ISOTP_RX_PADDING	0x008	/* enable CAN frame padding rx path=
 */
-#define CAN_ISOTP_CHK_PAD_LEN	0x010	/* check received CAN frame paddin=
g */
-#define CAN_ISOTP_CHK_PAD_DATA	0x020	/* check received CAN frame paddi=
ng */
-#define CAN_ISOTP_HALF_DUPLEX	0x040	/* half duplex error state handlin=
g */
-#define CAN_ISOTP_FORCE_TXSTMIN	0x080	/* ignore stmin from received FC=
 */
-#define CAN_ISOTP_FORCE_RXSTMIN	0x100	/* ignore CFs depending on rx st=
min */
-
-
-/* default values */
-
-#define CAN_ISOTP_DEFAULT_FLAGS		0
-#define CAN_ISOTP_DEFAULT_EXT_ADDRESS	0x00
-#define CAN_ISOTP_DEFAULT_RXPAD_CONTENT	0x00
-#define CAN_ISOTP_DEFAULT_TXPAD_CONTENT	0x00
-#define CAN_ISOTP_DEFAULT_FRAME_TXTIME	0
-#define CAN_ISOTP_DEFAULT_RECV_BS	0
-#define CAN_ISOTP_DEFAULT_RECV_STMIN	0x00
-#define CAN_ISOTP_DEFAULT_RECV_WFTMAX	0
-
-/*
- * Remark on CAN_ISOTP_DEFAULT_RECV_* values:
- *
- * We can strongly assume, that the Linux Kernel implementation of
- * CAN_ISOTP is capable to run with BS=3D0, STmin=3D0 and WFTmax=3D0.
- * But as we like to be able to behave as a commonly available ECU,
- * these default settings can be changed via sockopts.
- * For that reason the STmin value is intentionally _not_ checked for
- * consistency and copied directly into the flow control (FC) frame.
- *
- */
-
-#endif
diff --git a/include/socketcan/can/netlink.h b/include/socketcan/can/ne=
tlink.h
deleted file mode 100644
index 9bb47e3..0000000
--- a/include/socketcan/can/netlink.h
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * socketcan/can/netlink.h
- *
- * Definitions for the CAN netlink interface
- *
- * Copyright (c) 2009 Wolfgang Grandegger <wg@grandegger.com>
- *
- */
-
-#ifndef CAN_NETLINK_H
-#define CAN_NETLINK_H
-
-#include <linux/types.h>
-
-/*
- * CAN bit-timing parameters
- *
- * For further information, please read chapter "8 BIT TIMING
- * REQUIREMENTS" of the "Bosch CAN Specification version 2.0"
- * at http://www.semiconductors.bosch.de/pdf/can2spec.pdf.
- */
-struct can_bittiming {
-	__u32 bitrate;		/* Bit-rate in bits/second */
-	__u32 sample_point;	/* Sample point in one-tenth of a percent */
-	__u32 tq;		/* Time quanta (TQ) in nanoseconds */
-	__u32 prop_seg;		/* Propagation segment in TQs */
-	__u32 phase_seg1;	/* Phase buffer segment 1 in TQs */
-	__u32 phase_seg2;	/* Phase buffer segment 2 in TQs */
-	__u32 sjw;		/* Synchronisation jump width in TQs */
-	__u32 brp;		/* Bit-rate prescaler */
-};
-
-/*
- * CAN harware-dependent bit-timing constant
- *
- * Used for calculating and checking bit-timing parameters
- */
-struct can_bittiming_const {
-	char name[16];		/* Name of the CAN controller hardware */
-	__u32 tseg1_min;	/* Time segement 1 =3D prop_seg + phase_seg1 */
-	__u32 tseg1_max;
-	__u32 tseg2_min;	/* Time segement 2 =3D phase_seg2 */
-	__u32 tseg2_max;
-	__u32 sjw_max;		/* Synchronisation jump width */
-	__u32 brp_min;		/* Bit-rate prescaler */
-	__u32 brp_max;
-	__u32 brp_inc;
-};
-
-/*
- * CAN clock parameters
- */
-struct can_clock {
-	__u32 freq;		/* CAN system clock frequency in Hz */
-};
-
-/*
- * CAN operational and error states
- */
-enum can_state {
-	CAN_STATE_ERROR_ACTIVE =3D 0,	/* RX/TX error count < 96 */
-	CAN_STATE_ERROR_WARNING,	/* RX/TX error count < 128 */
-	CAN_STATE_ERROR_PASSIVE,	/* RX/TX error count < 256 */
-	CAN_STATE_BUS_OFF,		/* RX/TX error count >=3D 256 */
-	CAN_STATE_STOPPED,		/* Device is stopped */
-	CAN_STATE_SLEEPING,		/* Device is sleeping */
-	CAN_STATE_MAX
-};
-
-/*
- * CAN bus error counters
- */
-struct can_berr_counter {
-	__u16 txerr;
-	__u16 rxerr;
-};
-
-/*
- * CAN controller mode
- */
-struct can_ctrlmode {
-	__u32 mask;
-	__u32 flags;
-};
-
-#define CAN_CTRLMODE_LOOPBACK		0x01	/* Loopback mode */
-#define CAN_CTRLMODE_LISTENONLY		0x02 	/* Listen-only mode */
-#define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
-#define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
-#define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
-
-/*
- * CAN device statistics
- */
-struct can_device_stats {
-	__u32 bus_error;	/* Bus errors */
-	__u32 error_warning;	/* Changes to error warning state */
-	__u32 error_passive;	/* Changes to error passive state */
-	__u32 bus_off;		/* Changes to bus off state */
-	__u32 arbitration_lost; /* Arbitration lost errors */
-	__u32 restarts;		/* CAN controller re-starts */
-};
-
-/*
- * CAN netlink interface
- */
-enum {
-	IFLA_CAN_UNSPEC,
-	IFLA_CAN_BITTIMING,
-	IFLA_CAN_BITTIMING_CONST,
-	IFLA_CAN_CLOCK,
-	IFLA_CAN_STATE,
-	IFLA_CAN_CTRLMODE,
-	IFLA_CAN_RESTART_MS,
-	IFLA_CAN_RESTART,
-	IFLA_CAN_BERR_COUNTER,
-	__IFLA_CAN_MAX
-};
-
-#define IFLA_CAN_MAX	(__IFLA_CAN_MAX - 1)
-
-#endif /* CAN_NETLINK_H */
diff --git a/include/socketcan/can/raw.h b/include/socketcan/can/raw.h
deleted file mode 100644
index c80bff0..0000000
--- a/include/socketcan/can/raw.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * socketcan/can/raw.h
- *
- * Definitions for raw CAN sockets
- *
- * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
- *          Urs Thuermann   <urs.thuermann@volkswagen.de>
- * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
- * All rights reserved.
- *
- */
-
-#ifndef CAN_RAW_H
-#define CAN_RAW_H
-
-#include <linux/can.h>
-
-#define SOL_CAN_RAW (SOL_CAN_BASE + CAN_RAW)
-
-/* for socket options affecting the socket (not the global system) */
-
-enum {
-	CAN_RAW_FILTER =3D 1,	/* set 0 .. n can_filter(s)          */
-	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
-	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
-	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
-	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
-};
-
-#endif
--=20
1.8.5.2

