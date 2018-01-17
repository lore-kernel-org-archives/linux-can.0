From: yegorslists@googlemail.com
Subject: [PATCH] Add Travis-CI support
Date: Wed, 17 Jan 2018 15:33:25 +0100
Message-ID: <1516199605-28980-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.visionsystems.de ([213.209.99.202]:45287 "EHLO
        mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeAQPAC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jan 2018 10:00:02 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: o.rempel@pengutronix.de, mkl@pengutronix.de, socketcan@hartkopp.net, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

This configuration performs build tests for GCC and Clang
compilers.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 .travis.yml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 0000000..0a7cfc4
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,24 @@
+language: c
+
+matrix:
+    include:
+        - os: linux
+          dist: trusty
+          sudo: required
+          compiler: gcc
+        - os: linux
+          dist: trusty
+          sudo: required
+          compiler: clang
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
+
+script: ./autogen.sh && ./configure && make
-- 
2.1.4

