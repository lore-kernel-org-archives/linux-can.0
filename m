From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/5] configure: adjust bug report address
Date: Mon, 26 Nov 2012 21:44:45 +0100
Message-ID: <1353962689-18669-2-git-send-email-mkl@pengutronix.de>
References: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57741 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756510Ab2KZUov (ORCPT
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
index 3ec20fb..dec8c8d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 AC_PREREQ(2.59)
 
-AC_INIT([can-utils], [trunk], [socketcan-core@lists.berlios.de])
+AC_INIT([can-utils], [trunk], [linux-can@vger.kernel.org])
 AC_CONFIG_SRCDIR([lib.c])
 AC_CONFIG_MACRO_DIR([config/m4])
 AC_CONFIG_AUX_DIR([config/autoconf])
-- 
1.7.10.4

