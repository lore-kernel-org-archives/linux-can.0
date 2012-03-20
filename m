From: yegorslists@googlemail.com
Subject: [PATCH 1/2] can-utils: cleanup headers
Date: Tue, 20 Mar 2012 10:47:38 +0100
Message-ID: <1332236859-22204-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:55581 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab2CTJr4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Mar 2012 05:47:56 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

- add missing sys/socket.h: on some systems (like Android)
have SOCK_RAW definition directly in sys/socket.h

- use sys/wait.h instead if wait.h

- include termios.h explicitly (Android)

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 canlogserver.c |    2 +-
 canplayer.c    |    1 +
 cansend.c      |    1 +
 slcan_attach.c |    2 ++
 slcand.c       |    5 +++--
 slcanpty.c     |    1 +
 6 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/canlogserver.c b/canlogserver.c
index b5a9d73..b6fa403 100644
--- a/canlogserver.c
+++ b/canlogserver.c
@@ -55,6 +55,7 @@
 #include <time.h>
 
 #include <sys/time.h>
+#include <sys/wait.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
@@ -65,7 +66,6 @@
 #include <linux/can.h>
 #include <linux/can/raw.h>
 #include <signal.h>
-#include <wait.h>
 #include <errno.h>
 
 #include "lib.h"
diff --git a/canplayer.c b/canplayer.c
index ff05f0f..b0b6333 100644
--- a/canplayer.c
+++ b/canplayer.c
@@ -53,6 +53,7 @@
 #include <unistd.h>
 
 #include <net/if.h>
+#include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>
 #include <linux/can.h>
diff --git a/cansend.c b/cansend.c
index 5c71cfd..9be2163 100644
--- a/cansend.c
+++ b/cansend.c
@@ -52,6 +52,7 @@
 
 #include <net/if.h>
 #include <sys/ioctl.h>
+#include <sys/socket.h>
 
 #include <linux/can.h>
 #include <linux/can/raw.h>
diff --git a/slcan_attach.c b/slcan_attach.c
index b939a10..3d6846a 100644
--- a/slcan_attach.c
+++ b/slcan_attach.c
@@ -51,8 +51,10 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <getopt.h>
+#include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <net/if.h>
+#include <termios.h>
 
 #define LDISC_N_SLCAN 17 /* default slcan line discipline since Kernel 2.6.25 */
 
diff --git a/slcand.c b/slcand.c
index 334c718..2642405 100644
--- a/slcand.c
+++ b/slcand.c
@@ -44,14 +44,15 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <fcntl.h>
 #include <syslog.h>
 #include <errno.h>
 #include <pwd.h>
 #include <signal.h>
+#include <sys/socket.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 #include <net/if.h>
 
 /* default slcan line discipline since Kernel 2.6.25 */
diff --git a/slcanpty.c b/slcanpty.c
index ada6f3b..67dcf35 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -34,6 +34,7 @@
 #include <termios.h>
 
 #include <net/if.h>
+#include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-- 
1.7.7

