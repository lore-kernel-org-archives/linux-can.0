From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 2/5] slcand: remove #define EXIT_FAILURE, EXIT_SUCCESS
Date: Fri, 19 Dec 2014 07:22:17 -0800
Message-ID: <1419002540-2208-3-git-send-email-jmmahler@gmail.com>
References: <1419002540-2208-1-git-send-email-jmmahler@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:50950 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbaLSPXJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 19 Dec 2014 10:23:09 -0500
Received: by mail-pd0-f178.google.com with SMTP id r10so1374238pdi.37
        for <linux-can@vger.kernel.org>; Fri, 19 Dec 2014 07:23:09 -0800 (PST)
In-Reply-To: <1419002540-2208-1-git-send-email-jmmahler@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>

slcand has #defines for EXIT_FAILURE and EXIT_SUCCESS but this is
unnecessary since they are already provided by stdlib.h.  Remove them.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 slcand.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/slcand.c b/slcand.c
index 55775da..c4c81c5 100644
--- a/slcand.c
+++ b/slcand.c
@@ -50,9 +50,6 @@
 /* The length of ttypath buffer */
 #define TTYPATH_LENGTH	64
 
-#define EXIT_SUCCESS 0
-#define EXIT_FAILURE 1
-
 /* UART flow control types */
 #define FLOW_NONE 0
 #define FLOW_HW 1
-- 
2.1.3

