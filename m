From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils v2 2/3] ioctl.h: drop unused header
Date: Sun, 12 Jan 2014 22:24:38 +0100
Message-ID: <1389561879-16729-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46348 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbaALV0V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jan 2014 16:26:21 -0500
In-Reply-To: <1389561879-16729-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>

This header doesn't exist in the Linux tree and it's unused by can-utils,
so drop it. As a side effect this fixes the last file not specifying any
license and/or copyright information.
---
 GNUmakefile.am                |  1 -
 include/socketcan/can/ioctl.h | 99 -------------------------------------------
 2 files changed, 100 deletions(-)
 delete mode 100644 include/socketcan/can/ioctl.h

diff --git a/GNUmakefile.am b/GNUmakefile.am
index 744875d80c52..d1a167c69588 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -17,7 +17,6 @@ noinst_HEADERS = \
 	include/linux/can/gw.h \
 	include/linux/can/netlink.h \
 	include/linux/can/raw.h \
-	include/socketcan/can/ioctl.h \
 
 
 noinst_LTLIBRARIES = \
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

