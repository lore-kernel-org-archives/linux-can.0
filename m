From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v5 1/5] include: Remove two unused header files
Date: Thu, 16 Jan 2014 17:12:30 +0100
Message-ID: <1389888754-23013-2-git-send-email-mkl@pengutronix.de>
References: <1389888754-23013-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55315 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbaAPQMh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 11:12:37 -0500
In-Reply-To: <1389888754-23013-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

These seem to have never been used. They entered can-utils in commit
77de10356fe0 (include: import kernel header files into tree) and alread=
y
back then only consisted in an #include of a non-existing file.

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 GNUmakefile.am           | 2 --
 include/linux/can/core.h | 1 -
 include/linux/can/dev.h  | 1 -
 3 files changed, 4 deletions(-)
 delete mode 100644 include/linux/can/core.h
 delete mode 100644 include/linux/can/dev.h

diff --git a/GNUmakefile.am b/GNUmakefile.am
index fc8f6e7..34a7740 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -11,8 +11,6 @@ noinst_HEADERS =3D \
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
index 620c88d..0000000
--- a/include/linux/can/core.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <socketcan/can/core.h>
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
deleted file mode 100644
index 9187985..0000000
--- a/include/linux/can/dev.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <socketcan/can/dev.h>
--=20
1.8.5.2

