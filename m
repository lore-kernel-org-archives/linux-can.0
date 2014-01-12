From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils v2 1/3] headers: use include/linux only for Linux kernel headers
Date: Sun, 12 Jan 2014 22:24:37 +0100
Message-ID: <1389561879-16729-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46340 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbaALVZf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jan 2014 16:25:35 -0500
In-Reply-To: <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>

Put headers from the Linux kernel (and only these) under include/linux.
Move the only remaining header into the project root and fix all
users.

This cleanup makes syncing the headers from Linux easier:

	cd $path_to_linux_repo
	make headers_install
	rsync -a --delete usr/include/linux/can* $path_to_can-utils/include/linux

This also syncs the Linux headers from v3.13-rc7 + commit "can: add
explicit copyrights to can userspace header" (which isn't applied yet);
the effective changes are:

 - add license to can.h, can/bcm.h, can/error.h, can/gw.h, can/netlink.h
   and can/raw.h
 - path adaptions: s;socketcan;linux; for include files
 - add #include <linux/version.h> (reason?)
 - use __kernel_sa_family_t instead of sa_family_t which requires
   <linux/socket.h from Linux 3.1 or later. Unfortunately this makes
   can-utils FTBFS on e.g. Debian squeeze. If this is an issue this
   could be fixed by adding something like:
   	#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 1, 0)
	typedef unsigned short __kernel_sa_family_t;
	#endif
   (Note, the comment in the old include/socketcan/can.h that
   6602a4baf4d1 (net: Make userland include of netlink.h more sane.) was
   introduced in Linux 3.2 is wrong, it hit mainline for 3.1-rc2.)
 - fix a small difference in a comment in can/gw.h introduced between
   ad7f44095ac3 (cangw: add an option for the per rule limitation of
   frame hops) in can-utils and 391ac1282dd7 (can: gw: add a per rule
   limitation of frame hops) in the Linux kernel.
 - remove two unused header files that #included non-existing headers.
---
 GNUmakefile.am                  |  13 +--
 include/linux/can.h             | 195 +++++++++++++++++++++++++++++++++++++-
 include/linux/can/bcm.h         |  99 ++++++++++++++++++-
 include/linux/can/core.h        |   1 -
 include/linux/can/dev.h         |   1 -
 include/linux/can/error.h       | 124 +++++++++++++++++++++++-
 include/linux/can/gw.h          | 204 +++++++++++++++++++++++++++++++++++++++-
 include/linux/can/isotp.h       |   1 -
 include/linux/can/netlink.h     | 131 +++++++++++++++++++++++++-
 include/linux/can/raw.h         |  63 ++++++++++++-
 include/socketcan/can.h         | 167 --------------------------------
 include/socketcan/can/bcm.h     |  66 -------------
 include/socketcan/can/error.h   |  91 ------------------
 include/socketcan/can/gw.h      | 171 ---------------------------------
 include/socketcan/can/isotp.h   | 110 ----------------------
 include/socketcan/can/netlink.h | 122 ------------------------
 include/socketcan/can/raw.h     |  30 ------
 isotp.h                         | 110 ++++++++++++++++++++++
 isotprecv.c                     |   2 +-
 isotpsend.c                     |   2 +-
 isotpserver.c                   |   2 +-
 isotpsniffer.c                  |   2 +-
 isotptun.c                      |   2 +-
 23 files changed, 927 insertions(+), 782 deletions(-)
 delete mode 100644 include/linux/can/core.h
 delete mode 100644 include/linux/can/dev.h
 delete mode 100644 include/linux/can/isotp.h
 delete mode 100644 include/socketcan/can.h
 delete mode 100644 include/socketcan/can/bcm.h
 delete mode 100644 include/socketcan/can/error.h
 delete mode 100644 include/socketcan/can/gw.h
 delete mode 100644 include/socketcan/can/isotp.h
 delete mode 100644 include/socketcan/can/netlink.h
 delete mode 100644 include/socketcan/can/raw.h
 create mode 100644 isotp.h

diff --git a/GNUmakefile.am b/GNUmakefile.am
index fc8f6e73e139..744875d80c52 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -8,25 +8,16 @@ LDADD = \
 	libcan.la
 
 noinst_HEADERS = \
+	isotp.h \
 	lib.h \
 	terminal.h \
+	include/linux/can.h \
 	include/linux/can/bcm.h \
-	include/linux/can/core.h \
-	include/linux/can/dev.h \
 	include/linux/can/error.h \
 	include/linux/can/gw.h \
-	include/linux/can.h \
-	include/linux/can/isotp.h \
 	include/linux/can/netlink.h \
 	include/linux/can/raw.h \
-	include/socketcan/can/bcm.h \
-	include/socketcan/can/error.h \
-	include/socketcan/can/gw.h \
-	include/socketcan/can.h \
 	include/socketcan/can/ioctl.h \
-	include/socketcan/can/isotp.h \
-	include/socketcan/can/netlink.h \
-	include/socketcan/can/raw.h
 
 
 noinst_LTLIBRARIES = \
diff --git a/include/linux/can.h b/include/linux/can.h
index 958a3f42eedf..5d9d1d140718 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -1 +1,194 @@
-#include <socketcan/can.h>
+/*
+ * linux/can.h
+ *
+ * Definitions for CAN network layer (socket addr / CAN frame / CAN filter)
+ *
+ * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ *          Urs Thuermann   <urs.thuermann@volkswagen.de>
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of the
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible license.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#ifndef CAN_H
+#define CAN_H
+
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
+ * bit 29	: error message frame flag (0 = data frame, 1 = error message)
+ * bit 30	: remote transmission request flag (1 = rtr frame)
+ * bit 31	: frame format flag (0 = standard 11 bit, 1 = extended 29 bit)
+ */
+typedef __u32 canid_t;
+
+#define CAN_SFF_ID_BITS		11
+#define CAN_EFF_ID_BITS		29
+
+/*
+ * Controller Area Network Error Message Frame Mask structure
+ *
+ * bit 0-28	: error class mask (see include/linux/can/error.h)
+ * bit 29-31	: set to zero
+ */
+typedef __u32 can_err_mask_t;
+
+/* CAN payload length and DLC definitions according to ISO 11898-1 */
+#define CAN_MAX_DLC 8
+#define CAN_MAX_DLEN 8
+
+/* CAN FD payload length and DLC definitions according to ISO 11898-7 */
+#define CANFD_MAX_DLC 15
+#define CANFD_MAX_DLEN 64
+
+/**
+ * struct can_frame - basic CAN frame structure
+ * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
+ * @can_dlc: frame payload length in byte (0 .. 8) aka data length code
+ *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
+ *           mapping of the 'data length code' to the real payload length
+ * @data:    CAN frame payload (up to 8 byte)
+ */
+struct can_frame {
+	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
+	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
+	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
+};
+
+/*
+ * defined bits for canfd_frame.flags
+ *
+ * The use of struct canfd_frame implies the Extended Data Length (EDL) bit to
+ * be set in the CAN frame bitstream on the wire. The EDL bit switch turns
+ * the CAN controllers bitstream processor into the CAN FD mode which creates
+ * two new options within the CAN FD frame specification:
+ *
+ * Bit Rate Switch - to indicate a second bitrate is/was used for the payload
+ * Error State Indicator - represents the error state of the transmitting node
+ *
+ * As the CANFD_ESI bit is internally generated by the transmitting CAN
+ * controller only the CANFD_BRS bit is relevant for real CAN controllers when
+ * building a CAN FD frame for transmission. Setting the CANFD_ESI bit can make
+ * sense for virtual CAN interfaces to test applications with echoed frames.
+ */
+#define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
+#define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
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
+/**
+ * struct sockaddr_can - the sockaddr structure for CAN sockets
+ * @can_family:  address family number AF_CAN.
+ * @can_ifindex: CAN network interface index.
+ * @can_addr:    protocol specific address information
+ */
+struct sockaddr_can {
+	__kernel_sa_family_t can_family;
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
+ *          <received_can_id> & mask == can_id & mask
+ *
+ * The filter can be inverted (CAN_INV_FILTER bit set in can_id) or it can
+ * filter for error message frames (CAN_ERR_FLAG bit set in mask).
+ */
+struct can_filter {
+	canid_t can_id;
+	canid_t can_mask;
+};
+
+#define CAN_INV_FILTER 0x20000000U /* to be set in can_filter.can_id */
+
+#endif /* CAN_H */
diff --git a/include/linux/can/bcm.h b/include/linux/can/bcm.h
index 6d61559ccb85..382251a1d214 100644
--- a/include/linux/can/bcm.h
+++ b/include/linux/can/bcm.h
@@ -1 +1,98 @@
-#include <socketcan/can/bcm.h>
+/*
+ * linux/can/bcm.h
+ *
+ * Definitions for CAN Broadcast Manager (BCM)
+ *
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of the
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible license.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#ifndef CAN_BCM_H
+#define CAN_BCM_H
+
+#include <linux/types.h>
+#include <linux/can.h>
+
+/**
+ * struct bcm_msg_head - head of messages to/from the broadcast manager
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
+	TX_SETUP = 1,	/* create (cyclic) transmission task */
+	TX_DELETE,	/* remove (cyclic) transmission task */
+	TX_READ,	/* read properties of (cyclic) transmission task */
+	TX_SEND,	/* send one CAN frame */
+	RX_SETUP,	/* create RX content filter subscription */
+	RX_DELETE,	/* remove RX content filter subscription */
+	RX_READ,	/* read properties of RX content filter subscription */
+	TX_STATUS,	/* reply to TX_READ request */
+	TX_EXPIRED,	/* notification on performed transmissions (count=0) */
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
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
deleted file mode 100644
index 620c88ddc5c5..000000000000
--- a/include/linux/can/core.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <socketcan/can/core.h>
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
deleted file mode 100644
index 91879859cdf6..000000000000
--- a/include/linux/can/dev.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <socketcan/can/dev.h>
diff --git a/include/linux/can/error.h b/include/linux/can/error.h
index a02b1cae3388..b63204545320 100644
--- a/include/linux/can/error.h
+++ b/include/linux/can/error.h
@@ -1 +1,123 @@
-#include <socketcan/can/error.h>
+/*
+ * linux/can/error.h
+ *
+ * Definitions of the CAN error messages to be filtered and passed to the user.
+ *
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of the
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible license.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#ifndef CAN_ERROR_H
+#define CAN_ERROR_H
+
+#define CAN_ERR_DLC 8 /* dlc for error message frames */
+
+/* error class (mask) in can_id */
+#define CAN_ERR_TX_TIMEOUT   0x00000001U /* TX timeout (by netdevice driver) */
+#define CAN_ERR_LOSTARB      0x00000002U /* lost arbitration    / data[0]    */
+#define CAN_ERR_CRTL         0x00000004U /* controller problems / data[1]    */
+#define CAN_ERR_PROT         0x00000008U /* protocol violations / data[2..3] */
+#define CAN_ERR_TRX          0x00000010U /* transceiver status  / data[4]    */
+#define CAN_ERR_ACK          0x00000020U /* received no ACK on transmission */
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
+#define CAN_ERR_CRTL_RX_WARNING  0x04 /* reached warning level for RX errors */
+#define CAN_ERR_CRTL_TX_WARNING  0x08 /* reached warning level for TX errors */
+#define CAN_ERR_CRTL_RX_PASSIVE  0x10 /* reached error passive status RX */
+#define CAN_ERR_CRTL_TX_PASSIVE  0x20 /* reached error passive status TX */
+				      /* (at least one error counter exceeds */
+				      /* the protocol-defined level of 127)  */
+
+/* error in CAN protocol (type) / data[2] */
+#define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */
+#define CAN_ERR_PROT_BIT         0x01 /* single bit error */
+#define CAN_ERR_PROT_FORM        0x02 /* frame format error */
+#define CAN_ERR_PROT_STUFF       0x04 /* bit stuffing error */
+#define CAN_ERR_PROT_BIT0        0x08 /* unable to send dominant bit */
+#define CAN_ERR_PROT_BIT1        0x10 /* unable to send recessive bit */
+#define CAN_ERR_PROT_OVERLOAD    0x20 /* bus overload */
+#define CAN_ERR_PROT_ACTIVE      0x40 /* active error announcement */
+#define CAN_ERR_PROT_TX          0x80 /* error occurred on transmission */
+
+/* error in CAN protocol (location) / data[3] */
+#define CAN_ERR_PROT_LOC_UNSPEC  0x00 /* unspecified */
+#define CAN_ERR_PROT_LOC_SOF     0x03 /* start of frame */
+#define CAN_ERR_PROT_LOC_ID28_21 0x02 /* ID bits 28 - 21 (SFF: 10 - 3) */
+#define CAN_ERR_PROT_LOC_ID20_18 0x06 /* ID bits 20 - 18 (SFF: 2 - 0 )*/
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
index f37dbf064458..844c8964bdfe 100644
--- a/include/linux/can/gw.h
+++ b/include/linux/can/gw.h
@@ -1 +1,203 @@
-#include <socketcan/can/gw.h>
+/*
+ * linux/can/gw.h
+ *
+ * Definitions for CAN frame Gateway/Router/Bridge
+ *
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ * Copyright (c) 2011 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of the
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible license.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
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
+/* CAN frame elements that are affected by curr. 3 CAN frame modifications */
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
+/* length of checksum operation parameters. idx = index in CAN frame data[] */
+#define CGW_CS_XOR_LEN  sizeof(struct cgw_csum_xor)
+#define CGW_CS_CRC8_LEN  sizeof(struct cgw_csum_crc8)
+
+/* CRC8 profiles (compute CRC for additional data elements - see below) */
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
+ * For the CAN->CAN gwtype the indices of _two_ CAN interfaces are mandatory.
+ *
+ * CGW_FILTER (length 8 bytes):
+ * Sets a CAN receive filter for the gateway job specified by the
+ * struct can_filter described in include/linux/can.h
+ *
+ * CGW_MOD_(AND|OR|XOR|SET) (length 17 bytes):
+ * Specifies a modification that's done to a received CAN frame before it is
+ * send out to the destination interface.
+ *
+ * <struct can_frame> data used as operator
+ * <u8> affected CAN frame elements
+ *
+ * CGW_LIM_HOPS (length 1 byte):
+ * Limit the number of hops of this specific rule. Usually the received CAN
+ * frame can be processed as much as 'max_hops' times (which is given at module
+ * load time of the can-gw module). This value is used to reduce the number of
+ * possible hops for this gateway rule to a value smaller then max_hops.
+ *
+ * CGW_CS_XOR (length 4 bytes):
+ * Set a simple XOR checksum starting with an initial value into
+ * data[result-idx] using data[start-idx] .. data[end-idx]
+ *
+ * The XOR checksum is calculated like this:
+ *
+ * xor = init_xor_val
+ *
+ * for (i = from_idx .. to_idx)
+ *      xor ^= can_frame.data[i]
+ *
+ * can_frame.data[ result_idx ] = xor
+ *
+ * CGW_CS_CRC8 (length 282 bytes):
+ * Set a CRC8 value into data[result-idx] using a given 256 byte CRC8 table,
+ * a given initial value and a defined input data[start-idx] .. data[end-idx].
+ * Finally the result value is XOR'ed with the final_xor_val.
+ *
+ * The CRC8 checksum is calculated like this:
+ *
+ * crc = init_crc_val
+ *
+ * for (i = from_idx .. to_idx)
+ *      crc = crctab[ crc ^ can_frame.data[i] ]
+ *
+ * can_frame.data[ result_idx ] = crc ^ final_xor_val
+ *
+ * The calculated CRC may contain additional source data elements that can be
+ * defined in the handling of 'checksum profiles' e.g. shown in AUTOSAR specs
+ * like http://www.autosar.org/download/R4.0/AUTOSAR_SWS_E2ELibrary.pdf
+ * E.g. the profile_data[] may contain additional u8 values (called DATA_IDs)
+ * that are used depending on counter values inside the CAN frame data[].
+ * So far only three profiles have been implemented for illustration.
+ *
+ * Remark: In general the attribute data is a linear buffer.
+ *         Beware of sending unpacked or aligned structs!
+ */
+
+#endif
diff --git a/include/linux/can/isotp.h b/include/linux/can/isotp.h
deleted file mode 100644
index c52850f4bdb2..000000000000
--- a/include/linux/can/isotp.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <socketcan/can/isotp.h>
diff --git a/include/linux/can/netlink.h b/include/linux/can/netlink.h
index 99425f95e49b..df944ed206a8 100644
--- a/include/linux/can/netlink.h
+++ b/include/linux/can/netlink.h
@@ -1 +1,130 @@
-#include <socketcan/can/netlink.h>
+/*
+ * linux/can/netlink.h
+ *
+ * Definitions for the CAN netlink interface
+ *
+ * Copyright (c) 2009 Wolfgang Grandegger <wg@grandegger.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
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
+	__u32 tseg1_min;	/* Time segement 1 = prop_seg + phase_seg1 */
+	__u32 tseg1_max;
+	__u32 tseg2_min;	/* Time segement 2 = phase_seg2 */
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
+	CAN_STATE_ERROR_ACTIVE = 0,	/* RX/TX error count < 96 */
+	CAN_STATE_ERROR_WARNING,	/* RX/TX error count < 128 */
+	CAN_STATE_ERROR_PASSIVE,	/* RX/TX error count < 256 */
+	CAN_STATE_BUS_OFF,		/* RX/TX error count >= 256 */
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
index 22a90e54968d..c7d8c334e0ce 100644
--- a/include/linux/can/raw.h
+++ b/include/linux/can/raw.h
@@ -1 +1,62 @@
-#include <socketcan/can/raw.h>
+/*
+ * linux/can/raw.h
+ *
+ * Definitions for raw CAN sockets
+ *
+ * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ *          Urs Thuermann   <urs.thuermann@volkswagen.de>
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of the
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible license.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
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
+	CAN_RAW_FILTER = 1,	/* set 0 .. n can_filter(s)          */
+	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
+	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
+	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
+	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
+};
+
+#endif
diff --git a/include/socketcan/can.h b/include/socketcan/can.h
deleted file mode 100644
index 8452f0ea8fca..000000000000
--- a/include/socketcan/can.h
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * socketcan/can.h
- *
- * Definitions for CAN network layer (socket addr / CAN frame / CAN filter)
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
- * bit 29	: error message frame flag (0 = data frame, 1 = error message)
- * bit 30	: remote transmission request flag (1 = rtr frame)
- * bit 31	: frame format flag (0 = standard 11 bit, 1 = extended 29 bit)
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
-/* CAN FD payload length and DLC definitions according to ISO 11898-7 */
-#define CANFD_MAX_DLC 15
-#define CANFD_MAX_DLEN 64
-
-/**
- * struct can_frame - basic CAN frame structure
- * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
- * @can_dlc: frame payload length in byte (0 .. 8) aka data length code
- *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
- *           mapping of the 'data length code' to the real payload length
- * @data:    CAN frame payload (up to 8 byte)
- */
-struct can_frame {
-	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
-	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
-	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
-};
-
-/*
- * defined bits for canfd_frame.flags
- *
- * The use of struct canfd_frame implies the Extended Data Length (EDL) bit to
- * be set in the CAN frame bitstream on the wire. The EDL bit switch turns
- * the CAN controllers bitstream processor into the CAN FD mode which creates
- * two new options within the CAN FD frame specification:
- *
- * Bit Rate Switch - to indicate a second bitrate is/was used for the payload
- * Error State Indicator - represents the error state of the transmitting node
- *
- * As the CANFD_ESI bit is internally generated by the transmitting CAN
- * controller only the CANFD_BRS bit is relevant for real CAN controllers when
- * building a CAN FD frame for transmission. Setting the CANFD_ESI bit can make
- * sense for virtual CAN interfaces to test applications with echoed frames.
- */
-#define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
-#define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
-
-/**
- * struct canfd_frame - CAN flexible data rate frame structure
- * @can_id: CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
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
-// introduced in Linux 3.2 commit 6602a4baf4d1a73cc4685a39ef859e1c5ddf654c
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
- *          <received_can_id> & mask == can_id & mask
- *
- * The filter can be inverted (CAN_INV_FILTER bit set in can_id) or it can
- * filter for error message frames (CAN_ERR_FLAG bit set in mask).
- */
-struct can_filter {
-	canid_t can_id;
-	canid_t can_mask;
-};
-
-#define CAN_INV_FILTER 0x20000000U /* to be set in can_filter.can_id */
-
-#endif /* CAN_H */
diff --git a/include/socketcan/can/bcm.h b/include/socketcan/can/bcm.h
deleted file mode 100644
index 10185e86a596..000000000000
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
-#include <socketcan/can.h>
-
-/**
- * struct bcm_msg_head - head of messages to/from the broadcast manager
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
-	TX_SETUP = 1,	/* create (cyclic) transmission task */
-	TX_DELETE,	/* remove (cyclic) transmission task */
-	TX_READ,	/* read properties of (cyclic) transmission task */
-	TX_SEND,	/* send one CAN frame */
-	RX_SETUP,	/* create RX content filter subscription */
-	RX_DELETE,	/* remove RX content filter subscription */
-	RX_READ,	/* read properties of RX content filter subscription */
-	TX_STATUS,	/* reply to TX_READ request */
-	TX_EXPIRED,	/* notification on performed transmissions (count=0) */
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
diff --git a/include/socketcan/can/error.h b/include/socketcan/can/error.h
deleted file mode 100644
index b65c2317b40a..000000000000
--- a/include/socketcan/can/error.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * socketcan/can/error.h
- *
- * Definitions of the CAN error messages to be filtered and passed to the user.
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
-#define CAN_ERR_TX_TIMEOUT   0x00000001U /* TX timeout (by netdevice driver) */
-#define CAN_ERR_LOSTARB      0x00000002U /* lost arbitration    / data[0]    */
-#define CAN_ERR_CRTL         0x00000004U /* controller problems / data[1]    */
-#define CAN_ERR_PROT         0x00000008U /* protocol violations / data[2..3] */
-#define CAN_ERR_TRX          0x00000010U /* transceiver status  / data[4]    */
-#define CAN_ERR_ACK          0x00000020U /* received no ACK on transmission */
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
-#define CAN_ERR_CRTL_RX_WARNING  0x04 /* reached warning level for RX errors */
-#define CAN_ERR_CRTL_TX_WARNING  0x08 /* reached warning level for TX errors */
-#define CAN_ERR_CRTL_RX_PASSIVE  0x10 /* reached error passive status RX */
-#define CAN_ERR_CRTL_TX_PASSIVE  0x20 /* reached error passive status TX */
-				      /* (at least one error counter exceeds */
-				      /* the protocol-defined level of 127)  */
-
-/* error in CAN protocol (type) / data[2] */
-#define CAN_ERR_PROT_UNSPEC      0x00 /* unspecified */
-#define CAN_ERR_PROT_BIT         0x01 /* single bit error */
-#define CAN_ERR_PROT_FORM        0x02 /* frame format error */
-#define CAN_ERR_PROT_STUFF       0x04 /* bit stuffing error */
-#define CAN_ERR_PROT_BIT0        0x08 /* unable to send dominant bit */
-#define CAN_ERR_PROT_BIT1        0x10 /* unable to send recessive bit */
-#define CAN_ERR_PROT_OVERLOAD    0x20 /* bus overload */
-#define CAN_ERR_PROT_ACTIVE      0x40 /* active error announcement */
-#define CAN_ERR_PROT_TX          0x80 /* error occurred on transmission */
-
-/* error in CAN protocol (location) / data[3] */
-#define CAN_ERR_PROT_LOC_UNSPEC  0x00 /* unspecified */
-#define CAN_ERR_PROT_LOC_SOF     0x03 /* start of frame */
-#define CAN_ERR_PROT_LOC_ID28_21 0x02 /* ID bits 28 - 21 (SFF: 10 - 3) */
-#define CAN_ERR_PROT_LOC_ID20_18 0x06 /* ID bits 20 - 18 (SFF: 2 - 0 )*/
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
index 56d3246d7348..000000000000
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
-#include <socketcan/can.h>
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
-/* CAN frame elements that are affected by curr. 3 CAN frame modifications */
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
-/* length of checksum operation parameters. idx = index in CAN frame data[] */
-#define CGW_CS_XOR_LEN  sizeof(struct cgw_csum_xor)
-#define CGW_CS_CRC8_LEN  sizeof(struct cgw_csum_crc8)
-
-/* CRC8 profiles (compute CRC for additional data elements - see below) */
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
- * For the CAN->CAN gwtype the indices of _two_ CAN interfaces are mandatory.
- *
- * CGW_FILTER (length 8 bytes):
- * Sets a CAN receive filter for the gateway job specified by the
- * struct can_filter described in include/linux/can.h
- *
- * CGW_MOD_(AND|OR|XOR|SET) (length 17 bytes):
- * Specifies a modification that's done to a received CAN frame before it is
- * send out to the destination interface.
- *
- * <struct can_frame> data used as operator
- * <u8> affected CAN frame elements
- *
- * CGW_LIM_HOPS (length 1 byte):
- * Limit the number of hops of this specific rule. Usually the received CAN
- * frame can be processed as much as 'max_hops' times (which is given at module
- * load time of the can-gw module). This value is used to reduce the number of
- * possible hops for this gateway job to a value smaller then max_hops.
- *
- * CGW_CS_XOR (length 4 bytes):
- * Set a simple XOR checksum starting with an initial value into
- * data[result-idx] using data[start-idx] .. data[end-idx]
- *
- * The XOR checksum is calculated like this:
- *
- * xor = init_xor_val
- *
- * for (i = from_idx .. to_idx)
- *      xor ^= can_frame.data[i]
- *
- * can_frame.data[ result_idx ] = xor
- *
- * CGW_CS_CRC8 (length 282 bytes):
- * Set a CRC8 value into data[result-idx] using a given 256 byte CRC8 table,
- * a given initial value and a defined input data[start-idx] .. data[end-idx].
- * Finally the result value is XOR'ed with the final_xor_val.
- *
- * The CRC8 checksum is calculated like this:
- *
- * crc = init_crc_val
- *
- * for (i = from_idx .. to_idx)
- *      crc = crctab[ crc ^ can_frame.data[i] ]
- *
- * can_frame.data[ result_idx ] = crc ^ final_xor_val
- *
- * The calculated CRC may contain additional source data elements that can be
- * defined in the handling of 'checksum profiles' e.g. shown in AUTOSAR specs
- * like http://www.autosar.org/download/R4.0/AUTOSAR_SWS_E2ELibrary.pdf
- * E.g. the profile_data[] may contain additional u8 values (called DATA_IDs)
- * that are used depending on counter values inside the CAN frame data[].
- * So far only three profiles have been implemented for illustration.
- *
- * Remark: In general the attribute data is a linear buffer.
- *         Beware of sending unpacked or aligned structs!
- */
-
-#endif
diff --git a/include/socketcan/can/isotp.h b/include/socketcan/can/isotp.h
deleted file mode 100644
index 6ba5ef1269f4..000000000000
--- a/include/socketcan/can/isotp.h
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * socketcan/can/isotp.h
- *
- * Definitions for isotp CAN sockets
- *
- * $Id$
- *
- * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
- * Copyright (c) 2008 Volkswagen Group Electronic Research
- * All rights reserved.
- *
- * Send feedback to <linux-can@vger.kernel.org>
- *
- */
-
-#ifndef CAN_ISOTP_H
-#define CAN_ISOTP_H
-
-#include <socketcan/can.h>
-
-#define SOL_CAN_ISOTP (SOL_CAN_BASE + CAN_ISOTP)
-
-/* for socket options affecting the socket (not the global system) */
-
-#define CAN_ISOTP_OPTS		1	/* pass struct can_isotp_options */
-
-#define CAN_ISOTP_RECV_FC	2	/* pass struct can_isotp_fc_options */
-
-/* sockopts to force stmin timer values for protocol regression tests */
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
-				/* __u8 value : blocksize. 0 = off	*/
-
-	__u8  stmin;		/* separation time provided in FC frame	*/
-				/* __u8 value :				*/
-				/* 0x00 - 0x7F : 0 - 127 ms		*/
-				/* 0x80 - 0xF0 : reserved		*/
-				/* 0xF1 - 0xF9 : 100 us - 900 us	*/
-				/* 0xFA - 0xFF : reserved		*/
-
-	__u8  wftmax;		/* max. number of wait frame transmiss.	*/
-				/* __u8 value : 0 = omit FC N_PDU WT	*/
-};
-
-
-/* flags for isotp behaviour */
-
-#define CAN_ISOTP_LISTEN_MODE	0x001	/* listen only (do not send FC) */
-#define CAN_ISOTP_EXTEND_ADDR	0x002	/* enable extended addressing */
-#define CAN_ISOTP_TX_PADDING	0x004	/* enable CAN frame padding tx path */
-#define CAN_ISOTP_RX_PADDING	0x008	/* enable CAN frame padding rx path */
-#define CAN_ISOTP_CHK_PAD_LEN	0x010	/* check received CAN frame padding */
-#define CAN_ISOTP_CHK_PAD_DATA	0x020	/* check received CAN frame padding */
-#define CAN_ISOTP_HALF_DUPLEX	0x040	/* half duplex error state handling */
-#define CAN_ISOTP_FORCE_TXSTMIN	0x080	/* ignore stmin from received FC */
-#define CAN_ISOTP_FORCE_RXSTMIN	0x100	/* ignore CFs depending on rx stmin */
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
- * CAN_ISOTP is capable to run with BS=0, STmin=0 and WFTmax=0.
- * But as we like to be able to behave as a commonly available ECU,
- * these default settings can be changed via sockopts.
- * For that reason the STmin value is intentionally _not_ checked for
- * consistency and copied directly into the flow control (FC) frame.
- *
- */
-
-#endif
diff --git a/include/socketcan/can/netlink.h b/include/socketcan/can/netlink.h
deleted file mode 100644
index 9bb47e31748e..000000000000
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
-	__u32 tseg1_min;	/* Time segement 1 = prop_seg + phase_seg1 */
-	__u32 tseg1_max;
-	__u32 tseg2_min;	/* Time segement 2 = phase_seg2 */
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
-	CAN_STATE_ERROR_ACTIVE = 0,	/* RX/TX error count < 96 */
-	CAN_STATE_ERROR_WARNING,	/* RX/TX error count < 128 */
-	CAN_STATE_ERROR_PASSIVE,	/* RX/TX error count < 256 */
-	CAN_STATE_BUS_OFF,		/* RX/TX error count >= 256 */
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
index ee683c58412b..000000000000
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
-#include <socketcan/can.h>
-
-#define SOL_CAN_RAW (SOL_CAN_BASE + CAN_RAW)
-
-/* for socket options affecting the socket (not the global system) */
-
-enum {
-	CAN_RAW_FILTER = 1,	/* set 0 .. n can_filter(s)          */
-	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
-	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
-	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
-	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
-};
-
-#endif
diff --git a/isotp.h b/isotp.h
new file mode 100644
index 000000000000..5499ca8e95c0
--- /dev/null
+++ b/isotp.h
@@ -0,0 +1,110 @@
+/*
+ * isotp.h
+ *
+ * Definitions for isotp CAN sockets
+ *
+ * $Id$
+ *
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ * Copyright (c) 2008 Volkswagen Group Electronic Research
+ * All rights reserved.
+ *
+ * Send feedback to <linux-can@vger.kernel.org>
+ *
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
+/* sockopts to force stmin timer values for protocol regression tests */
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
+				/* __u8 value : blocksize. 0 = off	*/
+
+	__u8  stmin;		/* separation time provided in FC frame	*/
+				/* __u8 value :				*/
+				/* 0x00 - 0x7F : 0 - 127 ms		*/
+				/* 0x80 - 0xF0 : reserved		*/
+				/* 0xF1 - 0xF9 : 100 us - 900 us	*/
+				/* 0xFA - 0xFF : reserved		*/
+
+	__u8  wftmax;		/* max. number of wait frame transmiss.	*/
+				/* __u8 value : 0 = omit FC N_PDU WT	*/
+};
+
+
+/* flags for isotp behaviour */
+
+#define CAN_ISOTP_LISTEN_MODE	0x001	/* listen only (do not send FC) */
+#define CAN_ISOTP_EXTEND_ADDR	0x002	/* enable extended addressing */
+#define CAN_ISOTP_TX_PADDING	0x004	/* enable CAN frame padding tx path */
+#define CAN_ISOTP_RX_PADDING	0x008	/* enable CAN frame padding rx path */
+#define CAN_ISOTP_CHK_PAD_LEN	0x010	/* check received CAN frame padding */
+#define CAN_ISOTP_CHK_PAD_DATA	0x020	/* check received CAN frame padding */
+#define CAN_ISOTP_HALF_DUPLEX	0x040	/* half duplex error state handling */
+#define CAN_ISOTP_FORCE_TXSTMIN	0x080	/* ignore stmin from received FC */
+#define CAN_ISOTP_FORCE_RXSTMIN	0x100	/* ignore CFs depending on rx stmin */
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
+ * CAN_ISOTP is capable to run with BS=0, STmin=0 and WFTmax=0.
+ * But as we like to be able to behave as a commonly available ECU,
+ * these default settings can be changed via sockopts.
+ * For that reason the STmin value is intentionally _not_ checked for
+ * consistency and copied directly into the flow control (FC) frame.
+ *
+ */
+
+#endif
diff --git a/isotprecv.c b/isotprecv.c
index 1c8f79c6f957..ad793be75119 100644
--- a/isotprecv.c
+++ b/isotprecv.c
@@ -53,7 +53,7 @@
 #include <sys/ioctl.h>
 
 #include <linux/can.h>
-#include <linux/can/isotp.h>
+#include "isotp.h"
 
 #define NO_CAN_ID 0xFFFFFFFFU
 
diff --git a/isotpsend.c b/isotpsend.c
index 3bb8282b2c50..8f2d96a38805 100644
--- a/isotpsend.c
+++ b/isotpsend.c
@@ -53,7 +53,7 @@
 #include <sys/ioctl.h>
 
 #include <linux/can.h>
-#include <linux/can/isotp.h>
+#include "isotp.h"
 
 #define NO_CAN_ID 0xFFFFFFFFU
 
diff --git a/isotpserver.c b/isotpserver.c
index 60b0a738c390..20c7c30a8492 100644
--- a/isotpserver.c
+++ b/isotpserver.c
@@ -73,7 +73,7 @@
 #include <netinet/in.h>
 
 #include <linux/can.h>
-#include <linux/can/isotp.h>
+#include "isotp.h"
 
 #define NO_CAN_ID 0xFFFFFFFFU
 
diff --git a/isotpsniffer.c b/isotpsniffer.c
index 84d39a2a9d46..fa5bdef33ba0 100644
--- a/isotpsniffer.c
+++ b/isotpsniffer.c
@@ -54,7 +54,7 @@
 #include <sys/ioctl.h>
 
 #include <linux/can.h>
-#include <linux/can/isotp.h>
+#include "isotp.h"
 #include "terminal.h"
 
 #define NO_CAN_ID 0xFFFFFFFFU
diff --git a/isotptun.c b/isotptun.c
index 77ee1d3cd539..bd62f4277f44 100644
--- a/isotptun.c
+++ b/isotptun.c
@@ -62,7 +62,7 @@
 #include <sys/ioctl.h>
 
 #include <linux/can.h>
-#include <linux/can/isotp.h>
+#include "isotp.h"
 #include <linux/if_tun.h>
 
 #define NO_CAN_ID 0xFFFFFFFFU
-- 
1.8.5.2

