From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] libsocketcan: Initialize stack variables properly
Date: Fri,  7 Feb 2014 13:21:26 +0400
Message-ID: <1391764887-9085-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:60255 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaBGJ0a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Feb 2014 04:26:30 -0500
Received: from smtp40.i.mail.ru (smtp40.i.mail.ru [94.100.177.100])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id 6AD154FEE6F3
	for <linux-can@vger.kernel.org>; Fri,  7 Feb 2014 13:26:28 +0400 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

Stack variables may have unpredictable data if it not initialized.
This patch adds the necessary cleanup stack variables.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 src/libsocketcan.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index 02714ae..4e7842f 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -705,6 +705,7 @@ int can_do_stop(const char *name)
  */
 int can_do_restart(const char *name)
 {
+	struct req_info req;
 	int err = -1;
 	int state;
 	__u32 restart_ms;
@@ -731,11 +732,10 @@ int can_do_restart(const char *name)
 		goto err_out;
 	}
 
-	struct req_info req_info = {
-		.restart = 1,
-	};
+	memset(&req, 0, sizeof(req));
+	req.restart = 1;
 
-	err = set_link(name, 0, &req_info);
+	err = set_link(name, 0, &req);
 
 err_out:
 	return err;
@@ -758,14 +758,16 @@ err_out:
  */
 int can_set_restart_ms(const char *name, __u32 restart_ms)
 {
-	struct req_info req_info = {
-		.restart_ms = restart_ms,
-	};
+	struct req_info req;
 
-	if (restart_ms == 0)
-		req_info.disable_autorestart = 1;
+	memset(&req, 0, sizeof(req));
+
+	if (restart_ms)
+		req.restart_ms = restart_ms;
+	else
+		req.disable_autorestart = 1;
 
-	return set_link(name, 0, &req_info);
+	return set_link(name, 0, &req);
 }
 
 /**
@@ -822,11 +824,12 @@ int can_set_restart_ms(const char *name, __u32 restart_ms)
 
 int can_set_ctrlmode(const char *name, struct can_ctrlmode *cm)
 {
-	struct req_info req_info = {
-		.ctrlmode = cm,
-	};
+	struct req_info req;
 
-	return set_link(name, 0, &req_info);
+	memset(&req, 0, sizeof(req));
+	req.ctrlmode = cm;
+
+	return set_link(name, 0, &req);
 }
 
 /**
@@ -869,11 +872,12 @@ int can_set_ctrlmode(const char *name, struct can_ctrlmode *cm)
 
 int can_set_bittiming(const char *name, struct can_bittiming *bt)
 {
-	struct req_info req_info = {
-		.bittiming = bt,
-	};
+	struct req_info req;
+
+	memset(&req, 0, sizeof(req));
+	req.bittiming = bt;
 
-	return set_link(name, 0, &req_info);
+	return set_link(name, 0, &req);
 }
 
 /**
-- 
1.8.3.2

