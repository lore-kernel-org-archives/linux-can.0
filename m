From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RFC] libsocketcan: Fix return value for get{set}_link() function
Date: Mon,  3 Feb 2014 13:40:21 +0400
Message-ID: <1391420421-20930-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback1.mail.ru ([94.100.176.18]:54964 "EHLO
	fallback1.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaBCJky (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Feb 2014 04:40:54 -0500
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback1.mail.ru (mPOP.Fallback_MX) with ESMTP id B2EA433746E9
	for <linux-can@vger.kernel.org>; Mon,  3 Feb 2014 13:40:50 +0400 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

This patch makes return value negative when open_nl_sock() function
fail and removes excess labels.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 src/libsocketcan.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index 7a523d2..02714ae 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -508,20 +508,15 @@ static int do_get_nl_link(int fd, __u8 acquire, const char *name, void *res)
  */
 static int get_link(const char *name, __u8 acquire, void *res)
 {
-	int fd;
-	int err = -1;
+	int err, fd;
 
 	fd = open_nl_sock();
 	if (fd < 0)
-		goto err_out;
+		return -1;
 
 	err = do_get_nl_link(fd, acquire, name, res);
-	if (err < 0)
-		goto close_out;
-
-close_out:
 	close(fd);
-err_out:
+
 	return err;
 
 }
@@ -643,20 +638,15 @@ static int do_set_nl_link(int fd, __u8 if_state, const char *name,
  */
 static int set_link(const char *name, __u8 if_state, struct req_info *req_info)
 {
-	int fd;
-	int err = 0;
+	int err, fd;
 
 	fd = open_nl_sock();
 	if (fd < 0)
-		goto err_out;
+		return -1;
 
 	err = do_set_nl_link(fd, if_state, name, req_info);
-	if (err < 0)
-		goto close_out;
-
-close_out:
 	close(fd);
-err_out:
+
 	return err;
 }
 
-- 
1.8.3.2

