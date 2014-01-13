From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils v4 3/4] ioctl.h: drop unused header
Date: Mon, 13 Jan 2014 22:57:15 +0100
Message-ID: <1389650236-13542-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <52D45B4C.3070009@hartkopp.net>
 <1389650236-13542-1-git-send-email-u.kleine-koenig@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38567 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbaAMV5d (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 16:57:33 -0500
In-Reply-To: <1389650236-13542-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

This header doesn't exist in the Linux tree and it's unused by can-utils,
so drop it. As a side effect this fixes the last file not specifying any
license and/or copyright information.

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 GNUmakefile.am                |  1 -
 include/socketcan/can/ioctl.h | 99 -------------------------------------------
 2 files changed, 100 deletions(-)
 delete mode 100644 include/socketcan/can/ioctl.h

diff --git a/GNUmakefile.am b/GNUmakefile.am
index e3d7c8518884..761f7db26ad9 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -17,7 +17,6 @@ noinst_HEADERS = \
 	include/linux/can/isotp.h \
 	include/linux/can/netlink.h \
 	include/linux/can/raw.h \
-	include/socketcan/can/ioctl.h \
 	include/socketcan/can/isotp.h \
 
 
diff --git a/include/socketcan/can/ioctl.h b/include/socketcan/can/ioctl.h
deleted file mode 100644
index ab34e8918667..000000000000
--- a/include/socketcan/can/ioctl.h
+++ /dev/null
@@ -1,99 +0,0 @@
-
-/*
- * socketcan/can/ioctl.h
- *
- * Definitions for CAN controller setup (work in progress)
- *
- * $Id$
- *
- * Send feedback to <linux-can@vger.kernel.org>
- *
- */
-
-#ifndef CAN_IOCTL_H
-#define CAN_IOCTL_H
-
-#include <linux/sockios.h>
-
-/*
- * CAN bitrate
- */
-#define CAN_BITRATE_UNCONFIGURED	((__u32) 0xFFFFFFFFU)
-#define CAN_BITRATE_UNKNOWN		0
-#define CAN_BITRATE_DEFAULT		500000
-
-/*
- * CAN custom bit time
- */
-enum can_bittimes {
-	CAN_BITTIME_STD,
-	CAN_BITTIME_BTR
-};
-
-/* TSEG1 of controllers usually is a sum of synch_seg (always 1),
- * prop_seg and phase_seg1, TSEG2 = phase_seg2 */
-
-struct can_bittime_std {
-	__u32 brp;        /* baud rate prescaler */
-	__u8  prop_seg;   /* from 1 to 8 */
-	__u8  phase_seg1; /* from 1 to 8 */
-	__u8  phase_seg2; /* from 1 to 8 */
-	__u8  sjw:7;      /* from 1 to 4 */
-	__u8  sam:1;      /* 1 - enable triple sampling */
-};
-
-struct can_bittime_btr {
-	__u8  btr0;
-	__u8  btr1;
-};
-
-struct can_bittime {
-	enum can_bittimes type;
-	union {
-		struct can_bittime_std std;
-		struct can_bittime_btr btr;
-	};
-};
-
-/*
- * CAN mode
- */
-enum can_mode {
-	CAN_MODE_STOP = 0,
-	CAN_MODE_START,
-	CAN_MODE_SLEEP
-};
-
-/*
- * CAN controller mode
- */
-#define CAN_CTRLMODE_LOOPBACK   0x1
-#define CAN_CTRLMODE_LISTENONLY 0x2
-
-/*
- * CAN operational and error states
- */
-enum can_state {
-	CAN_STATE_ACTIVE = 0,
-	CAN_STATE_BUS_WARNING,
-	CAN_STATE_BUS_PASSIVE,
-	CAN_STATE_BUS_OFF,
-	CAN_STATE_STOPPED,
-	CAN_STATE_SLEEPING
-};
-
-/*
- * CAN device statistics
- */
-struct can_device_stats {
-	int error_warning;
-	int data_overrun;
-	int wakeup;
-	int bus_error;
-	int error_passive;
-	int arbitration_lost;
-	int restarts;
-	int bus_error_at_init;
-};
-
-#endif /* CAN_IOCTL_H */
-- 
1.8.5.2

