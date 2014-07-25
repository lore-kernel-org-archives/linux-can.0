From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] GNUmakefile.am: include canpump
Date: Fri, 25 Jul 2014 12:53:24 +0200
Message-ID: <1406285604-20942-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44456 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759993AbaGYKx2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 06:53:28 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch makes it possible to compile canpump with autotools, too.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 GNUmakefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/GNUmakefile.am b/GNUmakefile.am
index 27767e8..1381d20 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -38,6 +38,7 @@ bin_PROGRAMS = \
 	cangw \
 	canlogserver \
 	canplayer \
+	canpump \
 	cansend \
 	cansniffer \
 	isotpdump \
-- 
2.0.1

