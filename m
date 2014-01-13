From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils v4 1/4] Remove two unused header files
Date: Mon, 13 Jan 2014 22:57:13 +0100
Message-ID: <1389650236-13542-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <52D45B4C.3070009@hartkopp.net>
 <1389650236-13542-1-git-send-email-u.kleine-koenig@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38555 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaAMV5Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 16:57:25 -0500
In-Reply-To: <1389650236-13542-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

These seem to have never been used. They entered can-utils in commit
77de10356fe0 (include: import kernel header files into tree) and already
back then only consisted in an #include of a non-existing file.

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 GNUmakefile.am           | 2 --
 include/linux/can/core.h | 1 -
 include/linux/can/dev.h  | 1 -
 3 files changed, 4 deletions(-)
 delete mode 100644 include/linux/can/core.h
 delete mode 100644 include/linux/can/dev.h

diff --git a/GNUmakefile.am b/GNUmakefile.am
index fc8f6e73e139..34a7740c9906 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -11,8 +11,6 @@ noinst_HEADERS = \
 	lib.h \
 	terminal.h \
 	include/linux/can/bcm.h \
-	include/linux/can/core.h \
-	include/linux/can/dev.h \
 	include/linux/can/error.h \
 	include/linux/can/gw.h \
 	include/linux/can.h \
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
deleted file mode 100644
index 620c88ddc5c5..000000000000
--- a/include/linux/can/core.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <socketcan/can/core.h>
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
deleted file mode 100644
index 91879859cdf6..000000000000
--- a/include/linux/can/dev.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <socketcan/can/dev.h>
-- 
1.8.5.2

