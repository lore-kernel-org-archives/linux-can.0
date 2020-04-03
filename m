From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] net: can: remove "WITH Linux-syscall-note" from SPDX tag of C files
Date: Fri,  3 Apr 2020 16:37:41 +0900
Message-ID: <20200403073741.18352-1-masahiroy@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The "WITH Linux-syscall-note" exception is intended for UAPI headers.

See LICENSES/exceptions/Linux-syscall-note

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 net/can/bcm.c  | 2 +-
 net/can/gw.c   | 2 +-
 net/can/proc.c | 2 +-
 net/can/raw.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index c96fa0f33db3..d94b20933339 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
  * bcm.c - Broadcast Manager to filter/send (cyclic) CAN content
  *
diff --git a/net/can/gw.c b/net/can/gw.c
index 65d60c93af29..49b4e3d91ad6 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /* gw.c - CAN frame Gateway/Router/Bridge with netlink interface
  *
  * Copyright (c) 2019 Volkswagen Group Electronic Research
diff --git a/net/can/proc.c b/net/can/proc.c
index e6881bfc3ed1..a4eb06c9eb70 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
  * proc.c - procfs support for Protocol family CAN core module
  *
diff --git a/net/can/raw.c b/net/can/raw.c
index 59c039d73c6d..ab104cc18562 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /* raw.c - Raw sockets for protocol family CAN
  *
  * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
-- 
2.17.1
