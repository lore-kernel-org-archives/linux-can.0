From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/3] Makefile: add large file support (LFS)
Date: Wed, 26 Feb 2014 19:28:32 +0100
Message-ID: <1393439313-18030-3-git-send-email-mkl@pengutronix.de>
References: <1393439313-18030-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53109 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbaBZS2g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 13:28:36 -0500
In-Reply-To: <1393439313-18030-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

Large file support (LFS) in recent C libraries allows 32 bit applications to
create large files with file length values > 0x7FFFFFFF when the filesystem
supports it.

This patch adds large file support to the Makefile, if you don't want LFS use
the autotools version and call configure like this:

    ./configure --disable-largefile

Not-really-signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 7f5c129..c1a3165 100644
--- a/Makefile
+++ b/Makefile
@@ -47,6 +47,7 @@ CFLAGS    = -O2 -Wall -Wno-parentheses \
 	    -fno-strict-aliasing
 
 CPPFLAGS += -Iinclude \
+	    -D_FILE_OFFSET_BITS=64 \
 	    -DSO_RXQ_OVFL=40 \
 	    -DPF_CAN=29 \
 	    -DAF_CAN=PF_CAN
-- 
1.9.0.rc3

