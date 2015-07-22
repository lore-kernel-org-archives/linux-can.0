From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 1/2] log2asc: include sys/time.h
Date: Wed, 22 Jul 2015 20:59:27 +0200
Message-ID: <1437591568-19452-2-git-send-email-yegorslists@googlemail.com>
References: <1437591568-19452-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38306 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbbGVS75 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jul 2015 14:59:57 -0400
Received: by wibxm9 with SMTP id xm9so116395540wib.1
        for <linux-can@vger.kernel.org>; Wed, 22 Jul 2015 11:59:56 -0700 (PDT)
In-Reply-To: <1437591568-19452-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

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

