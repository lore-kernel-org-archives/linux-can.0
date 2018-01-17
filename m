From: yegorslists@googlemail.com
Subject: [PATCH v2] Add Travis-CI support
Date: Wed, 17 Jan 2018 16:36:54 +0100
Message-ID: <1516203414-17498-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.visionsystems.de ([213.209.99.202]:36880 "EHLO
        mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753653AbeAQPhB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jan 2018 10:37:01 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: o.rempel@pengutronix.de, mkl@pengutronix.de, socketcan@hartkopp.net, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

This configuration performs build tests for GCC and Clang
compilers.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
Changes v1 -> v2:
  - add pure makefile build
  - use make distcheck for autotools based tests

 .travis.yml | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..4bf3a9e
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,34 @@
+language: c
+
+matrix:
+    include:
+        - env: test="x64 4.8.4 (make)"
+          os: linux
+          dist: trusty
+          sudo: required
+          compiler: gcc
+          script: make
+
+        - env: test="x64 4.8.4 (autotools)"
+          os: linux
+          dist: trusty
+          sudo: required
+          compiler: gcc
+          script: ./autogen.sh && ./configure && make distcheck
+
+        - env: test="x64 5.0 (autotools)"
+          os: linux
+          dist: trusty
+          sudo: required
+          compiler: clang
+          script: ./autogen.sh && ./configure && make distcheck
+
+addons:
+    apt:
+        packages:
+            - autoconf
+            - automake
+            - libtool
+            - m4
+        sources:
+            - ubuntu-toolchain-r-test
-- 
2.1.4

