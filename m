From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 10/11] sllin: Add LIN ID to timeout frame
Date: Mon, 16 Dec 2013 08:54:13 +0100
Message-ID: <1387180454-1738-11-git-send-email-alexander.stein@systec-electronic.com>
References: <2633616.0o8t6AGOQY@ws-stein>
 <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46055 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752686Ab3LPHzz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 02:55:55 -0500
In-Reply-To: <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index c922b84..61c8134 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -517,6 +517,9 @@ static void sllin_master_receive_buf(struct tty_struct *tty,
  */
 static void sllin_report_error(struct sllin *sl, int err)
 {
+	unsigned char *lin_buff;
+	int lin_id;
+
 	switch (err) {
 	case LIN_ERR_CHECKSUM:
 		sl->dev->stats.rx_crc_errors++;
@@ -531,7 +534,9 @@ static void sllin_report_error(struct sllin *sl, int err)
 		break;
 	}
 
-	sllin_send_canfr(sl, 0 | CAN_EFF_FLAG |
+	lin_buff = (sl->lin_master) ? sl->tx_buff : sl->rx_buff;
+	lin_id = lin_buff[SLLIN_BUFF_ID] & LIN_ID_MASK;
+	sllin_send_canfr(sl, lin_id | CAN_EFF_FLAG |
 		(err & ~LIN_ID_MASK), NULL, 0);
 }
 
-- 
1.8.3.2

