From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH 1/5] slcand: improve usage examples
Date: Fri, 19 Dec 2014 07:22:16 -0800
Message-ID: <1419002540-2208-2-git-send-email-jmmahler@gmail.com>
References: <1419002540-2208-1-git-send-email-jmmahler@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:51134 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbaLSPXG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 19 Dec 2014 10:23:06 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so1383549pad.15
        for <linux-can@vger.kernel.org>; Fri, 19 Dec 2014 07:23:05 -0800 (PST)
In-Reply-To: <1419002540-2208-1-git-send-email-jmmahler@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>

The examples in the usage of slcand use a 'ttyslcan0' device which
is an uncommon name.  Use a more common ttyUSB0 name which is seen
with CANUSB devices.  Also, add an example showing that /dev/ttyUSB0
can be use as well.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 slcand.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/slcand.c b/slcand.c
index d71ba4d..55775da 100644
--- a/slcand.c
+++ b/slcand.c
@@ -71,8 +71,9 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -F         (stay in foreground; no daemonize)\n");
 	fprintf(stderr, "         -h         (show this help page)\n");
 	fprintf(stderr, "\nExamples:\n");
-	fprintf(stderr, "slcand -o -c -f -s6 ttyslcan0\n");
-	fprintf(stderr, "slcand -o -c -f -s6 ttyslcan0 can0\n");
+	fprintf(stderr, "slcand -o -c -f -s6 ttyUSB0\n");
+	fprintf(stderr, "slcand -o -c -f -s6 ttyUSB0 can0\n");
+	fprintf(stderr, "slcand -o -c -f -s6 /dev/ttyUSB0\n");
 	fprintf(stderr, "\n");
 	exit(EXIT_FAILURE);
 }
-- 
2.1.3

