From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v7 06/10] include: fix paths mentioned in files
Date: Tue, 21 Jan 2014 14:00:00 +0100
Message-ID: <1390309204-19854-7-git-send-email-mkl@pengutronix.de>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44837 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbaAUNAK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 08:00:10 -0500
In-Reply-To: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch fixes paths mentioned in the files which are wrong now, due the move
of the files in the previous patch.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can.h         | 4 ++--
 include/linux/can/bcm.h     | 2 +-
 include/linux/can/error.h   | 2 +-
 include/linux/can/gw.h      | 2 +-
 include/linux/can/netlink.h | 2 +-
 include/linux/can/raw.h     | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/can.h b/include/linux/can.h
index 8452f0e..2f77ab3 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -1,5 +1,5 @@
 /*
- * socketcan/can.h
+ * linux/can.h
  *
  * Definitions for CAN network layer (socket addr / CAN frame / CAN filter)
  *
@@ -45,7 +45,7 @@ typedef __u32 canid_t;
 /*
  * Controller Area Network Error Message Frame Mask structure
  *
- * bit 0-28	: error class mask (see include/socketcan/can/error.h)
+ * bit 0-28	: error class mask (see include/linux/can/error.h)
  * bit 29-31	: set to zero
  */
 typedef __u32 can_err_mask_t;
diff --git a/include/linux/can/bcm.h b/include/linux/can/bcm.h
index f10af82..3ebe387 100644
--- a/include/linux/can/bcm.h
+++ b/include/linux/can/bcm.h
@@ -1,5 +1,5 @@
 /*
- * socketcan/can/bcm.h
+ * linux/can/bcm.h
  *
  * Definitions for CAN Broadcast Manager (BCM)
  *
diff --git a/include/linux/can/error.h b/include/linux/can/error.h
index b65c231..7b7148b 100644
--- a/include/linux/can/error.h
+++ b/include/linux/can/error.h
@@ -1,5 +1,5 @@
 /*
- * socketcan/can/error.h
+ * linux/can/error.h
  *
  * Definitions of the CAN error messages to be filtered and passed to the user.
  *
diff --git a/include/linux/can/gw.h b/include/linux/can/gw.h
index f709809..a9d4363 100644
--- a/include/linux/can/gw.h
+++ b/include/linux/can/gw.h
@@ -1,5 +1,5 @@
 /*
- * socketcan/can/gw.h
+ * linux/can/gw.h
  *
  * Definitions for CAN frame Gateway/Router/Bridge
  *
diff --git a/include/linux/can/netlink.h b/include/linux/can/netlink.h
index 9bb47e3..14966dd 100644
--- a/include/linux/can/netlink.h
+++ b/include/linux/can/netlink.h
@@ -1,5 +1,5 @@
 /*
- * socketcan/can/netlink.h
+ * linux/can/netlink.h
  *
  * Definitions for the CAN netlink interface
  *
diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
index c80bff0..a814062 100644
--- a/include/linux/can/raw.h
+++ b/include/linux/can/raw.h
@@ -1,5 +1,5 @@
 /*
- * socketcan/can/raw.h
+ * linux/can/raw.h
  *
  * Definitions for raw CAN sockets
  *
-- 
1.8.5.2

