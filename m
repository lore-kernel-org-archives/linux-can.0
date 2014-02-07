From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] libsocketcan: Remove excess goto's.
Date: Fri,  7 Feb 2014 13:21:27 +0400
Message-ID: <1391764887-9085-2-git-send-email-shc_work@mail.ru>
References: <1391764887-9085-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:36402 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaBGJVx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Feb 2014 04:21:53 -0500
Received: from smtp40.i.mail.ru (smtp40.i.mail.ru [94.100.177.100])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id 0EA5710C42854
	for <linux-can@vger.kernel.org>; Fri,  7 Feb 2014 13:21:49 +0400 (MSK)
In-Reply-To: <1391764887-9085-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 src/libsocketcan.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index 4e7842f..82d4505 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -706,7 +706,6 @@ int can_do_stop(const char *name)
 int can_do_restart(const char *name)
 {
 	struct req_info req;
-	int err = -1;
 	int state;
 	__u32 restart_ms;
 
@@ -714,31 +713,28 @@ int can_do_restart(const char *name)
 	if ((can_get_state(name, &state)) < 0) {
 		fprintf(stderr, "cannot get bustate, "
 			"something is seriously wrong\n");
-		goto err_out;
+		return -1;
 	} else if (state != CAN_STATE_BUS_OFF) {
 		fprintf(stderr,
 			"Device is not in BUS_OFF," " no use to restart\n");
-		goto err_out;
+		return -1;
 	}
 
 	if ((can_get_restart_ms(name, &restart_ms)) < 0) {
 		fprintf(stderr, "cannot get restart_ms, "
 			"something is seriously wrong\n");
-		goto err_out;
+		return -1;
 	} else if (restart_ms > 0) {
 		fprintf(stderr,
 			"auto restart with %ums interval is turned on,"
 			" no use to restart\n", restart_ms);
-		goto err_out;
+		return -1;
 	}
 
 	memset(&req, 0, sizeof(req));
 	req.restart = 1;
 
-	err = set_link(name, 0, &req);
-
-err_out:
-	return err;
+	return set_link(name, 0, &req);
 }
 
 /**
-- 
1.8.3.2

