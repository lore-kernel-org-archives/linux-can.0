From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/3] configure: add checks for large file support (LFS)
Date: Wed, 26 Feb 2014 19:28:33 +0100
Message-ID: <1393439313-18030-4-git-send-email-mkl@pengutronix.de>
References: <1393439313-18030-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53111 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbaBZS2h (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 13:28:37 -0500
In-Reply-To: <1393439313-18030-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 configure.ac | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index 0a24e1a..2fa16ce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,6 +54,8 @@ AC_CHECK_HEADERS([ \
 # Checks for typedefs, structures, and compiler characteristics.
 #
 AC_C_INLINE
+AC_SYS_LARGEFILE
+AC_TYPE_OFF_T
 AC_TYPE_PID_T
 AC_TYPE_UINT64_T
 
-- 
1.9.0.rc3

