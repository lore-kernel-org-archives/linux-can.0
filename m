From: yegorslists@googlemail.com
Subject: [PATCH] can-utils: AOSP build clean up
Date: Wed, 10 Jul 2013 09:28:57 +0200
Message-ID: <1373441337-3016-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:38221 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196Ab3GJIib (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 10 Jul 2013 04:38:31 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Remove unneeded includes. Both AOSP and NDK builds tested.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 Android.mk |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Android.mk b/Android.mk
index 4cf664b..ffac957 100755
--- a/Android.mk
+++ b/Android.mk
@@ -13,7 +13,7 @@ include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := lib.c
 LOCAL_MODULE := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_STATIC_LIBRARY)
@@ -28,7 +28,7 @@ LOCAL_SRC_FILES := candump.c
 LOCAL_MODULE := candump
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -43,7 +43,7 @@ LOCAL_SRC_FILES := cansend.c
 LOCAL_MODULE := cansend
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -57,7 +57,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := bcmserver.c
 LOCAL_MODULE := bcmserver
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -72,7 +72,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := can-calc-bit-timing.c
 LOCAL_MODULE := can-calc-bit-timing
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -86,7 +86,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := canbusload.c
 LOCAL_MODULE := canbusload
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -100,7 +100,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := canfdtest.c
 LOCAL_MODULE := canfdtest
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -115,7 +115,7 @@ LOCAL_SRC_FILES := cangen.c
 LOCAL_MODULE := cangen
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -129,7 +129,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := cangw.c
 LOCAL_MODULE := cangw
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -144,7 +144,7 @@ LOCAL_SRC_FILES := canlogserver.c
 LOCAL_MODULE := canlogserver
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -159,7 +159,7 @@ LOCAL_SRC_FILES := canplayer.c
 LOCAL_MODULE := canplayer
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -173,7 +173,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := cansniffer.c
 LOCAL_MODULE := cansniffer
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -187,7 +187,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotpdump.c
 LOCAL_MODULE := isotpdump
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -201,7 +201,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotprecv.c
 LOCAL_MODULE := isotprecv
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -215,7 +215,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotpsend.c
 LOCAL_MODULE := isotpsend
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -229,7 +229,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotpserver.c
 LOCAL_MODULE := isotpserver
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -243,7 +243,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotpsniffer.c
 LOCAL_MODULE := isotpsniffer.c
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -257,7 +257,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := isotptun.c
 LOCAL_MODULE := isotptun
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -272,7 +272,7 @@ LOCAL_SRC_FILES := log2asc.c
 LOCAL_MODULE := log2asc
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -287,7 +287,7 @@ LOCAL_SRC_FILES := log2long.c
 LOCAL_MODULE := log2long
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -301,7 +301,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := slcan_attach.c
 LOCAL_MODULE := slcan_attach
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -315,7 +315,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := slcand.c
 LOCAL_MODULE := slcand
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
@@ -329,7 +329,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := slcanpty.c
 LOCAL_MODULE := slcanpty
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
 LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
-- 
1.7.7

