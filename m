From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 11/11] sllin: Evaluate message upon break only if received at least a LIN ID
Date: Mon, 16 Dec 2013 08:54:14 +0100
Message-ID: <1387180454-1738-12-git-send-email-alexander.stein@systec-electronic.com>
References: <2633616.0o8t6AGOQY@ws-stein>
 <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46057 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752692Ab3LPHz4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 02:55:56 -0500
In-Reply-To: <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index 61c8134..8d7ad69 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -716,10 +716,12 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 		if (fp && *fp++) {
 			/*
 			 * If we don't know the length of the current message
-			 * we received the break of the next message.
-			 * Evaluate the previous one before continuing
+			 * and received at least the LIN ID, we received here
+			 * the break of the next message.
+			 * Evaluate the previous one before continuing.
 			 */
-			if (sl->rx_len_unknown == true)
+			if ((sl->rx_len_unknown == true) &&
+				(sl->rx_cnt >= SLLIN_BUFF_ID))
 			{
 				hrtimer_cancel(&sl->rx_timer);
 				sllin_slave_finish_rx_msg(sl);
-- 
1.8.3.2

