From: yegorslists@googlemail.com
Subject: [PATCH v2] can-utils: AOSP build improvements
Date: Mon, 18 Feb 2013 09:59:49 +0100
Message-ID: <1361177989-8648-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:51055 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab3BRJAO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 18 Feb 2013 04:00:14 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Add local headers and GCC flags for all can-utils targets.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 Android.mk |   84 ++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/Android.mk b/Android.mk
index 56a80c1..4cf664b 100755
--- a/Android.mk
+++ b/Android.mk
@@ -1,5 +1,10 @@
 LOCAL_PATH := $(call my-dir)
 
+PRIVATE_LOCAL_CFLAGS := -O2 -g -W -Wall		\
+			-DSO_RXQ_OVFL=40	\
+			-DPF_CAN=29		\
+			-DAF_CAN=PF_CAN
+
 #
 # canlib
 #
@@ -8,7 +13,8 @@ include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := lib.c
 LOCAL_MODULE := libcan
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_STATIC_LIBRARY)
 
@@ -22,8 +28,8 @@ LOCAL_SRC_FILES := candump.c
 LOCAL_MODULE := candump
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -37,8 +43,8 @@ LOCAL_SRC_FILES := cansend.c
 LOCAL_MODULE := cansend
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -51,8 +57,8 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := bcmserver.c
 LOCAL_MODULE := bcmserver
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -66,8 +72,8 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := can-calc-bit-timing.c
 LOCAL_MODULE := can-calc-bit-timing
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -80,8 +86,8 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := canbusload.c
 LOCAL_MODULE := canbusload
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -94,8 +100,8 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := canfdtest.c
 LOCAL_MODULE := canfdtest
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -109,8 +115,8 @@ LOCAL_SRC_FILES := cangen.c
 LOCAL_MODULE := cangen
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -123,8 +129,8 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := cangw.c
 LOCAL_MODULE := cangw
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -138,8 +144,8 @@ LOCAL_SRC_FILES := canlogserver.c
 LOCAL_MODULE := canlogserver
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -153,8 +159,8 @@ LOCAL_SRC_FILES := canplayer.c
 LOCAL_MODULE := canplayer
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -167,8 +173,8 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := cansniffer.c
 LOCAL_MODULE := cansniffer
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -182,7 +188,7 @@ LOCAL_SRC_FILES := isotpdump.c
 LOCAL_MODULE := isotpdump
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -196,7 +202,7 @@ LOCAL_SRC_FILES := isotprecv.c
 LOCAL_MODULE := isotprecv
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -210,7 +216,7 @@ LOCAL_SRC_FILES := isotpsend.c
 LOCAL_MODULE := isotpsend
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -224,7 +230,7 @@ LOCAL_SRC_FILES := isotpserver.c
 LOCAL_MODULE := isotpserver
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -238,7 +244,7 @@ LOCAL_SRC_FILES := isotpsniffer.c
 LOCAL_MODULE := isotpsniffer.c
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -252,7 +258,7 @@ LOCAL_SRC_FILES := isotptun.c
 LOCAL_MODULE := isotptun
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -266,8 +272,8 @@ LOCAL_SRC_FILES := log2asc.c
 LOCAL_MODULE := log2asc
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -281,8 +287,8 @@ LOCAL_SRC_FILES := log2long.c
 LOCAL_MODULE := log2long
 LOCAL_MODULE_TAGS := optional
 LOCAL_STATIC_LIBRARIES := libcan
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -295,8 +301,8 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := slcan_attach.c
 LOCAL_MODULE := slcan_attach
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -309,8 +315,8 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := slcand.c
 LOCAL_MODULE := slcand
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
 
@@ -323,7 +329,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := slcanpty.c
 LOCAL_MODULE := slcanpty
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
-LOCAL_CFLAGS := -O2 -g -W -Wall
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) $(LOCAL_PATH)/include/
+LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
 
 include $(BUILD_EXECUTABLE)
-- 
1.7.7

