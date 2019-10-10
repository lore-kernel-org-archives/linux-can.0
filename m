From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 29/29] can: don't use deprecated license identifiers
Date: Thu, 10 Oct 2019 14:17:50 +0200
Message-ID: <20191010121750.27237-30-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Yegor Yefremov <yegorslists@googlemail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

The "GPL-2.0" license identifier changed to "GPL-2.0-only" in SPDX v3.0.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/uapi/linux/can.h         | 2 +-
 include/uapi/linux/can/bcm.h     | 2 +-
 include/uapi/linux/can/error.h   | 2 +-
 include/uapi/linux/can/gw.h      | 2 +-
 include/uapi/linux/can/j1939.h   | 2 +-
 include/uapi/linux/can/netlink.h | 2 +-
 include/uapi/linux/can/raw.h     | 2 +-
 include/uapi/linux/can/vxcan.h   | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 1e988fdeba34..6a6d2c7655ff 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * linux/can.h
  *
diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.h
index 0fb328d93148..dd2b925b09ac 100644
--- a/include/uapi/linux/can/bcm.h
+++ b/include/uapi/linux/can/bcm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * linux/can/bcm.h
  *
diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
index bfc4b5d22a5e..34633283de64 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * linux/can/error.h
  *
diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index 3aea5388c8e4..c2190bbe21d8 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * linux/can/gw.h
  *
diff --git a/include/uapi/linux/can/j1939.h b/include/uapi/linux/can/j1939.h
index c32325342d30..df6e821075c1 100644
--- a/include/uapi/linux/can/j1939.h
+++ b/include/uapi/linux/can/j1939.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
  * j1939.h
  *
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 1bc70d3a4d39..6f598b73839e 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 /*
  * linux/can/netlink.h
  *
diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index be3b36e7ff61..6a11d308eb5c 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * linux/can/raw.h
  *
diff --git a/include/uapi/linux/can/vxcan.h b/include/uapi/linux/can/vxcan.h
index 066812d118a2..4fa9d8777a07 100644
--- a/include/uapi/linux/can/vxcan.h
+++ b/include/uapi/linux/can/vxcan.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
 #ifndef _UAPI_CAN_VXCAN_H
 #define _UAPI_CAN_VXCAN_H
 
-- 
2.23.0
