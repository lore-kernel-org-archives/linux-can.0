From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/5] configure: enable silent rules if available
Date: Mon, 26 Nov 2012 21:44:46 +0100
Message-ID: <1353962689-18669-3-git-send-email-mkl@pengutronix.de>
References: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57743 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab2KZUov (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 15:44:51 -0500
In-Reply-To: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 configure.ac |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index dec8c8d..0a24e1a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -26,7 +26,7 @@ AC_PROG_LIBTOOL
 # LT_INIT(win32-dll)
 
 AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
-
+m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
 
 #
 # Checks for header files.
-- 
1.7.10.4

