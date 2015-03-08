From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] autotools: define N_SLCAN, if not already declared
Date: Sun,  8 Mar 2015 15:00:53 +0100
Message-ID: <1425823253-27821-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:45815 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbbCHOBN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 Mar 2015 10:01:13 -0400
Received: by wesu56 with SMTP id u56so1674138wes.12
        for <linux-can@vger.kernel.org>; Sun, 08 Mar 2015 07:01:12 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index 3b695d3..633ba81 100644
--- a/configure.ac
+++ b/configure.ac
@@ -83,6 +83,9 @@ AC_CHECK_DECL(PF_CAN,,
 AC_CHECK_DECL(AF_CAN,,
     [AC_DEFINE([AF_CAN], [PF_CAN], [AF_CAN])]
 )
+AC_CHECK_DECL(N_SLCAN,,
+    [AC_DEFINE([N_SLCAN], [17], [N_SLCAN])]
+)
 
 
 #
-- 
2.1.0

