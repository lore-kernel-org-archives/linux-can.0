From: yegorslists@googlemail.com
Subject: [PATCH] slcand: include <sys/socket.h>
Date: Fri, 31 Jan 2014 11:54:09 +0100
Message-ID: <1391165649-5280-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:38631 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbaAaKy2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 05:54:28 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Linux build compiles without errors, but Android build
complains about undefined routines and macros.
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 slcand.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/slcand.c b/slcand.c
index 831e8c6..d71ba4d 100644
--- a/slcand.c
+++ b/slcand.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/socket.h>
 #include <fcntl.h>
 #include <syslog.h>
 #include <errno.h>
-- 
1.7.7

