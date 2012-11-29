From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/5] can: Kconfig: convert 'depends on CAN' into 'if CAN...endif' block
Date: Thu, 29 Nov 2012 14:58:07 +0100
Message-ID: <1354197491-31205-2-git-send-email-mkl@pengutronix.de>
References: <1354197491-31205-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42774 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2K2N6N (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 08:58:13 -0500
In-Reply-To: <1354197491-31205-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds an 'if CAN...endif' Block around all CAN symbols in
net/can/Kconfig. So the 'depends on CAN' dependencies can be removed.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig |    5 -----
 net/can/Kconfig         |    7 ++++---
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index b56bd9e..8088d8f 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -1,9 +1,7 @@
 menu "CAN Device Drivers"
-	depends on CAN
 
 config CAN_VCAN
 	tristate "Virtual Local CAN Interface (vcan)"
-	depends on CAN
 	---help---
 	  Similar to the network loopback devices, vcan offers a
 	  virtual local CAN interface.
@@ -13,7 +11,6 @@ config CAN_VCAN
 
 config CAN_SLCAN
 	tristate "Serial / USB serial CAN Adaptors (slcan)"
-	depends on CAN
 	---help---
 	  CAN driver for several 'low cost' CAN interfaces that are attached
 	  via serial lines or via USB-to-serial adapters using the LAWICEL
@@ -33,7 +30,6 @@ config CAN_SLCAN
 
 config CAN_DEV
 	tristate "Platform CAN drivers with Netlink support"
-	depends on CAN
 	default y
 	---help---
 	  Enables the common framework for platform CAN drivers with Netlink
@@ -133,7 +129,6 @@ source "drivers/net/can/softing/Kconfig"
 
 config CAN_DEBUG_DEVICES
 	bool "CAN devices debugging messages"
-	depends on CAN
 	---help---
 	  Say Y here if you want the CAN device drivers to produce a bunch of
 	  debug messages to the system log.  Select this if you are having
diff --git a/net/can/Kconfig b/net/can/Kconfig
index 0320069..0435fc4 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -16,9 +16,10 @@ menuconfig CAN
 	  If you want CAN support you should say Y here and also to the
 	  specific driver for your controller(s) below.
 
+if CAN
+
 config CAN_RAW
 	tristate "Raw CAN Protocol (raw access with CAN-ID filtering)"
-	depends on CAN
 	default N
 	---help---
 	  The raw CAN protocol option offers access to the CAN bus via
@@ -29,7 +30,6 @@ config CAN_RAW
 
 config CAN_BCM
 	tristate "Broadcast Manager CAN Protocol (with content filtering)"
-	depends on CAN
 	default N
 	---help---
 	  The Broadcast Manager offers content filtering, timeout monitoring,
@@ -42,7 +42,6 @@ config CAN_BCM
 
 config CAN_GW
 	tristate "CAN Gateway/Router (with netlink configuration)"
-	depends on CAN
 	default N
 	---help---
 	  The CAN Gateway/Router is used to route (and modify) CAN frames.
@@ -53,3 +52,5 @@ config CAN_GW
 	  by the netlink configuration interface known e.g. from iptables.
 
 source "drivers/net/can/Kconfig"
+
+endif
-- 
1.7.10.4

