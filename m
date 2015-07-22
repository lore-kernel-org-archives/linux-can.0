From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 2/2] Include linux/sockios.h to fix musl build
Date: Wed, 22 Jul 2015 20:59:28 +0200
Message-ID: <1437591568-19452-3-git-send-email-yegorslists@googlemail.com>
References: <1437591568-19452-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38398 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbbGVTAC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jul 2015 15:00:02 -0400
Received: by wibxm9 with SMTP id xm9so116398265wib.1
        for <linux-can@vger.kernel.org>; Wed, 22 Jul 2015 12:00:01 -0700 (PDT)
In-Reply-To: <1437591568-19452-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

Including <sys/ioctl.h> and <net/if.h> is not sufficient
to musl to find SIOCSIFNAME, so <linux/sockios.h> must be
included too.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 slcan_attach.c | 1 +
 slcand.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/slcan_attach.c b/slcan_attach.c
index ab8ff0a..485cbe3 100644
--- a/slcan_attach.c
+++ b/slcan_attach.c
@@ -52,6 +52,7 @@
 #include <net/if.h>
 #include <termios.h>
 #include <linux/tty.h>
+#include <linux/sockios.h>
 
 void print_usage(char *prg)
 {
diff --git a/slcand.c b/slcand.c
index e5e4752..e8c70e0 100644
--- a/slcand.c
+++ b/slcand.c
@@ -38,6 +38,7 @@
 #include <net/if.h>
 #include <termios.h>
 #include <linux/tty.h>
+#include <linux/sockios.h>
 
 /* Change this to whatever your daemon is called */
 #define DAEMON_NAME "slcand"
-- 
2.1.4

