From: yegorslists@googlemail.com
Subject: [PATCH] can-utils: fix local header path for AOSP build
Date: Fri,  1 Feb 2013 08:44:46 +0100
Message-ID: <1359704686-3040-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:47407 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab3BAILJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 Feb 2013 03:11:09 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Use path relative to the can-utils source code and to root of
the AOSP repository.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 Android.mk |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
 mode change 100644 => 100755 Android.mk

diff --git a/Android.mk b/Android.mk
old mode 100644
new mode 100755
index 9267ec4..56a80c1
--- a/Android.mk
+++ b/Android.mk
@@ -181,7 +181,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotpdump.c
 LOCAL_MODULE := isotpdump
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := -O2 -g -W -Wall
 
 include $(BUILD_EXECUTABLE)
@@ -195,7 +195,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotprecv.c
 LOCAL_MODULE := isotprecv
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := -O2 -g -W -Wall
 
 include $(BUILD_EXECUTABLE)
@@ -209,7 +209,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotpsend.c
 LOCAL_MODULE := isotpsend
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := -O2 -g -W -Wall
 
 include $(BUILD_EXECUTABLE)
@@ -223,7 +223,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotpserver.c
 LOCAL_MODULE := isotpserver
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := -O2 -g -W -Wall
 
 include $(BUILD_EXECUTABLE)
@@ -237,7 +237,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotpsniffer.c
 LOCAL_MODULE := isotpsniffer.c
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := -O2 -g -W -Wall
 
 include $(BUILD_EXECUTABLE)
@@ -251,7 +251,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotptun.c
 LOCAL_MODULE := isotptun
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := -O2 -g -W -Wall
 
 include $(BUILD_EXECUTABLE)
-- 
1.7.7

