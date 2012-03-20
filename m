From: yegorslists@googlemail.com
Subject: [PATCH 2/2] can-utils: add Makefile for Android build system
Date: Tue, 20 Mar 2012 10:47:39 +0100
Message-ID: <1332236859-22204-2-git-send-email-yegorslists@googlemail.com>
References: <1332236859-22204-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:55586 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab2CTJsI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Mar 2012 05:48:08 -0400
In-Reply-To: <1332236859-22204-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 Android.mk |  329 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 329 insertions(+), 0 deletions(-)
 create mode 100644 Android.mk

diff --git a/Android.mk b/Android.mk
new file mode 100644
index 0000000..172ec2e
--- /dev/null
+++ b/Android.mk
@@ -0,0 +1,329 @@
+LOCAL_PATH := $(call my-dir)
+
+#
+# canlib
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := lib.c
+LOCAL_MODULE := libcan
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_STATIC_LIBRARY)
+
+#
+# candump
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := candump.c
+LOCAL_MODULE := candump
+LOCAL_MODULE_TAGS := optional
+LOCAL_STATIC_LIBRARIES := libcan
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# cansend
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := cansend.c
+LOCAL_MODULE := cansend
+LOCAL_MODULE_TAGS := optional
+LOCAL_STATIC_LIBRARIES := libcan
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# bcmserver
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := bcmserver.c
+LOCAL_MODULE := bcmserver
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+
+#
+# can-calc-bit-timing
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := can-calc-bit-timing.c
+LOCAL_MODULE := can-calc-bit-timing
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# canbusload
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := canbusload.c
+LOCAL_MODULE := canbusload
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# canfdtest
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := canfdtest.c
+LOCAL_MODULE := canfdtest
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# cangen
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := cangen.c
+LOCAL_MODULE := cangen
+LOCAL_MODULE_TAGS := optional
+LOCAL_STATIC_LIBRARIES := libcan
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# cangw
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := cangw.c
+LOCAL_MODULE := cangw
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# canlogserver
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := canlogserver.c
+LOCAL_MODULE := canlogserver
+LOCAL_MODULE_TAGS := optional
+LOCAL_STATIC_LIBRARIES := libcan
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# canplayer
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := canplayer.c
+LOCAL_MODULE := canplayer
+LOCAL_MODULE_TAGS := optional
+LOCAL_STATIC_LIBRARIES := libcan
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# cansniffer
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := cansniffer.c
+LOCAL_MODULE := cansniffer
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# isotpdump
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := isotpdump.c
+LOCAL_MODULE := isotpdump
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# isotprecv
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := isotprecv.c
+LOCAL_MODULE := isotprecv
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# isotpsend
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := isotpsend.c
+LOCAL_MODULE := isotpsend
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# isotpserver
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := isotpserver.c
+LOCAL_MODULE := isotpserver
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# isotpsniffer
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := isotpsniffer.c
+LOCAL_MODULE := isotpsniffer.c
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# isotptun
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := isotptun.c
+LOCAL_MODULE := isotptun
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS) external/can-utils/include/
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# log2asc
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := log2asc.c
+LOCAL_MODULE := log2asc
+LOCAL_MODULE_TAGS := optional
+LOCAL_STATIC_LIBRARIES := libcan
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# log2long
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := log2long.c
+LOCAL_MODULE := log2long
+LOCAL_MODULE_TAGS := optional
+LOCAL_STATIC_LIBRARIES := libcan
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# slcan_attach
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := slcan_attach.c
+LOCAL_MODULE := slcan_attach
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# slcand
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := slcand.c
+LOCAL_MODULE := slcand
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
+
+#
+# slcanpty
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := slcanpty.c
+LOCAL_MODULE := slcanpty
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(KERNEL_HEADERS)
+LOCAL_CFLAGS := -O2 -g -W -Wall 
+
+include $(BUILD_EXECUTABLE)
-- 
1.7.7

