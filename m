From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 01/12] can: headers: make header files self contained
Date: Tue,  1 Sep 2015 11:29:04 +0200
Message-ID: <1441099755-8601-2-git-send-email-mkl@pengutronix.de>
References: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59762 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbbIAJ3T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 05:29:19 -0400
In-Reply-To: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds the missing #include-s to the dev.h and led.h, so that they can
be used without including further header files.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/dev.h | 3 ++-
 include/linux/can/led.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index c3a9c8fc60fa..56dcadd83716 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -14,9 +14,10 @@
 #define _CAN_DEV_H
 
 #include <linux/can.h>
-#include <linux/can/netlink.h>
 #include <linux/can/error.h>
 #include <linux/can/led.h>
+#include <linux/can/netlink.h>
+#include <linux/netdevice.h>
 
 /*
  * CAN mode
diff --git a/include/linux/can/led.h b/include/linux/can/led.h
index 146de4506d21..2746f7c2f87d 100644
--- a/include/linux/can/led.h
+++ b/include/linux/can/led.h
@@ -11,6 +11,7 @@
 
 #include <linux/if.h>
 #include <linux/leds.h>
+#include <linux/netdevice.h>
 
 enum can_led_event {
 	CAN_LED_EVENT_OPEN,
-- 
2.5.0

