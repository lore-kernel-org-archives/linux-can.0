From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v7 04/10] include/socketcan: prepare headers to be moved to include/linux
Date: Tue, 21 Jan 2014 13:59:58 +0100
Message-ID: <1390309204-19854-5-git-send-email-mkl@pengutronix.de>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44831 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbaAUNAK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 08:00:10 -0500
In-Reply-To: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch changes the include from the socketcan folder to the linux folder:

-#include <socketcan/can.h>
+#include <linux/can.h>

so that the socketcan folder can be eliminated in a later patch.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/socketcan/can/bcm.h   | 2 +-
 include/socketcan/can/gw.h    | 2 +-
 include/socketcan/can/isotp.h | 2 +-
 include/socketcan/can/raw.h   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/socketcan/can/bcm.h b/include/socketcan/can/bcm.h
index 10185e8..f10af82 100644
--- a/include/socketcan/can/bcm.h
+++ b/include/socketcan/can/bcm.h
@@ -13,7 +13,7 @@
 #define CAN_BCM_H
 
 #include <linux/types.h>
-#include <socketcan/can.h>
+#include <linux/can.h>
 
 /**
  * struct bcm_msg_head - head of messages to/from the broadcast manager
diff --git a/include/socketcan/can/gw.h b/include/socketcan/can/gw.h
index 56d3246..f709809 100644
--- a/include/socketcan/can/gw.h
+++ b/include/socketcan/can/gw.h
@@ -13,7 +13,7 @@
 #define CAN_GW_H
 
 #include <linux/types.h>
-#include <socketcan/can.h>
+#include <linux/can.h>
 
 struct rtcanmsg {
 	__u8  can_family;
diff --git a/include/socketcan/can/isotp.h b/include/socketcan/can/isotp.h
index 541369a..18d13d1 100644
--- a/include/socketcan/can/isotp.h
+++ b/include/socketcan/can/isotp.h
@@ -46,7 +46,7 @@
 #ifndef CAN_ISOTP_H
 #define CAN_ISOTP_H
 
-#include <socketcan/can.h>
+#include <linux/can.h>
 
 #define SOL_CAN_ISOTP (SOL_CAN_BASE + CAN_ISOTP)
 
diff --git a/include/socketcan/can/raw.h b/include/socketcan/can/raw.h
index ee683c5..c80bff0 100644
--- a/include/socketcan/can/raw.h
+++ b/include/socketcan/can/raw.h
@@ -13,7 +13,7 @@
 #ifndef CAN_RAW_H
 #define CAN_RAW_H
 
-#include <socketcan/can.h>
+#include <linux/can.h>
 
 #define SOL_CAN_RAW (SOL_CAN_BASE + CAN_RAW)
 
-- 
1.8.5.2

