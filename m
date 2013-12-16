From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 06/11] sllin: dlc in cache > 0 is the expected LIN frame length
Date: Mon, 16 Dec 2013 08:54:09 +0100
Message-ID: <1387180454-1738-7-git-send-email-alexander.stein@systec-electronic.com>
References: <2633616.0o8t6AGOQY@ws-stein>
 <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46053 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752676Ab3LPHzz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 02:55:55 -0500
In-Reply-To: <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

A cache entry should not be set to LIN_CACHE_RESPONSE if there is nothing
to reply from this node. A dlc set > 0 configures the expected length.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index 487b72a..c5e1749 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -768,7 +768,7 @@ static void sllin_slave_receive_buf(struct tty_struct *tty,
 
 			sl->lin_state = SLSTATE_ID_RECEIVED;
 			/* Is the length of data set in frame cache? */
-			if (sce->frame_fl & LIN_CACHE_RESPONSE) {
+			if (sce->dlc > 0) {
 				sl->rx_expect += sce->dlc + 1; /* + checksum */
 				sl->rx_len_unknown = false;
 				set_bit(SLF_MSGEVENT, &sl->flags);
-- 
1.8.3.2

