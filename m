From: yegorslists@googlemail.com
Subject: [PATCH] autotools: fix syntax error
Date: Fri,  7 Aug 2015 18:05:26 +0200
Message-ID: <1438963526-31603-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.visionsystems.de ([213.209.99.202]:50299 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932459AbbHGQgq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Aug 2015 12:36:46 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 633ba81..8b50fb7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,7 +20,7 @@ AC_PROG_CC
 LT_INIT(win32-dll)
 
 AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
-m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
+m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
 #
 # Checks for header files.
-- 
2.1.4

