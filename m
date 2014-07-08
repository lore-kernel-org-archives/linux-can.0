From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] Add missing header canframelen.h to noinst_HEADERS
Date: Tue,  8 Jul 2014 08:34:38 +0200
Message-ID: <1404801278-28351-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:40059 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752907AbaGHGhQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Jul 2014 02:37:16 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.148])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 0430E27A692
	for <linux-can@vger.kernel.org>; Tue,  8 Jul 2014 08:16:42 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

This is necessary so this header gets included when running make dist.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 GNUmakefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/GNUmakefile.am b/GNUmakefile.am
index 27767e8..e008c6d 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -8,6 +8,7 @@ LDADD = \
 	libcan.la
 
 noinst_HEADERS = \
+	canframelen.h \
 	lib.h \
 	terminal.h \
 	include/linux/can/bcm.h \
-- 
1.8.5.5

