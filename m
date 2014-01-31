From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] Android.mk: canbusload: make use of libcan
Date: Fri, 31 Jan 2014 11:25:24 +0100
Message-ID: <1391163924-31563-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58956 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaAaKZ0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 05:25:26 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>

In commit

    2206f92 canbusload: Add exact CAN frame length calculation (including bitstuffing)

the function to calculate the can_frame_length was moved into a seperate file
(canframelen.c). This patch for the Android makefile adds canframelen.c to the
lib, too and lets canbusload link against the lib.

Cc: Yegor Yefremov <yegorslists@googlemail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Yegor,

can you please test if current master + this patch compiles again on Android?

regards,
Marc

 Android.mk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Android.mk b/Android.mk
index ffac957..1901197 100644
--- a/Android.mk
+++ b/Android.mk
@@ -11,7 +11,7 @@ PRIVATE_LOCAL_CFLAGS := -O2 -g -W -Wall		\
 
 include $(CLEAR_VARS)
 
-LOCAL_SRC_FILES := lib.c
+LOCAL_SRC_FILES := lib.c canframelen.c
 LOCAL_MODULE := libcan
 LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
@@ -86,6 +86,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := canbusload.c
 LOCAL_MODULE := canbusload
 LOCAL_MODULE_TAGS := optional
+LOCAL_STATIC_LIBRARIES := libcan
 LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
-- 
1.8.5.3

