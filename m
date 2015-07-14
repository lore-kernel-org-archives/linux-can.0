From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] log2asc: include sys/time.h
Date: Tue, 14 Jul 2015 21:38:36 +0200
Message-ID: <1436902716-31065-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34968 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbbGNTiw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jul 2015 15:38:52 -0400
Received: by wgjx7 with SMTP id x7so16679903wgj.2
        for <linux-can@vger.kernel.org>; Tue, 14 Jul 2015 12:38:51 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Yegor Yefremov <yegorslists@googlemail.com>

Without this patch compilation against musl C library
breaks, because struct timeval cannot be found.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 log2asc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/log2asc.c b/log2asc.c
index 29d13e8..8fb88a9 100644
--- a/log2asc.c
+++ b/log2asc.c
@@ -48,6 +48,7 @@
 #include <unistd.h>
 
 #include <net/if.h>
+#include <sys/time.h>
 #include <linux/can.h>
 
 #include "lib.h"
-- 
2.1.4

